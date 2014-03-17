package com.seekon.yougouhui.util;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import com.seekon.yougouhui.R;

import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.widget.ImageView;

/**
 * A helper class facilitates loading a remote image into a given ListView.
 * http://www.cnblogs.com/bjzhanghao/archive/2012/11/11/2764970.html
 * 
 */
public class RemoteImageHelper {

	private static final Map<String, Drawable> cache = new HashMap<String, Drawable>();

	public static void loadImage(final ImageView imageView, final String urlString) {
		loadImage(imageView, urlString, true);
	}

	public static void loadImage(final ImageView imageView, final String urlString,
			boolean useCache) {
		if (useCache && cache.containsKey(urlString)) {
			imageView.setImageDrawable(cache.get(urlString));
		}

		// You may want to show a "Loading" image here
		imageView.setImageResource(R.drawable.loading);

		Log.d(RemoteImageHelper.class.getSimpleName(), "Image url:" + urlString);

		final Handler handler = new Handler() {
			@Override
			public void handleMessage(Message message) {
				imageView.setImageDrawable((Drawable) message.obj);
			}
		};

		Runnable runnable = new Runnable() {
			public void run() {
				Drawable drawable = null;
				try {
					InputStream is = download(urlString);
					drawable = Drawable.createFromStream(is, "src");

					if (drawable != null) {
						cache.put(urlString, drawable);
					}
				} catch (Exception e) {
					Log.e(this.getClass().getSimpleName(), "Image download failed", e);
					// Show "download fail" image
					drawable = imageView.getResources()
							.getDrawable(R.drawable.image_fail);
				}

				// Notify UI thread to show this image using Handler
				Message msg = handler.obtainMessage(1, drawable);
				handler.sendMessage(msg);
			}
		};
		new Thread(runnable).start();

	}

	/**
	 * Download image from given url. Make sure you have
	 * "android.permission.INTERNET" permission set in AndroidManifest.xml.
	 * 
	 * @param urlString
	 * @return
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	private static InputStream download(String urlString) throws MalformedURLException,
			IOException {
		InputStream inputStream = (InputStream) new URL(urlString).getContent();
		return inputStream;
	}
}
