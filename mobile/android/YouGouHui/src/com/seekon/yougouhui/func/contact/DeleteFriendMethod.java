package com.seekon.yougouhui.func.contact;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

/**
 * 删除朋友
 * 
 * @author undyliu
 * 
 */
public class DeleteFriendMethod extends JSONObjResourceMethod {

	private static final String ADD_FRIEND_URI = Const.SERVER_APP_URL
			+ "/deleteFriend";

	private UserEntity friend;

	public DeleteFriendMethod(Context context, UserEntity friend) {
		super(context);
		this.friend = friend;
	}

	@Override
	protected Request buildRequest() {
		String userId = RunEnv.getInstance().getUser().getUuid();
		String uri = ADD_FRIEND_URI + "/" + userId + "/" + friend.getUuid();
		return new BaseRequest(Method.DELETE, URI.create(uri), null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, DataConst.NAME_TYPE,
				FriendConst.Type.DELETE);

		JSONUtils.putJSONValue(resource, FriendConst.COL_NAME_FRIEND_ID,
				friend.getUuid());
		JSONUtils.putJSONValue(resource, FriendConst.COL_NAME_USER_ID, RunEnv
				.getInstance().getUser().getUuid());

		return resource;
	}
}
