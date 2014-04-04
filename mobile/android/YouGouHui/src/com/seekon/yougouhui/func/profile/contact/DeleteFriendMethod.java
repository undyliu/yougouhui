package com.seekon.yougouhui.func.profile.contact;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

/**
 * 删除朋友
 * 
 * @author undyliu
 * 
 */
public class DeleteFriendMethod extends JSONObjResourceMethod {

	private static final String ADD_FRIEND_URI = Const.SERVER_APP_URL
			+ "/deleteFriend";

	private String friendId;

	public DeleteFriendMethod(Context context, String friendId) {
		super(context);
		this.friendId = friendId;
	}

	@Override
	protected Request buildRequest() {
		String userId = RunEnv.getInstance().getUser().getUuid();
		String uri = ADD_FRIEND_URI + "/" + userId + "/" + friendId;
		return new BaseRequest(Method.DELETE, URI.create(uri), null, null);
	}

}
