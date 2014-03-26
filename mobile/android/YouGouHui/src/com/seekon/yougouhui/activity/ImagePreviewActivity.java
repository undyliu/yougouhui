package com.seekon.yougouhui.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;

/**
 * 简单的图片查看
 * 
 * @author undyliu
 * 
 */
public class ImagePreviewActivity extends Activity {

	public static final String IMAGE_SRC_KEY = "image.src.key";

	public static final String IMAGE_INDEX_IN_CONTAINER = "image.index";

	public static final String IMAGE_DELETE_FLAG = "image.delete.flag";

	String imageFileName = null;

	int imageIndex = 0;

	boolean showDeleteMenuItem = true;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.image_preview);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		Intent intent = this.getIntent();
		imageFileName = intent.getExtras().getString(IMAGE_SRC_KEY);
		imageIndex = intent.getExtras().getInt(IMAGE_INDEX_IN_CONTAINER);
		showDeleteMenuItem = intent.getExtras().getBoolean(IMAGE_DELETE_FLAG);

		ImageView view = (ImageView) this.findViewById(R.id.image_preview_id);
		ImageLoader.getInstance().displayImage(imageFileName, view, false);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.image_preview, menu);
		if (!showDeleteMenuItem) {
			menu.removeItem(R.id.menu_image_preview_del);
		}
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_image_preview_del:
			deleteImage();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void deleteImage() {
		Intent intent = new Intent();
		intent.putExtra(IMAGE_DELETE_FLAG, true);
		intent.putExtra(IMAGE_SRC_KEY, imageFileName);
		intent.putExtra(IMAGE_INDEX_IN_CONTAINER, imageIndex);
		this.setResult(RESULT_OK, intent);
		this.finish();
	}
}
