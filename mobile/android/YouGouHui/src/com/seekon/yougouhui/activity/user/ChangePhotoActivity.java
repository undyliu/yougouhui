package com.seekon.yougouhui.activity.user;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 修改用户头像
 * 
 * @author undyliu
 * 
 */
public class ChangePhotoActivity extends Activity {

	private static final int USER_ICON_WIDTH = 200;

	private static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 200;

	private ImageView photoView = null;
	private ContentValues user = null;
	private String userIconUri = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.user_photo);

		user = RunEnv.getInstance().getUser();

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		photoView = (ImageView) findViewById(R.id.user_icon);
		photoView.setLayoutParams(new FrameLayout.LayoutParams(USER_ICON_WIDTH,
				USER_ICON_WIDTH));
		photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		
		userIconUri = user.getAsString(COL_NAME_USER_ICON);
		if (userIconUri != null && userIconUri.length() > 0) {
			addUserIconToView(true);
		}else{
			photoView.setImageResource(R.drawable.add_camera);
		}

		photoView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_IMAGE_ACTIVITY_REQUEST_CODE);
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		this.getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			changeUserPhoto(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == LOAD_IMAGE_ACTIVITY_REQUEST_CODE) {
			if (resultCode == RESULT_OK && null != data) {
				Uri selectedImage = data.getData();
				String[] filePathColumn = { MediaStore.Images.Media.DATA };
				Cursor cursor = getContentResolver().query(selectedImage,
						filePathColumn, null, null, null);
				cursor.moveToFirst();
				int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
				userIconUri = cursor.getString(columnIndex);
				cursor.close();

				addUserIconToView(false);
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void addUserIconToView(boolean fileName) {
		if (fileName) {
			ImageLoader.getInstance().displayImage(userIconUri, photoView, true);
		} else {
			photoView.setImageBitmap(FileHelper.decodeFile(userIconUri, true,
					USER_ICON_WIDTH, USER_ICON_WIDTH));
		}

		final ImageButton iconDel = (ImageButton) findViewById(R.id.user_icon_del);
		iconDel.setVisibility(View.VISIBLE);
		iconDel.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				photoView.setImageResource(R.drawable.add_camera);
				iconDel.setVisibility(View.GONE);
				userIconUri = "";
			}
		});
	}

	private void changeUserPhoto(final MenuItem item) {

		ContentValues user = RunEnv.getInstance().getUser();
		if (userIconUri.equals(user.get(COL_NAME_USER_ICON))) {
			ViewUtils.showToast("头像未做修改，不需要保存更新.");
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return UserProcessor.getInstance(ChangePhotoActivity.this)
						.updateUserPhoto(userIconUri);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				int status = result.getStatusCode();
				if (status == 200) {
					Intent intent = new Intent();
					setResult(RESULT_OK, intent);
					finish();
				} else {
					ViewUtils.showToast("修改失败.");
				}
				item.setEnabled(true);
				super.onPostExecute(result);
			}
			
			@Override
			protected void onCancelled() {
				showProgress(false);
				item.setEnabled(true);
				super.onCancelled();
			}
		};
		
		showProgress(true);
		item.setEnabled(false);
		task.execute((Void) null);
	}
	
	private void showProgress(final boolean show) {
		ViewUtils
				.showProgress(this, this.findViewById(R.id.user_photo_change), show);
	}
}
