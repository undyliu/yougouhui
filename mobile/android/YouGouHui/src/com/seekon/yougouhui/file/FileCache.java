package com.seekon.yougouhui.file;

import java.io.File;

import com.seekon.yougouhui.YouGouHuiApp;

public class FileCache {

	private File cacheDir;

	private static FileCache instance = null;

	private static Object lock = new Object();

	public static FileCache getInstance() {
		synchronized (lock) {
			if (instance == null) {
				instance = new FileCache();
			}
		}
		return instance;
	}

	private FileCache() {
		// 如果有SD卡则在SD卡中建一个LazyList的目录存放缓存的图片
		// 没有SD卡就放在系统的缓存目录中
		if (android.os.Environment.getExternalStorageState().equals(
				android.os.Environment.MEDIA_MOUNTED))
			cacheDir = new File(android.os.Environment.getExternalStorageDirectory(),
					"LazyList");
		else
			cacheDir = YouGouHuiApp.getAppContext().getCacheDir();
		if (!cacheDir.exists())
			cacheDir.mkdirs();
	}

	public File getFile(String url) {
		// 将url的hashCode作为缓存的文件名
		String filename = String.valueOf(url.hashCode());
		// Another possible solution
		// String filename = URLEncoder.encode(url);
		File f = new File(cacheDir, filename);
		return f;

	}

	public File getCacheDir() {
		return this.cacheDir;
	}

	public void clear() {
		File[] files = cacheDir.listFiles();
		if (files == null)
			return;
		for (File f : files)
			f.delete();
	}
}
