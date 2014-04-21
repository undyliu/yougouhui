package com.seekon.yougouhui.func.contact;

import android.content.Context;
import android.os.AsyncTask;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.sercurity.AuthorizationManager;

public class GetFriendsTask extends
		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> {

	private Context context;
	private UserEntity user;

	public GetFriendsTask(Context context, UserEntity user) {
		super();
		this.context = context;
		this.user = user;
	}

	@Override
	protected RestMethodResult<JSONArrayResource> doInBackground(Void... params) {
		return FriendProcessor.getInstance(context).getFriends(user);
	}

	@Override
	protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
		if (result.getStatusCode() == 200) {
			user.setFriends(AuthorizationManager.getInstance(context).getUserHelper()
					.getUserFriends(user.getUuid()));
		}
		super.onPostExecute(result);
	}
}
