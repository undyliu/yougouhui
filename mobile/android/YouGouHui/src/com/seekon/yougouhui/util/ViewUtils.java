package com.seekon.yougouhui.util;

import android.view.Gravity;
import android.widget.Toast;

import com.seekon.yougouhui.YouGouHuiApp;

public class ViewUtils {

	public static void showToast(String message) {
		Toast toast = Toast.makeText(YouGouHuiApp.getAppContext(), message,
				Toast.LENGTH_LONG);
		toast.setGravity(Gravity.CENTER, 0, 0);
		toast.show();
	}
}
