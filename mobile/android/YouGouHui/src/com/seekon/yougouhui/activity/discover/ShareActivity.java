package com.seekon.yougouhui.activity.discover;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.barcode.MipcaActivityCapture;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class ShareActivity extends Activity {

	private final String TAG = ShareActivity.class.getSimpleName();

	private static final int CAPTURE_IMAGE_ACTIVITY_REQUEST_CODE = 100;

	private static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 200;

	private static final int PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE = 300;

	private final static int SCANNIN_GREQUEST_CODE = 400;

	private GridView picContainer = null;

	private String title[] = { "拍照", "从文件获取" };

	private PopupWindow popupWindow;

	private List<String> imageFileUriList = new ArrayList<String>();

	private BaseAdapter imageAdapter;

	private Uri currentCameraFileUri = null;// 当前拍照的文件存放的路径

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.discover_share);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		picContainer = (GridView) findViewById(R.id.share_pic_container);
		// 设置GridView的列数
		DisplayMetrics displayMetrics = this.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels
				/ (SharePicSelectAdapter.IMAGE_VIEW_WIDTH + 20);
		picContainer.setNumColumns(colNumber);
		imageAdapter = new SharePicSelectAdapter();
		picContainer.setAdapter(imageAdapter);

		Button barcodeScan = (Button) findViewById(R.id.b_scan_shop_barcode);
		barcodeScan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent();
				intent.setClass(ShareActivity.this, MipcaActivityCapture.class);
				intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivityForResult(intent, SCANNIN_GREQUEST_CODE);
			}
		});
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
			goBackHome();
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
		super.onDestroy();
	}

	/**
	 * 返回到上一界面
	 */
	private void goBackHome() {
		clean();
		this.finish();
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
			if (resultCode == RESULT_OK) {
				addBitmapToImageView(currentCameraFileUri.getPath());
			}
			currentCameraFileUri = null;
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

				addBitmapToImageView(picturePath);
			}
		} else if (requestCode == PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE) {
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
		} else if (requestCode == SCANNIN_GREQUEST_CODE) {
			if (resultCode == RESULT_OK) {
				Bundle bundle = data.getExtras();
				EditText barcodeText = (EditText) findViewById(R.id.share_shop_barcode);
				barcodeText.setText(bundle.getString("result"));
				Logger.debug(TAG, "barcode:" + bundle.toString());
			}
		}

		super.onActivityResult(requestCode, resultCode, data);
	}

	private void addBitmapToImageView(String fileUri) {
		imageFileUriList.add(fileUri);
		imageAdapter.notifyDataSetChanged();
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

	private void publishShare() {
		EditText view = (EditText) findViewById(R.id.share_content);
		final String shareContent = view.getText().toString();
		
		view.setError(null);
		if(TextUtils.isEmpty(shareContent)){
			view.setError(this.getString(R.string.error_field_required));
			view.findFocus();
			return;
		}
		
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				ContentValues user = RunEnv.getInstance().getUser();
				Map share = new HashMap();
				share.put(ShareConst.COL_NAME_PUBLISHER, user.getAsString(COL_NAME_UUID));
				share.put(COL_NAME_CONTENT, shareContent);
				share.put(ShareConst.DATA_IMAGE_KEY, imageFileUriList);
				ShareProcessor processor = new ShareProcessor(ShareActivity.this);
				return processor.postShare(share);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				
				if (result == null) {
					ViewUtils.showToast("发布信息失败.");
					return;
				}
				if (result.getStatusCode() == 200) {
					Intent intent = new Intent();
					intent.putExtra(COL_NAME_CONTENT, shareContent);

					setResult(RESULT_OK, intent);
					clean();
					finish();
				} else {
					try {
						ViewUtils.showToast(result.getResource().getString("error"));
					} catch (JSONException e) {
						Logger.error(TAG, e.getMessage(), e);
					}
					return;
				}
			}
			
			@Override
			protected void onCancelled() {
				showProgress(false);
				super.onCancelled();
			}
		};

		showProgress(true);
		task.execute((Void) null);
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.discover_share), show,
				R.string.default_progress_status_message);
	}

	private void clean() {
		// 清理临时的图片文件
		if (imageFileUriList != null && !imageFileUriList.isEmpty()) {
			for (String fileName : imageFileUriList) {
				FileHelper.deleteCacheFile(fileName);
			}
		}
		imageFileUriList.clear();

		picContainer.setAdapter(null);
	}

	class SharePicSelectAdapter extends BaseAdapter {

		public static final int IMAGE_VIEW_WIDTH = 100;

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
				imageView = new ImageView(ShareActivity.this);
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
						Intent intent = new Intent(ShareActivity.this,
								ImagePreviewActivity.class);
						intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
						intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER,
								position);
						intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, true);
						intent.putExtra(ImagePreviewActivity.SHOW_BY_LOCAL_FILE, true);

						ShareActivity.this.startActivityForResult(intent,
								PREVIEW_IMAGE_ACTIVITY_REQUEST_CODE);
					}
				});
			}
			return imageView;
		}

	}

}
