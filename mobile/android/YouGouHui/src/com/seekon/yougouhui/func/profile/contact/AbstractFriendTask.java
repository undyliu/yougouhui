package com.seekon.yougouhui.func.profile.contact;

import android.content.Context;
import android.os.AsyncTask;
import android.view.MenuItem;
import android.view.View;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 
 * TODO:将UIWedget传递进来特别扭，而且会不会存在引用不释放的问题？
 * @author undyliu
 *
 */
public abstract class AbstractFriendTask extends
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> {
	protected static final String TAG = AddFriendTask.class.getSimpleName();

	protected Context context;

	protected UserEntity friend;

	protected Object UIWedget;

	public AbstractFriendTask(Context context, UserEntity friend, Object UIWedget) {
		super();
		this.context = context;
		this.friend = friend;
		this.UIWedget = UIWedget;
	}

	@Override
	protected void onCancelled() {
		setUIWedgetEnable(true);
		super.onCancelled();
	}

	protected void setUIWedgetEnable(boolean enabled) {
		if (UIWedget instanceof View) {
			((View) UIWedget).setEnabled(enabled);
		} else if (UIWedget instanceof MenuItem) {
			((MenuItem) UIWedget).setEnabled(enabled);
		}
	}
}
