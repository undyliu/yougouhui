package com.seekon.yougouhui.util;

import java.lang.reflect.Field;

import com.seekon.yougouhui.R;

public class RUtils {
	
	static final String TAG = RUtils.class.getSimpleName();
	
	public static int getDrawableImg(String imgFieldName) {
		try {
			Field field = R.drawable.class.getField(imgFieldName);
			field.setAccessible(true);
			return (Integer) field.get(R.drawable.class);
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return -1;
	}
}
