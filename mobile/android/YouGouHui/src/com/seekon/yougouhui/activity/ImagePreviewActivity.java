package com.seekon.yougouhui.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 简单的图片查看
 * @author undyliu
 *
 */
public class ImagePreviewActivity extends Activity{
	
	public static final String IMAGE_SRC_KEY = "image.src.key";
	
	public static final String IMAGE_INDEX_IN_CONTAINER = "image.index";
	
	public static final String IMAGE_DELETE_FLAG = "image.delete.flag";
		
	String imageFileName = null;
	
	int imageIndex = 0;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.image_preview);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		Intent intent = this.getIntent();
		imageFileName = intent.getExtras().getString(IMAGE_SRC_KEY);
		imageIndex = intent.getExtras().getInt(IMAGE_INDEX_IN_CONTAINER);
		
		ImageView view = (ImageView) this.findViewById(R.id.image_preview_id);
		ViewUtils.setImageViewSrc(view, imageFileName);
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.image_preview, menu);
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
	
	private void deleteImage(){
		Intent intent = new Intent();
		intent.putExtra(IMAGE_DELETE_FLAG, true);
		intent.putExtra(IMAGE_SRC_KEY, imageFileName);
		intent.putExtra(IMAGE_INDEX_IN_CONTAINER, imageIndex);
		this.setResult(RESULT_OK, intent);
		this.finish();
	}
}
