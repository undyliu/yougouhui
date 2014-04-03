package com.seekon.yougouhui.util;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.app.Activity;
import android.app.Service;
import android.os.Build;
import android.os.Handler;
import android.view.Gravity;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.TextView;
import android.widget.Toast;

import com.seekon.yougouhui.R;
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

	public static void showProgress(Activity activity, final View coveredView,
			final boolean show) {
		showProgress(activity, coveredView, show,
				R.string.default_progress_status_message);
	}

	public static void showProgress(Activity activity, final View coveredView,
			final boolean show, int statusMessage) {
		View _progressStatusView = activity
				.findViewById(R.id.action_progress_status);
		TextView _mStatusMessageView = (TextView) activity
				.findViewById(R.id.action_status_message);
		if (_progressStatusView == null || _mStatusMessageView == null) {
			View xxView = activity.getLayoutInflater().inflate(R.layout.progressbar, null);
			_progressStatusView = xxView.findViewById(R.id.action_progress_status);
			_mStatusMessageView = (TextView) xxView
					.findViewById(R.id.action_status_message);
		}
		final View progressStatusView = _progressStatusView;
		final TextView mStatusMessageView = _mStatusMessageView;
		
		mStatusMessageView.setText(statusMessage);

		// On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
		// for very easy animations. If available, use these APIs to fade-in
		// the progress spinner.
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
			int shortAnimTime = activity.getResources().getInteger(
					android.R.integer.config_shortAnimTime);

			progressStatusView.setVisibility(View.VISIBLE);
			progressStatusView.animate().setDuration(shortAnimTime)
					.alpha(show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							progressStatusView.setVisibility(show ? View.VISIBLE : View.GONE);
						}
					});

			if (coveredView != null) {
				coveredView.setVisibility(View.VISIBLE);
				coveredView.animate().setDuration(shortAnimTime).alpha(show ? 0 : 1)
						.setListener(new AnimatorListenerAdapter() {
							@Override
							public void onAnimationEnd(Animator animation) {
								coveredView.setVisibility(show ? View.GONE : View.VISIBLE);
							}
						});
			}
		} else {
			// The ViewPropertyAnimator APIs are not available, so simply show
			// and hide the relevant UI components.
			progressStatusView.setVisibility(show ? View.VISIBLE : View.GONE);
			if (coveredView != null) {
				coveredView.setVisibility(show ? View.GONE : View.VISIBLE);
			}
		}
	}
}
