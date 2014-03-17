package com.seekon.yougouhui.func.mess;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.ResultReceiver;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.service.RequestServiceHelper;
import com.seekon.yougouhui.service.ServiceConst;

public class MessageServiceHelper extends RequestServiceHelper{

	public static String CHANNEL_REQUEST_RESULT = "CHANNEL_REQUEST_RESULT";
	
	public static String SUBCHANNEL_REQUEST_RESULT = "SUBCHANNEL_REQUEST_RESULT";
	
	public static String MESSAGE_REQUEST_RESULT = "MESSAGE_REQUEST_RESULT";
	
	private static final String HASH_KEY_CHANNEL = "CHANNEL";
	
	private static final String HASH_KEY_MESSAGE = "MESSAGE";
	
	private static MessageServiceHelper instance = null;
	
	private static Object lock = new Object();
	
	private MessageServiceHelper(Context context) {
		super(context);
	}
	
	public static MessageServiceHelper getInstance(Context context){
		synchronized (lock) {
			if(instance == null){
				instance = new MessageServiceHelper(context);
			}
		}
		return instance;
	}
	
	public long getChannels(String parentId, final String broadcastIntentAction){
		if(requests.containsKey(HASH_KEY_CHANNEL)){
			return requests.get(HASH_KEY_CHANNEL);
		}
		
		long requestId = this.generateRequestID();
		requests.put(HASH_KEY_CHANNEL, requestId);
		
		ResultReceiver serviceCallback = new ResultReceiver(null){
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction, HASH_KEY_CHANNEL);
			}
		};
		
		Intent intent = new Intent(this.context, MessageService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.RESOURCE_TYPE_EXTRA, MessageService.RESOURCE_TYPE_CHANNEL);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(DataConst.COL_NAME_PARENT_ID, parentId);
		
		this.context.startService(intent);
		
		return requestId;
	}
	

	public long getMessages(String channelId, final String broadcastIntentAction){
		if(requests.containsKey(HASH_KEY_MESSAGE)){
			return requests.get(HASH_KEY_MESSAGE);
		}
		
		long requestId = this.generateRequestID();
		requests.put(HASH_KEY_MESSAGE, requestId);
		
		ResultReceiver serviceCallback = new ResultReceiver(null){
			@Override
			protected void onReceiveResult(int resultCode, Bundle resultData) {
				handleResponse(resultCode, resultData, broadcastIntentAction, HASH_KEY_MESSAGE);
			}
		};
		
		Intent intent = new Intent(this.context, MessageService.class);
		intent.putExtra(ServiceConst.METHOD_EXTRA, ServiceConst.METHOD_GET);
		intent.putExtra(ServiceConst.RESOURCE_TYPE_EXTRA, MessageService.RESOURCE_TYPE_MESSAGE);
		intent.putExtra(ServiceConst.SERVICE_CALLBACK, serviceCallback);
		intent.putExtra(REQUEST_ID, requestId);
		intent.putExtra(MessageConst.COL_NAME_CHANNEL_ID, channelId);
		
		this.context.startService(intent);
		
		return requestId;
	}
}
