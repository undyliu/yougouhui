package com.seekon.yougouhui.func.profile.contact;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.contact.FriendConst.Type;
import com.seekon.yougouhui.func.spi.IFriendProcessor;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class FriendProcessor extends ContentProcessor implements
		IFriendProcessor {

	private static final String TAG = FriendProcessor.class.getSimpleName();

	private static IFriendProcessor instance = null;
	private final static Object lock = new Object();
	
	public static IFriendProcessor getInstance(Context mContext){
		synchronized (lock) {
			if(instance == null){
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IFriendProcessor) proxy.bind(new FriendProcessor(mContext));
			}
		}
		return instance;
	}
	
	private FriendProcessor(Context mContext) {
		super(mContext, FriendData.COL_NAMES, FriendConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> addFriend(UserEntity friend) {
		return (RestMethodResult) this.execMethod(new AddFriendMethod(mContext,
				friend));
	}

	public RestMethodResult<JSONObjResource> deleteFriend(UserEntity friend) {
		return (RestMethodResult) this.execMethod(new DeleteFriendMethod(mContext,
				friend));
	}

	public RestMethodResult<JSONArrayResource> getFriends(UserEntity user) {
		return (RestMethodResult) this.execMethod(new GetFriendsMethod(mContext,
				user.getUuid()));
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		if (result == null) {
			return;
		}

		try {
			if (result.getResource() instanceof JSONArrayResource) {
				JSONArrayResource resource = (JSONArrayResource) result.getResource();
				for (int i = 0; i < resource.length(); i++) {
					JSONObject friend = resource.getJSONObject(i);
					super.updateContentProvider(friend, colNames, contentUri);

					JSONObject user = friend.getJSONObject(UserConst.DATA_KEY_USER);
					super.updateContentProvider(user, UserData.COL_NAMES,
							UserConst.CONTENT_URI);
				}
				return;
			}

			JSONObjResource resource = (JSONObjResource) result.getResource();
			FriendConst.Type type = (Type) resource.get(DataConst.NAME_TYPE);
			if (type == Type.DELETE) {
				this.deleteContentProvider(resource, contentUri);
			} else {
				super.updateContentProvider(resource, colNames, contentUri);
			}
			updateFriendUser(type, resource);
		} catch (JSONException e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}

	/**
	 * 删除对应的用户
	 * 
	 * @throws JSONException
	 */
	private void updateFriendUser(FriendConst.Type type, JSONObject jsonObj)
			throws JSONException {
		if (type == Type.DELETE) {
			JSONObjResource resource = new JSONObjResource();
			JSONUtils.putJSONValue(resource, DataConst.COL_NAME_UUID, JSONUtils
					.getJSONStringValue(resource, FriendConst.COL_NAME_FRIEND_ID));
			this.deleteContentProvider(jsonObj, UserConst.CONTENT_URI);
		} else {
			UserEntity user = (UserEntity) jsonObj.get(UserConst.DATA_KEY_USER);
			this.updateContentProvider(UserUtils.toJSONObject(user), UserData.COL_NAMES,
					UserConst.CONTENT_URI);
		}
	}
}
