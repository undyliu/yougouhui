package com.seekon.yougouhui.file;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.BitmapFactory;
import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.YouGouHuiApp;
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

	public static final String IMAGE_FILE_GET_URL = Const.SERVER_APP_URL
			+ "/getImageFile/";

	private FileHelper() {
	}

	// public static void write(Bitmap image, String fileName) {
	// ByteArrayOutputStream baos = new ByteArrayOutputStream();
	// image.compress(Bitmap.CompressFormat.PNG, 100, baos);
	// InputStream isBm = null;
	// try {
	// isBm = new ByteArrayInputStream(baos.toByteArray());
	// write(isBm, IMAGE_FILE_GET_URL + fileName);
	// } finally {
	// closeInputStream(isBm);
	// }
	// }
	//
	// private static void write(InputStream is, String url) {
	// File file = getFile(url);
	// if (file.exists()) {
	// return;
	// }
	// byte[] content = new byte[1024];
	// FileOutputStream os = null;
	// try {
	// os = new FileOutputStream(file);
	// int size = 0;
	// while ((size = is.read(content)) != -1) {
	// os.write(content, 0, size);
	// }
	// os.flush();
	// } catch (Exception e) {
	// Logger.error(TAG, e.getMessage(), e);
	// } finally {
	// closeOutputStream(os);
	// }
	// }

	// public static File getFileByName(String fileName) {
	// return getFile(IMAGE_FILE_GET_URL + fileName);
	// }
	//
	// public static File getFile(String url) {
	// FileCache fileCache = new FileCache();
	// return fileCache.getFile(url);
	// }

	/**
	 * 从cache目录中获取文件
	 * 
	 * @param fileName
	 * @return
	 */
	public static File getFileFromCache(String fileName) {
		return new File(FileCache.getInstance().getCacheDir(), fileName);
	}

	/**
	 * 删除cache目录下制定路径的文件
	 * 
	 * @param fileUri
	 */
	public static void deleteCacheFile(String fileUri) {
		if (fileUri == null) {
			return;
		}

		File cacheDir = FileCache.getInstance().getCacheDir();
		for (File cacheFile : cacheDir.listFiles()) {
			if (cacheFile.getPath().equalsIgnoreCase(fileUri)) {
				cacheFile.delete();
				return;
			}
		}
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

	public static byte[] compressByQuality(Bitmap bitmap, int maxSize) {
		ByteArrayOutputStream baos = null;
		try {
			baos = new ByteArrayOutputStream();
			int quality = 100;
			bitmap.compress(CompressFormat.PNG, quality, baos);
			Logger.debug(TAG, "图片压缩前大小：" + baos.toByteArray().length + "byte");
			while (baos.toByteArray().length / 1024 > maxSize && quality > 0) {
				quality -= 10;
				baos.reset();
				bitmap.compress(CompressFormat.JPEG, quality, baos);
				Logger.debug(TAG, "质量压缩到原来的" + quality + "%时大小为："
						+ baos.toByteArray().length + "byte");
			}
			Logger.debug(TAG, "图片压缩后大小：" + baos.toByteArray().length + "byte");
			return baos.toByteArray();
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return new byte[0];
	}

	public static Bitmap decodeFileByDisplaySize(String fileUri) {
		DisplayMetrics metrics = YouGouHuiApp.getAppContext().getResources()
				.getDisplayMetrics();
		int width = metrics.widthPixels;
		int height = metrics.heightPixels;
		return decodeFile(fileUri, true, width, height);
	}

	public static Bitmap decodeFile(String fileUri, boolean compress,
			int reqWidth, int reqHeight) {
		return decodeFile(new File(fileUri), compress, reqWidth, reqHeight);
	}

	public static Bitmap decodeFile(File f, boolean compress, int reqWidth,
			int reqHeight) {
		try {
			BitmapFactory.Options o = new BitmapFactory.Options();
			if (!compress) {
				return BitmapFactory.decodeStream(new FileInputStream(f), null, o);
			} else {
				o.inJustDecodeBounds = true;
				BitmapFactory.decodeStream(new FileInputStream(f), null, o);
			}

			int width_tmp = o.outWidth;
			int height_tmp = o.outHeight;
			if (((o.outWidth > o.outHeight) && (reqWidth < reqHeight))
					|| ((o.outWidth < o.outHeight) && (reqWidth > reqHeight))) {// 互换位置
				width_tmp = o.outHeight;
				height_tmp = o.outWidth;
			}
			int scale = 1;
			while (true) {
				if (width_tmp / 2 <= reqWidth || height_tmp / 2 <= reqHeight)
					break;
				width_tmp /= 2;
				height_tmp /= 2;
				scale *= 2;
			}

			BitmapFactory.Options o2 = new BitmapFactory.Options();
			o2.inSampleSize = scale;
			return BitmapFactory.decodeStream(new FileInputStream(f), null, o2);
		} catch (FileNotFoundException e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return null;
	}

	public static Drawable getDrawableFromFileCache(String fileName) {
		File file = getFileFromCache(fileName);
		return Drawable.createFromPath(file.getParent());
	}
}
