package com.seekon.yougouhui.activity.discover;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.hardware.Camera;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.layout.FixGridLayout;
import com.seekon.yougouhui.util.ImageCompressUtils;
import com.seekon.yougouhui.util.Logger;

public class ShareActivity extends Activity {

	private final String TAG = ShareActivity.class.getSimpleName();

	private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;

	private static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 200;

	private static final int PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE = 300;
	
	private static final int IMAGE_VIEW_WIDTH = 150;

	private static final int IMAGE_VIEW_HEIGHT = 150;

	FixGridLayout picContainer = null;

	private String title[] = { "拍照", "从文件获取" };

	private PopupWindow popupWindow;

	private Camera camera;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.discover_share);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		picContainer = (FixGridLayout) findViewById(R.id.share_pic_container);
		picContainer.setmCellHeight(IMAGE_VIEW_HEIGHT);
		picContainer.setmCellWidth(IMAGE_VIEW_WIDTH);

		final LayoutInflater inflater = getLayoutInflater();
		FrameLayout fl = (FrameLayout) inflater.inflate(
				R.layout.discover_share_pic_item, null);

		fl.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				showPopupWindow(v);
			}
		});

		picContainer.addView(fl);
		picContainer.invalidate(); // 让UI重绘界面
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.discover_share, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_discover_share:
			this.publishShare();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onDestroy() {
		if (camera != null) {
			camera.stopPreview();
			camera.release();
			camera = null;
		}
		super.onDestroy();
	}

	private void showPopupWindow(View v) {
		LinearLayout layout = (LinearLayout) LayoutInflater.from(this).inflate(
				R.layout.discover_share_choose_pop, null);
		ListView listView = (ListView) layout.findViewById(R.id.share_choose_pop);
		listView.setAdapter(new ArrayAdapter<String>(this,
				R.layout.discover_share_choose_pop_item, R.id.share_choose_pop_item,
				title));

		popupWindow = new PopupWindow(this);
		popupWindow.setBackgroundDrawable(new BitmapDrawable());
		popupWindow.setWidth(getWindowManager().getDefaultDisplay().getWidth() / 2);
		popupWindow.setHeight(140);
		popupWindow.setOutsideTouchable(true);
		popupWindow.setFocusable(true);
		popupWindow.setContentView(layout);
		popupWindow.showAsDropDown(v);

		listView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				if (position == 0) {
					openCamera();
				} else if (position == 1) {
					openImageDir();
				}
				popupWindow.dismiss();
				popupWindow = null;
			}
		});
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE) {
			if (resultCode == RESULT_OK && data != null) {
				Bitmap image = (Bitmap) data.getExtras().get("data");
				if (image != null) {
					image = ImageCompressUtils.compressBySize(image, IMAGE_VIEW_WIDTH - 10,
							IMAGE_VIEW_HEIGHT);
					addBitmapToImageView(image);
				}
			}
		} else if (requestCode == LOAD_IMAGE_ACTIVITY_REQUEST_CODE) {
			if (resultCode == RESULT_OK && null != data) {
				Uri selectedImage = data.getData();
				String[] filePathColumn = { MediaStore.Images.Media.DATA };
				Cursor cursor = getContentResolver().query(selectedImage,
						filePathColumn, null, null, null);
				cursor.moveToFirst();
				int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
				String picturePath = cursor.getString(columnIndex);
				cursor.close();

				addBitmapToImageView(ImageCompressUtils.compressBySize(picturePath,
						IMAGE_VIEW_WIDTH - 10, IMAGE_VIEW_HEIGHT));
			}
		}else if(requestCode == PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE){
			if(data != null){
				boolean imageDeleted = data.getExtras().getBoolean(ImagePreviewActivity.IMAGE_DELETE_FLAG);
				if(imageDeleted){
					int imageIndex = data.getExtras().getInt(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER);
					picContainer.removeViewAt(imageIndex);
					picContainer.postInvalidate();
				}
			}
		}
		
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void addBitmapToImageView(final Bitmap image) {
		FrameLayout con = (FrameLayout) ShareActivity.this.getLayoutInflater()
				.inflate(R.layout.discover_share_pic_item, null);
		ImageView pic = (ImageView) con.findViewById(R.id.share_pic);
		pic.setImageBitmap(image);
		pic.setBackgroundResource(0);//去掉background
		final int imageIndex = picContainer.getChildCount() - 1;
		
		pic.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View view) {
				Intent intent = new Intent(ShareActivity.this, ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
				intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, imageIndex);
				ShareActivity.this.startActivityForResult(intent, PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE);
			}
		});
		
		picContainer.addView(con, imageIndex);
		picContainer.postInvalidate();
	}

	private void openCamera() {
		Logger.debug(TAG, "openCamera");
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		intent.addCategory(Intent.CATEGORY_DEFAULT);
		startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);
	}

	private void openImageDir() {
		Logger.debug(TAG, "openImageDir");
		Intent intent = new Intent(Intent.ACTION_PICK,
				android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
		startActivityForResult(intent, LOAD_IMAGE_ACTIVITY_REQUEST_CODE);
	}

	private void publishShare() {
		Intent intent = new Intent();
		this.setResult(RESULT_OK, intent);
		this.finish();
	}
}
