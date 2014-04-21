package com.seekon.yougouhui.activity.contact;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

/**
 * 朋友概况信息
 * 
 * @author undyliu
 * 
 */
public class FriendProfileActivity extends Activity {

	private UserEntity user = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.friend_profile);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		Intent intent = this.getIntent();
		user = (UserEntity) intent.getSerializableExtra(UserConst.DATA_KEY_USER);

		actionBar.setTitle(user.getName());

		initViews();
	}

	private void initViews() {
		ImageView userPhotoView = (ImageView) findViewById(R.id.user_photo);
		String photo = user.getPhoto();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance().displayImage(photo, userPhotoView, true);
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.friend_profile, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.back();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void back() {
		Intent intent = new Intent();
		// intent.putExtra(UserConst.DATA_KEY_USER, user);
		this.setResult(RESULT_OK, intent);
		this.finish();
	}
}
