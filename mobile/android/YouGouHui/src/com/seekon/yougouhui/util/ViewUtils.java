package com.seekon.yougouhui.util;

import java.io.InputStream;

import android.graphics.drawable.Drawable;
import android.view.Gravity;
import android.widget.ImageView;
import android.widget.Toast;

import com.seekon.yougouhui.YouGouHuiApp;

public class ViewUtils {

	/**
	 * 设置imageView的src
	 * 
	 * @param view
	 * @param fileName
	 */
	public static boolean setImageViewSrc(ImageView view, String fileName) {
		if (!FileHelper.fileExists(fileName)) {
			return false;
		}
		InputStream is = null;
		try {
			is = FileHelper.read(fileName);
			if (is != null) {
				view.setImageDrawable(Drawable.createFromStream(is, "src"));
			}
		} catch (Exception e) {
			return false;
		} finally {
			FileHelper.closeInputStream(is);
		}
		return true;
	}

	public static void showToast(String message) {
		Toast toast = Toast.makeText(YouGouHuiApp.getAppContext(), message,
				Toast.LENGTH_LONG);
		toast.setGravity(Gravity.CENTER, 0, 0);
		toast.show();
	}
}
