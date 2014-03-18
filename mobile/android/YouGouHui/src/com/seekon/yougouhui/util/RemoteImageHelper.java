package com.seekon.yougouhui.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;
import android.widget.ImageView;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;

/**
 * 远程图片加载类
 * 
 * @author undyliu
 * 
 */
public class RemoteImageHelper {

	private static final String TAG = RemoteImageHelper.class.getSimpleName();

	public static void loadImage(final ImageView imageView, final String filePath) {
		if (imageView == null || filePath == null || filePath.trim().length() == 0) {
			return;
		}

		String fileName = filePath;
		int pos = filePath.lastIndexOf("/");
		if (pos > -1) {
			fileName = filePath.substring(pos + 1, filePath.length());
		}

		if (FileHelper.fileExists(fileName)) {
			InputStream is = null;
			try {
				is = FileHelper.read(fileName);
				if (is != null) {
					imageView.setImageDrawable(Drawable.createFromStream(is, "src"));
					return;
				}
			} finally {
				FileHelper.closeInputStream(is);
			}

		}
		final String finalName = fileName;

		imageView.setImageResource(R.drawable.loading);
		Logger.debug(TAG, "Image file:" + filePath);

		final Handler handler = new Handler() {
			@Override
			public void handleMessage(Message message) {
				imageView.setImageDrawable((Drawable) message.obj);
			}
		};

		Runnable runnable = new Runnable() {
			public void run() {
				InputStream is = null;
				Drawable drawable = null;
				try {
					is = download(filePath);
					if (is != null) {
						//FileHelper.write(is, finalName);
						//is.close();
					}
					//is = FileHelper.read(finalName);
					// TODO:
					drawable = Drawable.createFromStream(is, "src");
					if (drawable != null) {

					}
				} catch (Exception e) {
					Logger.error(TAG, "Image download failed", e);
					drawable = imageView.getResources()
							.getDrawable(R.drawable.image_fail);
				} finally {
					FileHelper.closeInputStream(is);
				}

				Message msg = handler.obtainMessage(1, drawable);
				handler.sendMessage(msg);
			}
		};
		new Thread(runnable).start();

	}

	private static InputStream download(String filePath)
			throws MalformedURLException, IOException {
		String urlString = Const.SERVER_APP_URL + filePath;
		InputStream inputStream = (InputStream) new URL(urlString).getContent();
		return inputStream;
	}
}
