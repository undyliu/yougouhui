package com.seekon.yougouhui.activity.contact;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.share.MyShareActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

/**
 * 朋友概况信息
 * 
 * @author undyliu
 * 
 */
public class FriendProfileActivity extends Activity {

	private final static int USER_ICON_WIDTH = 150;

	private UserEntity user = null;

	private TextView shareCountView;
	private TextView saleDiscussCountView;

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
		userPhotoView.setLayoutParams(new LinearLayout.LayoutParams(
				USER_ICON_WIDTH, USER_ICON_WIDTH));
		userPhotoView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		String photo = user.getPhoto();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance().displayImage(photo, userPhotoView, true);
		}

		TextView userNameView = (TextView) findViewById(R.id.user_name);
		userNameView.setText(user.getName());

		shareCountView = (TextView) findViewById(R.id.user_share_count);
		shareCountView.setText("0");// TODO
		shareCountView.getPaint().setFakeBoldText(true);

		shareCountView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(FriendProfileActivity.this,
						MyShareActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, user.getUuid());
				intent.putExtra(DataConst.COL_NAME_TITLE, user.getName() + "的分享");
				startActivity(intent);
			}
		});

		saleDiscussCountView = (TextView) findViewById(R.id.user_sale_discuss_count);
		saleDiscussCountView.setText("0");// TODO
		saleDiscussCountView.getPaint().setFakeBoldText(true);
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
