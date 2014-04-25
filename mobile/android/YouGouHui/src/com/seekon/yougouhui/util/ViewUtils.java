package com.seekon.yougouhui.util;

import android.app.Activity;
import android.app.Service;
import android.os.Handler;
import android.view.Gravity;
import android.view.inputmethod.InputMethodManager;
import android.widget.TextView;
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
	public static void popupInputMethodWindow(final Activity activity) {

		new Handler().postDelayed(new Runnable() {
			@Override
			public void run() {
				InputMethodManager imm = (InputMethodManager) activity
						.getSystemService(Service.INPUT_METHOD_SERVICE);
				imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
			}
		}, 200);
	}

	public static void hideInputMethodWindow(Activity activity) {
		((InputMethodManager) activity
				.getSystemService(Service.INPUT_METHOD_SERVICE))
				.hideSoftInputFromWindow(activity.getCurrentFocus().getWindowToken(),
						InputMethodManager.HIDE_NOT_ALWAYS);
	}

	public static void setEditTextReadOnly(TextView view) {
		// view.setTextColor(android.R.color.background_light); // 设置只读时的文字颜色
		if (view instanceof android.widget.EditText) {
			view.setCursorVisible(false); // 设置输入框中的光标不可见
			view.setFocusable(false); // 无焦点
			view.setFocusableInTouchMode(false); // 触摸时也得不到焦点
		}
	}
}
