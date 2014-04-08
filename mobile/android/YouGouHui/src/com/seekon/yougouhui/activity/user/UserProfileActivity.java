package com.seekon.yougouhui.activity.user;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;

public class UserProfileActivity extends Activity {

	private static final int PHOTO_ACTIVITY_REQUEST_CODE = 1;
	private static final int NAME_ACTIVITY_REQUEST_CODE = 2;
	private static final int PASSWORD_ACTIVITY_REQUEST_CODE = 3;

	private static final int USER_ICON_WIDTH = 75;

	private TextView nickNameView = null;
	private ImageView userIconView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.user_profile);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		UserEntity user = RunEnv.getInstance().getUser();
		if (user == null) {
			return;
		}

		TextView view = (TextView) findViewById(R.id.user_phone);
		view.setText(user.getPhone());

		nickNameView = (TextView) findViewById(R.id.user_name);
		nickNameView.setText(user.getName());

		findViewById(R.id.row_user_name).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(UserProfileActivity.this,
								ChangeNickNameActivity.class);
						startActivityForResult(intent, NAME_ACTIVITY_REQUEST_CODE);
					}
				});

		view = (TextView) findViewById(R.id.password);
		view.setText("......");

		findViewById(R.id.row_password).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(UserProfileActivity.this,
								ChangeUserPwdActivity.class);
						startActivityForResult(intent, PASSWORD_ACTIVITY_REQUEST_CODE);
					}
				});

		userIconView = (ImageView) findViewById(R.id.user_icon);
		userIconView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		String userIconUri = user.getPhoto();
		if (userIconUri != null && userIconUri.length() > 0) {
			userIconView.setLayoutParams(new LinearLayout.LayoutParams(
					USER_ICON_WIDTH, USER_ICON_WIDTH));
			ImageLoader.getInstance().displayImage(userIconUri, userIconView, true);
		} else {
			userIconView.setImageResource(R.drawable.default_user_photo);
		}

		findViewById(R.id.row_user_icon).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(UserProfileActivity.this,
								ChangeUserPhotoActivity.class);
						startActivityForResult(intent, PHOTO_ACTIVITY_REQUEST_CODE);
					}
				});
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case NAME_ACTIVITY_REQUEST_CODE:
			if (resultCode == RESULT_OK) {
				String nickName = RunEnv.getInstance().getUser().getName();
				nickNameView.setText(nickName);
			}
			break;
		case PASSWORD_ACTIVITY_REQUEST_CODE:
			if (resultCode == RESULT_OK) {
				// do nothing
			}
			break;
		case PHOTO_ACTIVITY_REQUEST_CODE:
			if (resultCode == RESULT_OK) {
				String userIconUri = RunEnv.getInstance().getUser().getPhoto();
				if (userIconUri != null && userIconUri.length() > 0) {
					userIconView.setLayoutParams(new LinearLayout.LayoutParams(
							USER_ICON_WIDTH, USER_ICON_WIDTH));
					ImageLoader.getInstance().displayImage(userIconUri, userIconView,
							true);
				} else {
					userIconView.setImageResource(R.drawable.default_user_photo);
				}
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
