package com.seekon.yougouhui.util;

import com.seekon.yougouhui.YouGouHuiApp;

import android.content.Context;
import android.telephony.TelephonyManager;

public class DeviceUtils {
	private DeviceUtils() {

	}

	public static String getTelephoneNumber() {
		TelephonyManager tm = (TelephonyManager) YouGouHuiApp.getAppContext()
				.getSystemService(Context.TELEPHONY_SERVICE);
		return tm.getLine1Number();
	}
}
