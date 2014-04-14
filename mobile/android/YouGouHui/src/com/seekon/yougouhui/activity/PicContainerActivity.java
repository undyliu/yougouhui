package com.seekon.yougouhui.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.util.Logger;

/**
 * 图片展示的activity，支持对图片的增加、删除等操作
 * 
 * @author undyliu
 * 
 */
public abstract class PicContainerActivity extends Activity {

	protected static final String TAG = PicContainerActivity.class
			.getSimpleName();

	private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;

	private static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 200;

	private static final int PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE = 300;

	private String title[] = { "拍照", "从文件获取" };

	private PopupWindow popupWindow;

	private Uri currentCameraFileUri = null;// 当前拍照的文件存放的路径

	protected List<String> imageFileUriList = new ArrayList<String>();

	protected BaseAdapter imageAdapter;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		GridView picContainer = getPicContainer();
		// 设置GridView的列数
		DisplayMetrics displayMetrics = this.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels
				/ (PicSelectAdapter.IMAGE_VIEW_WIDTH + 20);
		picContainer.setNumColumns(colNumber);
		imageAdapter = new PicSelectAdapter();
		picContainer.setAdapter(imageAdapter);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
	}

	public abstract GridView getPicContainer();

	private void showPopupWindow(View v) {
		LinearLayout layout = (LinearLayout) LayoutInflater.from(this).inflate(
				R.layout.pic_choose_pop, null);
		ListView listView = (ListView) layout.findViewById(R.id.pic_choose_pop);
		listView.setAdapter(new ArrayAdapter<String>(this,
				R.layout.pic_choose_pop_item, R.id.pic_choose_pop_item, title));

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

	private void openCamera() {
		Logger.debug(TAG, "openCamera");
		Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
		currentCameraFileUri = Uri.fromFile(FileHelper.getFileFromCache(System
				.currentTimeMillis() + ".png"));
		intent.putExtra(MediaStore.EXTRA_OUTPUT, currentCameraFileUri);

		startActivityForResult(intent, CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE);
	}

	private void openImageDir() {
		Logger.debug(TAG, "openImageDir");
		Intent intent = new Intent(Intent.ACTION_PICK,
				android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
		startActivityForResult(intent, LOAD_IMAGE_ACTIVITY_REQUEST_CODE);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			goBackHome();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	/**
	 * 返回到上一界面
	 */
	private void goBackHome() {
		clean();
		this.finish();
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE:
			if (resultCode == RESULT_OK) {
				addBitmapToImageView(currentCameraFileUri.getPath());
			}
			currentCameraFileUri = null;
			break;
		case LOAD_IMAGE_ACTIVITY_REQUEST_CODE:
			if (resultCode == RESULT_OK && null != data) {
				Uri selectedImage = data.getData();
				String[] filePathColumn = { MediaStore.Images.Media.DATA };
				Cursor cursor = null;
				try {
					cursor = getContentResolver().query(selectedImage, filePathColumn,
							null, null, null);
					cursor.moveToFirst();
					int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
					String picturePath = cursor.getString(columnIndex);
					addBitmapToImageView(picturePath);
				} finally {
					cursor.close();
				}

			}
			break;
		case PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE:
			if (data != null) {
				boolean imageDeleted = data.getExtras().getBoolean(
						ImagePreviewActivity.IMAGE_DELETE_FLAG);
				if (imageDeleted) {
					String fileUri = data.getExtras().getString(
							ImagePreviewActivity.IMAGE_SRC_KEY);
					imageFileUriList.remove(fileUri);
					imageAdapter.notifyDataSetChanged();

					FileHelper.deleteCacheFile(fileUri);
				}
			}
			break;
		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void addBitmapToImageView(String fileUri) {
		imageFileUriList.add(fileUri);
		imageAdapter.notifyDataSetChanged();
	}

	protected void clean() {
		// 清理临时的图片文件
		if (imageFileUriList != null && !imageFileUriList.isEmpty()) {
			for (String fileName : imageFileUriList) {
				FileHelper.deleteCacheFile(fileName);
			}
		}
		imageFileUriList.clear();

	}

	class PicSelectAdapter extends BaseAdapter {

		public static final int IMAGE_VIEW_WIDTH = 150;

		@Override
		public int getCount() {
			return imageFileUriList.size() + 1;
		}

		@Override
		public Object getItem(int position) {
			return imageFileUriList.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		@Override
		public View getView(final int position, View convertView, ViewGroup parent) {
			ImageView imageView;
			if (convertView == null) {
				imageView = new ImageView(PicContainerActivity.this);
				imageView.setLayoutParams(new GridView.LayoutParams(IMAGE_VIEW_WIDTH,
						IMAGE_VIEW_WIDTH));//
				imageView.setAdjustViewBounds(false);
				imageView.setScaleType(ImageView.ScaleType.CENTER);
				imageView.setPadding(8, 8, 8, 8);
			} else {
				imageView = (ImageView) convertView;
			}

			if (position == imageFileUriList.size()) {
				imageView.setImageResource(R.drawable.add_camera);
				imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
				imageView.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						showPopupWindow(v);
					}
				});
			} else {
				final String image = (String) this.getItem(position);
				imageView.setBackgroundResource(0);
				imageView.setImageBitmap(FileHelper.decodeFile(image, true,
						IMAGE_VIEW_WIDTH, IMAGE_VIEW_WIDTH));

				imageView.setOnClickListener(new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(PicContainerActivity.this,
								ImagePreviewActivity.class);
						intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
						intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER,
								position);
						intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, true);
						intent.putExtra(ImagePreviewActivity.SHOW_BY_LOCAL_FILE, true);

						PicContainerActivity.this.startActivityForResult(intent,
								PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE);
					}
				});
			}
			return imageView;
		}

	}
}
