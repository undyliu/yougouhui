package com.seekon.yougouhui.func.profile.contact;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class FriendProcessor extends ContentProcessor {

	enum Type {
		DELETE, ADD, GET
	}

	private static final String TAG = FriendProcessor.class.getSimpleName();

	private UserEntity user;

	private Type type;

	public FriendProcessor(Context mContext, UserEntity friend) {
		super(mContext, FriendData.COL_NAMES, FriendConst.CONTENT_URI);
		this.user = friend;
	}

	public RestMethodResult<JSONObjResource> addFriend() {
		type = Type.ADD;
		return (RestMethodResult) this.execMethod(new AddFriendMethod(mContext,
				user.getUuid()));
	}

	public RestMethodResult<JSONObjResource> deleteFriend() {
		type = Type.DELETE;
		return (RestMethodResult) this.execMethod(new DeleteFriendMethod(mContext,
				user.getUuid()));
	}

	public RestMethodResult<JSONArrayResource> getFriends() {
		type = Type.GET;
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
			if (type == Type.GET) {
				JSONArrayResource resource = (JSONArrayResource) result.getResource();
				for (int i = 0; i < resource.length(); i++) {
					JSONObject friend = resource.getJSONObject(i);
					super.updateContentProvider(friend, colNames, contentUri);
					
					JSONObject user = friend.getJSONObject(UserConst.DATA_KEY_USER);
					super.updateContentProvider(user, UserData.COL_NAMES, UserConst.CONTENT_URI);
				}
				return;
			}

			JSONObjResource reource = (JSONObjResource) result.getResource();
			if (type == Type.DELETE) {
				this.deleteContentProvider(reource, contentUri);
			} else {
				JSONUtils.putJSONValue(reource, FriendConst.COL_NAME_USER_ID, RunEnv
						.getInstance().getUser().getUuid());
				JSONUtils.putJSONValue(reource, FriendConst.COL_NAME_FRIEND_ID,
						user.getUuid());
				super.updateContentProvider(reource, colNames, contentUri);
			}
			updateFriendUser();
		} catch (JSONException e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}

	/**
	 * 删除对应的用户
	 * 
	 * @throws JSONException
	 */
	private void updateFriendUser() throws JSONException {
		if (type == Type.DELETE) {
			JSONObjResource resource = new JSONObjResource();
			JSONUtils.putJSONValue(resource, DataConst.COL_NAME_UUID, user.getUuid());
			this.deleteContentProvider(resource, UserConst.CONTENT_URI);
		} else {
			this.updateContentProvider(UserUtils.toJSONObject(user),
					UserData.COL_NAMES, UserConst.CONTENT_URI);
		}
	}
}
