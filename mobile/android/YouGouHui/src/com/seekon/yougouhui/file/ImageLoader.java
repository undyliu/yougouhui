package com.seekon.yougouhui.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.util.Logger;

public class ImageLoader {

	private final static String TAG = ImageLoader.class.getSimpleName();

	private final int REQUIRE_IMGAGE_WIDTH = 100;

	private MemoryCache memoryCache = new MemoryCache();
	private FileCache fileCache;

	// 返回由指定 collection 支持的同步（线程安全的）collection。
	private Map<ImageView, String> imageViews = Collections
			.synchronizedMap(new WeakHashMap<ImageView, String>());

	// 线程池
	private ExecutorService executorService;

	private static Object lock = new Object();

	private static ImageLoader instance = null;

	public static ImageLoader getInstance() {
		synchronized (lock) {
			if (instance == null) {
				instance = new ImageLoader();
			}
		}
		return instance;
	}

	private ImageLoader() {
		fileCache = FileCache.getInstance();
		executorService = Executors.newFixedThreadPool(5);
	}

	// 当进入listview时默认的图片，可换成你自己的默认图片
	final int stub_id = R.drawable.loading;

	public void displayImage(String fileName, ImageView imageView,
			boolean compress) {
		String url = FileHelper.IMAGE_FILE_GET_URL + fileName;
		imageViews.put(imageView, url);
		if (!compress) {// 非压缩的不从缓存获取
			queuePhoto(url, imageView, compress);
			imageView.setImageResource(stub_id);
			return;
		}
		// 先从内存缓存中查找
		Logger.debug(TAG, "先从内存缓存中查找 ---------------------->>>>>");
		Bitmap bitmap = memoryCache.get(url);
		if (bitmap != null)
			imageView.setImageBitmap(bitmap);
		else {
			// 若没有的话则开启新线程加载图片
			queuePhoto(url, imageView, compress);
			imageView.setImageResource(stub_id);
		}
	}

	private void queuePhoto(String url, ImageView imageView, boolean compress) {
		Logger.debug(TAG, "开启新线程加载图片 ---------------------->>>>>");
		PhotoToLoad p = new PhotoToLoad(url, imageView, compress);
		executorService.submit(new PhotosLoader(p));
	}

	private Bitmap getBitmap(String url, boolean compress) {
		File f = fileCache.getFile(url);

		// 先从文件缓存中查找是否有
		Logger.debug(TAG,
				"先从文件缓存中查找是否有 --------------------------------->>>>>>>>>>>");
		Bitmap b = FileHelper.decodeFile(f, compress, REQUIRE_IMGAGE_WIDTH,
				REQUIRE_IMGAGE_WIDTH);
		if (b != null)
			return b;

		// 最后从指定的url中下载图片
		try {
			Logger.debug(TAG,
					"最后从指定的url中下载图片 --------------------------------->>>>>>>>>>>");
			Bitmap bitmap = null;
			URL imageUrl = new URL(url);
			HttpURLConnection conn = (HttpURLConnection) imageUrl.openConnection();
			conn.setConnectTimeout(30000);
			conn.setReadTimeout(30000);
			conn.setInstanceFollowRedirects(true);
			InputStream is = conn.getInputStream();
			OutputStream os = new FileOutputStream(f);
			FileHelper.CopyStream(is, os);
			os.close();
			bitmap = FileHelper.decodeFile(f, compress, REQUIRE_IMGAGE_WIDTH,
					REQUIRE_IMGAGE_WIDTH);
			return bitmap;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	// Task for the queue
	private class PhotoToLoad {
		public String url;
		public ImageView imageView;
		public boolean compress;

		public PhotoToLoad(String u, ImageView i, boolean c) {
			url = u;
			imageView = i;
			compress = c;
		}
	}

	class PhotosLoader implements Runnable {
		PhotoToLoad photoToLoad;

		PhotosLoader(PhotoToLoad photoToLoad) {
			this.photoToLoad = photoToLoad;
		}

		public void run() {
			if (imageViewReused(photoToLoad))
				return;
			Bitmap bmp = getBitmap(photoToLoad.url, photoToLoad.compress);
			if (photoToLoad.compress) {
				memoryCache.put(photoToLoad.url, bmp);// 仅压缩后的文件才放入内存中缓存
			}
			if (imageViewReused(photoToLoad))
				return;
			BitmapDisplayer bd = new BitmapDisplayer(bmp, photoToLoad);
			// 更新的操作放在UI线程中
			Activity a = (Activity) photoToLoad.imageView.getContext();
			a.runOnUiThread(bd);
		}
	}

	/**
	 * 防止图片错位
	 * 
	 * @param photoToLoad
	 * @return
	 */
	boolean imageViewReused(PhotoToLoad photoToLoad) {
		String tag = imageViews.get(photoToLoad.imageView);
		if (tag == null || !tag.equals(photoToLoad.url))
			return true;
		return false;
	}

	// 用于在UI线程中更新界面
	class BitmapDisplayer implements Runnable {
		Bitmap bitmap;
		PhotoToLoad photoToLoad;

		public BitmapDisplayer(Bitmap b, PhotoToLoad p) {
			bitmap = b;
			photoToLoad = p;
		}

		public void run() {
			if (imageViewReused(photoToLoad))
				return;
			if (bitmap != null)
				photoToLoad.imageView.setImageBitmap(bitmap);
			else
				photoToLoad.imageView.setImageResource(stub_id);
		}
	}

	public void clearCache() {
		memoryCache.clear();
		fileCache.clear();
	}

	public void putImageViews(ImageView imageView, String url) {
		imageViews.put(imageView, url);
	}
}
