package com.seekon.yougouhui.util;

import android.app.Service;
import android.os.Handler;
import android.view.Gravity;
import android.view.inputmethod.InputMethodManager;
import android.widget.Toast;

import com.seekon.yougouhui.YouGouHuiApp;

public class ViewUtils {

	public static void showToast(String message) {
		Toast toast = Toast.makeText(YouGouHuiApp.getAppContext(), message,
				Toast.LENGTH_LONG);
		toast.setGravity(Gravity.CENTER, 0, 0);
		toast.show();
	}

	/**
	 * 弹出输入法窗口
	 */
	public static void popupInputMethodWindow() {

		new Handler().postDelayed(new Runnable() {

			@Override
			public void run() {

				InputMethodManager imm = (InputMethodManager) YouGouHuiApp
						.getAppContext().getSystemService(Service.INPUT_METHOD_SERVICE);
				imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
			}
		}, 200);
	}
}
