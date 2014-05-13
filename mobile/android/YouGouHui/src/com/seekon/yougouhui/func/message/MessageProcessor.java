package com.seekon.yougouhui.func.message;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.SyncSupportProcessor;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.shop.ShopProvider;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.spi.IMessageProcessor;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorProxy;

public class MessageProcessor extends SyncSupportProcessor implements
		IMessageProcessor {

	private static IMessageProcessor instance = null;
	private static Object lock = new Object();

	public static IMessageProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IMessageProcessor) proxy
						.bind(new MessageProcessor(mContext));
			}
		}
		return instance;
	}

	private MessageProcessor(Context mContext) {
		super(mContext, MessageData.COL_NAMES, MessageConst.CONTENT_URI,
				MessageConst.TABLE_NAME);
	}

	@Override
	public RestMethodResult<JSONObjResource> sendMessage(UserEntity sender,
			UserEntity receiver, String content) {
		return (RestMethodResult) this.execMethod(new SendMessageMethod(mContext,
				sender, receiver, content));
	}

	@Override
	public RestMethodResult<JSONObjResource> getMessages(UserEntity receiver,
			String updateTime) {
		return (RestMethodResult) this.execMethod(new GetMessagesMethod(mContext,
				receiver, updateTime));
	}

	@Override
	protected void modifyContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.modifyContentProvider(jsonObj, colNames, contentUri);
		
		if (jsonObj.has(MessageConst.DATA_SHOP_KEY)) {
			JSONObject shop = jsonObj.getJSONObject(MessageConst.DATA_SHOP_KEY);
			ShopUtils.updateShopContentProvider(mContext, shop);
		}
		if (jsonObj.has(MessageConst.DATA_SENDER_KEY)) {
			JSONObject user = jsonObj.getJSONObject(MessageConst.DATA_SENDER_KEY);
			super.updateContentProvider(user, UserData.COL_NAMES_WITHOUT_PWD,
					UserConst.CONTENT_URI);
		}
	}

	@Override
	protected void recordUpdateTime(String updateTime, JSONObjResource resource) {
		SyncData syncData = SyncData.getInstance(mContext);
		syncData.updateData(syncTableName,
				RunEnv.getInstance().getUser().getUuid(), updateTime);
	}
}
