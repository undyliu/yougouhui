package com.seekon.yougouhui.util;

import android.content.Context;
import android.content.pm.PackageManager;
import android.hardware.Camera;

import com.seekon.yougouhui.YouGouHuiApp;

public class CameraUtils {

	private static final String TAG = CameraUtils.class.getSimpleName();

	private CameraUtils() {
	}

	/**
	 * 检查摄像头是否存在
	 * 
	 * @return
	 */
	public static boolean checkCameraHardware() {
		Context context = YouGouHuiApp.getAppContext();
		if (context.getPackageManager().hasSystemFeature(
				PackageManager.FEATURE_CAMERA)) {
			return true;
		} else {
			return false;
		}
	}

	public static Camera getCameraInstance() {
		Camera camera = null;
		try {
			camera = Camera.open();
		} catch (Exception e) {
			Logger.error(TAG, "获取摄像头失败.");
		}
		return camera;
	}

}
