package com.seekon.yougouhui;

import android.app.Application;
import android.content.Context;

import com.seekon.yougouhui.util.Logger;

public class YouGouHuiApp extends Application{

	private static Context mAppContext;

	@Override
	public void onCreate() {
		super.onCreate();

		mAppContext = getApplicationContext();
		
		Logger.setAppTag(getString(R.string.app_log_tag));
		Logger.setLevel(Logger.DEBUG);
	}

	public static Context getAppContext() {
		return mAppContext;
	}
}
