package com.seekon.yougouhui.file;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.graphics.Bitmap;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.util.Logger;

/**
 * 
 * 文件读写操作类
 * 
 * @author undyliu
 * 
 */
public class FileHelper {

	private static final String TAG = FileHelper.class.getSimpleName();

	public static final String IMAGE_FILE_GET_URL = Const.SERVER_APP_URL + "/getImageFile/";
	
	private FileHelper() {
	}

	public static void write(Bitmap image, String fileName) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		image.compress(Bitmap.CompressFormat.PNG, 100, baos);
		InputStream isBm = null;
		try {
			isBm = new ByteArrayInputStream(baos.toByteArray());
			write(isBm, IMAGE_FILE_GET_URL + fileName);
		} finally {
			closeInputStream(isBm);
		}
	}

	private static void write(InputStream is, String url) {
		File file = getFile(url);
		if (file.exists()) {
			return;
		}
		byte[] content = new byte[1024];
		FileOutputStream os = null;
		try {
			os = new FileOutputStream(file);
			int size = 0;
			while ((size = is.read(content)) != -1) {
				os.write(content, 0, size);
			}
			os.flush();
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			closeOutputStream(os);
		}
	}

	public static File getFileByName(String fileName){
		return getFile(IMAGE_FILE_GET_URL + fileName);
	}
	
	public static File getFile(String url) {
		FileCache fileCache = new FileCache();
		return fileCache.getFile(url);
	}

	public static void CopyStream(InputStream is, OutputStream os) {
		final int buffer_size = 1024;
		try {
			byte[] bytes = new byte[buffer_size];
			for (;;) {
				int count = is.read(bytes, 0, buffer_size);
				if (count == -1)
					break;
				os.write(bytes, 0, count);
			}
		} catch (Exception ex) {
		}
	}

	public static void closeOutputStream(OutputStream os) {
		if (os != null) {
			try {
				os.close();
			} catch (IOException e) {
				Logger.error(TAG, e.getMessage(), e);
			}
		}
	}

	public static void closeInputStream(InputStream is) {
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
				Logger.error(TAG, e.getMessage(), e);
			}
		}
	}
}
