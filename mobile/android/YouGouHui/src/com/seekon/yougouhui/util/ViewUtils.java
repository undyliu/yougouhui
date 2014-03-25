package com.seekon.yougouhui.util;

import java.io.InputStream;

import android.graphics.drawable.Drawable;
import android.widget.ImageView;

public class ViewUtils {

	/**
	 * 设置imageView的src
	 * @param view
	 * @param fileName
	 */
	public static boolean setImageViewSrc(ImageView view, String fileName){
		if(!FileHelper.fileExists(fileName)){
			return false;
		}
		InputStream is = null;
		try {
			is = FileHelper.read(fileName);
			if (is != null) {
				view.setImageDrawable(Drawable.createFromStream(is, "src"));
			}
		} catch(Exception e){
			return false;
		}finally {
			FileHelper.closeInputStream(is);
		}
		return true;
	}
}
