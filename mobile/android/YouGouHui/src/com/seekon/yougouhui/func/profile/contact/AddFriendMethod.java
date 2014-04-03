package com.seekon.yougouhui.func.profile.contact;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

/**
 * 添加朋友
 * 
 * @author undyliu
 * 
 */
public class AddFriendMethod extends JSONObjResourceMethod {

	private static final String ADD_FRIEND_URI = Const.SERVER_APP_URL
			+ "/addFriend";

	private String friendId;

	public AddFriendMethod(Context context, String friendId) {
		super(context);
		this.friendId = friendId;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(FriendConst.COL_NAME_FRIEND_ID, friendId);
		params.put(FriendConst.COL_NAME_USER_ID, RunEnv.getInstance().getUser()
				.getUuid());

		return new BaseRequest(Method.POST, URI.create(ADD_FRIEND_URI), null,
				params);
	}

}
