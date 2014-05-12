package com.seekon.yougouhui.func;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.ref.WeakReference;
import java.net.Socket;
import java.net.URI;
import java.net.UnknownHostException;
import java.util.Arrays;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.spi.IHeartbeatService;
import com.seekon.yougouhui.util.Logger;

/**
 * 用于检测服务器是否可用的心跳后台服务
 * 
 * @author undyliu
 * 
 */
public class HeartbeatService extends Service {
	private static final String TAG = HeartbeatService.class.getSimpleName();
	private static final long HEART_BEAT_RATE = 60 * 1000;

	private static String HOST = "223.203.193.239";// "192.168.1.21";//
	private static int PORT = 7072;
	
	static {
		HOST = URI.create(Const.SERVER_APP_URL).getHost();
		PORT = URI.create(Const.SERVER_APP_URL).getPort();
	}
	
	public static final String MESSAGE_ACTION = "org.feng.message_ACTION";
	public static final String HEART_BEAT_ACTION = "org.feng.heart_beat_ACTION";

	private ReadThread mReadThread;

	private LocalBroadcastManager mLocalBroadcastManager;

	private WeakReference<Socket> mSocket;

	// For heart Beat
	private Handler mHandler = new Handler();
	private Runnable heartBeatRunnable = new Runnable() {

		@Override
		public void run() {
			if (System.currentTimeMillis() - sendTime >= HEART_BEAT_RATE) {
				boolean isSuccess = sendMsg("");// 发送一个\r\n过去 如果发送失败，就重新初始化一个socket
				if (!isSuccess) {
					mHandler.removeCallbacks(heartBeatRunnable);
					mReadThread.release();
					releaseLastSocket(mSocket);
					new InitSocketThread().start();
				}
			}
			mHandler.postDelayed(this, HEART_BEAT_RATE);
		}
	};

	private long sendTime = 0L;
	private IHeartbeatService.Stub iHeartbeatService = new IHeartbeatService.Stub() {

		@Override
		public boolean sendMessage(String message) throws RemoteException {
			return sendMsg(message);
		}
	};

	@Override
	public IBinder onBind(Intent arg0) {
		return iHeartbeatService;
	}

	@Override
	public void onCreate() {
		super.onCreate();
		new InitSocketThread().start();
		mLocalBroadcastManager = LocalBroadcastManager.getInstance(this);
	}

	public boolean sendMsg(String msg) {
		if (null == mSocket || null == mSocket.get()) {
			return false;
		}
		Socket soc = mSocket.get();
		try {
			if (!soc.isClosed() && !soc.isOutputShutdown()) {
				OutputStream os = soc.getOutputStream();
				String message = msg + "\r\n";
				os.write(message.getBytes());
				os.flush();
				sendTime = System.currentTimeMillis();// 每次发送成数据，就改一下最后成功发送的时间，节省心跳间隔时间
			} else {
				return false;
			}
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	private void initSocket() {// 初始化Socket
		try {
			Socket so = new Socket(HOST, PORT);
			mSocket = new WeakReference<Socket>(so);
			mReadThread = new ReadThread(so);
			mReadThread.start();
			mHandler.postDelayed(heartBeatRunnable, HEART_BEAT_RATE);// 初始化成功后，就准备发送心跳包
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void releaseLastSocket(WeakReference<Socket> mSocket) {
		try {
			if (null != mSocket) {
				Socket sk = mSocket.get();
				if (!sk.isClosed()) {
					sk.close();
				}
				sk = null;
				mSocket = null;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	class InitSocketThread extends Thread {
		@Override
		public void run() {
			super.run();
			initSocket();
		}
	}

	// Thread to read content from Socket
	class ReadThread extends Thread {
		private WeakReference<Socket> mWeakSocket;
		private boolean isStart = true;

		public ReadThread(Socket socket) {
			mWeakSocket = new WeakReference<Socket>(socket);
		}

		public void release() {
			isStart = false;
			releaseLastSocket(mWeakSocket);
		}

		@Override
		public void run() {
			super.run();
			Socket socket = mWeakSocket.get();
			if (null != socket) {
				try {
					InputStream is = socket.getInputStream();
					byte[] buffer = new byte[1024 * 4];
					int length = 0;
					while (!socket.isClosed() && !socket.isInputShutdown() && isStart
							&& ((length = is.read(buffer)) != -1)) {
						if (length > 0) {
							String message = new String(Arrays.copyOf(buffer, length)).trim();
							Log.e(TAG, message);
							// 收到服务器过来的消息，就通过Broadcast发送出去
							if (message.equals("ok")) {// 处理心跳回复
								Intent intent = new Intent(HEART_BEAT_ACTION);
								mLocalBroadcastManager.sendBroadcast(intent);
							} else {
								// 其他消息回复
								Intent intent = new Intent(MESSAGE_ACTION);
								intent.putExtra("message", message);
								mLocalBroadcastManager.sendBroadcast(intent);
							}
						}
					}
				} catch (IOException e) {
					Logger.error(TAG, e.getMessage(), e);
				}
			}
		}
	}

}
