package com.seekon.yougouhui.activity.user;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_NAME;

import java.util.HashMap;
import java.util.Map;

import android.annotation.TargetApi;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 帐号注册
 * 
 * @author undyliu
 * 
 */
public class RegisterActivity extends Activity {

	private static final int USER_ICON_WIDTH = 100;

	private static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 200;

	private EditText phoneView = null;
	private EditText nameView = null;
	private EditText pwdView = null;
	private EditText pwdConfView = null;
	private ImageView userIcon = null;
	private String userIconUri = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.register);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		phoneView = (EditText) findViewById(R.id.user_phone);
		nameView = (EditText) findViewById(R.id.user_name);
		pwdView = (EditText) findViewById(R.id.password);
		pwdConfView = (EditText) findViewById(R.id.password_conf);

		userIcon = (ImageView) findViewById(R.id.user_icon);
		userIcon.setLayoutParams(new FrameLayout.LayoutParams(USER_ICON_WIDTH,
				USER_ICON_WIDTH));

		userIcon.setOnClickListener(new View.OnClickListener() {
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
		this.getMenuInflater().inflate(R.menu.register, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_register_user:
			registerUser(item);
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
				Cursor cursor = null;
				try {
					cursor = getContentResolver().query(selectedImage, filePathColumn,
							null, null, null);
					cursor.moveToFirst();
					int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
					userIconUri = cursor.getString(columnIndex);
				} finally {
					cursor.close();
				}
				addUserIconToView(userIconUri);
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
	private void addUserIconToView(String userIconPath) {
		userIcon.setBackgroundResource(0);
		userIcon.setBackground(new BitmapDrawable(FileHelper.decodeFile(
				userIconPath, true, USER_ICON_WIDTH, USER_ICON_WIDTH)));
		final ImageButton iconDel = (ImageButton) findViewById(R.id.user_icon_del);
		iconDel.setVisibility(View.VISIBLE);
		iconDel.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				userIcon.setBackgroundResource(R.drawable.add_camera);

				iconDel.setVisibility(View.GONE);
			}
		});
	}

	private void registerUser(final MenuItem item) {
		phoneView.setError(null);
		nameView.setError(null);
		pwdView.setError(null);
		pwdConfView.setError(null);

		boolean cancel = false;
		View focusView = null;

		String fieldRequired = getString(R.string.error_field_required);

		final String password = pwdView.getText().toString();

		final String passwordConf = pwdConfView.getText().toString();
		if (TextUtils.isEmpty(passwordConf)) {
			pwdConfView.setError(fieldRequired);
			focusView = pwdConfView;
			cancel = true;
		} else if (passwordConf.length() < 4) {
			pwdConfView.setError(getString(R.string.error_invalid_password));
			focusView = pwdConfView;
			cancel = true;
		}
		if (!password.equals(passwordConf)) {
			pwdConfView.setError(getString(R.string.error_password_inconfirmed));
			focusView = pwdConfView;
			cancel = true;
		}

		if (TextUtils.isEmpty(password)) {
			pwdView.setError(fieldRequired);
			focusView = pwdView;
			cancel = true;
		} else if (password.length() < 4) {
			pwdView.setError(getString(R.string.error_invalid_password));
			focusView = pwdView;
			cancel = true;
		}

		final String name = nameView.getText().toString();
		if (TextUtils.isEmpty(name)) {
			nameView.setError(fieldRequired);
			focusView = nameView;
			cancel = true;
		}

		final String phone = phoneView.getText().toString();
		if (TextUtils.isEmpty(phone)) {
			phoneView.setError(fieldRequired);
			focusView = phoneView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}

		final Map<String, String> user = new HashMap<String, String>();
		user.put(COL_NAME_PHONE, phone);
		user.put(COL_NAME_USER_NAME, name);
		user.put(COL_NAME_PWD, password);
		user.put(COL_NAME_USER_ICON, userIconUri);

		item.setEnabled(false);
		showProgress(true);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"注册失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return UserProcessor.getInstance(RegisterActivity.this)
								.registerUser(user);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						Intent intent = new Intent();
						intent.putExtra(UserConst.KEY_REGISTER_USER,
								ContentValuesUtils.fromMap(user, null));
						setResult(RESULT_OK, intent);
						finish();
					}

					@Override
					public void onFailed(String errorMessage) {
						onCancelled();
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						showProgress(false);
						super.onCancelled();
					}
				});
	}

	private void showProgress(final boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.register_main), show);
	}
}