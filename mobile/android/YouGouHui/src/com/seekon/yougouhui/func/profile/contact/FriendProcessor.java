package com.seekon.yougouhui.func.profile.contact;

import org.json.JSONException;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserData;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class FriendProcessor extends ContentProcessor {

	private static final String TAG = FriendProcessor.class.getSimpleName();

	private UserEntity friend;

	private boolean delete = false;

	public FriendProcessor(Context mContext, UserEntity friend) {
		super(mContext, FriendData.COL_NAMES, FriendConst.CONTENT_URI);
		this.friend = friend;
	}

	public RestMethodResult<JSONObjResource> addFriend() {
		return (RestMethodResult) this.execMethod(new AddFriendMethod(mContext,
				friend.getUuid()));
	}

	public RestMethodResult<JSONObjResource> deleteFriend() {
		delete = true;
		return (RestMethodResult) this.execMethod(new DeleteFriendMethod(mContext,
				friend.getUuid()));
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		if (result == null) {
			return;
		}

		try {
			JSONObjResource reource = (JSONObjResource) result.getResource();
			if (delete) {
				this.deleteContentProvider(reource, contentUri);
			} else {
				JSONUtils.putJSONValue(reource, FriendConst.COL_NAME_USER_ID, RunEnv
						.getInstance().getUser().getUuid());
				JSONUtils.putJSONValue(reource, FriendConst.COL_NAME_FRIEND_ID,
						friend.getUuid());
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
		if (delete) {
			JSONObjResource resource = new JSONObjResource();
			JSONUtils.putJSONValue(resource, DataConst.COL_NAME_UUID,
					friend.getUuid());
			this.deleteContentProvider(resource, UserConst.CONTENT_URI);
		} else {
			this.updateContentProvider(JSONUtils.fromUserEntity(friend),
					UserData.COL_NAMES, UserConst.CONTENT_URI);
		}
	}
}
