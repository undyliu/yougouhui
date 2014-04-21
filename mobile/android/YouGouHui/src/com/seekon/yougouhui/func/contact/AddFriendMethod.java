package com.seekon.yougouhui.func.contact;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

/**
 * 添加朋友
 * 
 * @author undyliu
 * 
 */
public class AddFriendMethod extends JSONObjResourceMethod {

	private static final String ADD_FRIEND_URI = Const.SERVER_APP_URL
			+ "/addFriend";

	private UserEntity friend;

	public AddFriendMethod(Context context, UserEntity friend) {
		super(context);
		this.friend = friend;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(FriendConst.COL_NAME_FRIEND_ID, friend.getUuid());
		params.put(FriendConst.COL_NAME_USER_ID, RunEnv.getInstance().getUser()
				.getUuid());

		return new BaseRequest(Method.POST, URI.create(ADD_FRIEND_URI), null,
				params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, DataConst.NAME_TYPE, FriendConst.Type.ADD);
		resource.put(UserConst.DATA_KEY_USER, friend);
		return resource;
	}
}
