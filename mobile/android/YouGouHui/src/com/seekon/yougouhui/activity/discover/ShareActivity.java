package com.seekon.yougouhui.activity.discover;

import java.io.File;
import java.io.FileOutputStream;

import android.app.ActionBar;
import android.app.Activity;
import android.graphics.drawable.BitmapDrawable;
import android.hardware.Camera;
import android.hardware.Camera.AutoFocusCallback;
import android.hardware.Camera.PictureCallback;
import android.os.Bundle;
import android.util.Log;
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
import com.seekon.yougouhui.layout.FixGridLayout;
import com.seekon.yougouhui.util.CameraUtils;
import com.seekon.yougouhui.widget.CameraPreview;

public class ShareActivity extends Activity {

	private final String TAG = ShareActivity.class.getSimpleName();
	
	FixGridLayout picContainer = null;

	int[] imageSrc = new int[] { R.drawable.compare, R.drawable.contact_list };
	int curImageIndex = 0;

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
		picContainer.setmCellHeight(90);
		picContainer.setmCellWidth(90);

		final LayoutInflater inflater = getLayoutInflater();
		FrameLayout fl = (FrameLayout) inflater.inflate(
				R.layout.discover_share_pic_item, null);

		fl.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				FrameLayout con = (FrameLayout) inflater.inflate(
						R.layout.discover_share_pic_item, null);
				ImageView pic = (ImageView) con.findViewById(R.id.share_pic);
				// curImageIndex = (curImageIndex + 1) % imageSrc.length;
				// pic.setBackgroundResource(imageSrc[curImageIndex]);
				// picContainer.addView(con, picContainer.getChildCount() - 1);
				//
				// picContainer.postInvalidate(); // 提示UI重绘界面

				// int y = pic.getBottom() * 3 / 2;
				// int x = getWindowManager().getDefaultDisplay().getWidth() / 4;

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
		popupWindow.setHeight(80);
		popupWindow.setOutsideTouchable(true);
		popupWindow.setFocusable(true);
		popupWindow.setContentView(layout);
		// showAsDropDown会把里面的view作为参照物，所以要那满屏幕parent
		// popupWindow.showAsDropDown(findViewById(R.id.tv_title), x, 10);
		// popupWindow.showAtLocation(findViewById(R.id.discover_share),
		// Gravity.LEFT
		// | Gravity.TOP, x, y);// 需要指定Gravity，默认情况是center.
		popupWindow.showAsDropDown(v);

		listView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				// button.setText(title[arg2]);
				if (position == 0) {
					openCamera();
				}
				popupWindow.dismiss();
				popupWindow = null;
			}
		});
	}

	private void openCamera() {
		camera = CameraUtils.getCameraInstance();
		if(camera == null){
			return;
		}
		CameraPreview cameraPreview = new CameraPreview(this, camera);

		camera.autoFocus(new AutoFocusCallback() {

			@Override
			public void onAutoFocus(boolean success, Camera camera) {
				camera.takePicture(null, null, new PictureCallback() {

					@Override
					public void onPictureTaken(byte[] data, Camera camera) {
						// 获取Jpeg图片，并保存在sd卡上
//						File pictureFile = new File("/sdcard/" + System.currentTimeMillis()
//								+ ".jpg");
//						try {
//							FileOutputStream fos = new FileOutputStream(pictureFile);
//							fos.write(data);
//							fos.close();
//						} catch (Exception e) {
//							Log.d(TAG, "保存图片失败");
//						}
					}
				});
			}
		});
	}

	// public void deleteView(View view) {
	// picContainer.removeView((View) view.getParent());
	// picContainer.invalidate();
	// }

	private void publishShare() {

	}
}
