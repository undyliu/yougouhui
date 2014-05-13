package com.seekon.yougouhui.activity.contact;

import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_SALE_DIS_COUNT;
import static com.seekon.yougouhui.func.user.UserProfileConst.COL_NAME_SHARE_COUNT;
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
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

/**
 * 朋友概况信息
 * 
 * @author undyliu
 * 
 */
public class FriendProfileActivity extends Activity {

	private final static int USER_ICON_WIDTH = 150;

	private UserEntity friend = null;

	private TextView shareCountView;
	private TextView saleDiscussCountView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.friend_profile);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		Intent intent = this.getIntent();
		friend = (UserEntity) intent.getSerializableExtra(UserConst.DATA_KEY_USER);

		actionBar.setTitle(friend.getName());

		initViews();
	}

	private void initViews() {
		ImageView userPhotoView = (ImageView) findViewById(R.id.user_photo);
		userPhotoView.setLayoutParams(new LinearLayout.LayoutParams(
				USER_ICON_WIDTH, USER_ICON_WIDTH));
		userPhotoView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		String photo = friend.getPhoto();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance().displayImage(photo, userPhotoView, true);
		}

		TextView userNameView = (TextView) findViewById(R.id.user_name);
		userNameView.setText(friend.getName());

		shareCountView = (TextView) findViewById(R.id.user_share_count);
		shareCountView.getPaint().setFakeBoldText(true);

		findViewById(R.id.row_user_share).setOnClickListener(
				new View.OnClickListener() {

					@Override
					public void onClick(View v) {
						Intent intent = new Intent(FriendProfileActivity.this,
								MyShareActivity.class);
						intent.putExtra(DataConst.COL_NAME_UUID, friend.getUuid());
						intent.putExtra(DataConst.COL_NAME_TITLE, friend.getName() + "的分享");
						startActivity(intent);
					}
				});

		saleDiscussCountView = (TextView) findViewById(R.id.user_sale_discuss_count);
		saleDiscussCountView.getPaint().setFakeBoldText(true);

		findViewById(R.id.row_user_sale_dis).setOnClickListener(
				new View.OnClickListener() {

					@Override
					public void onClick(View v) {

					}
				});

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return UserProcessor.getInstance(FriendProfileActivity.this)
								.getUserProfile(friend);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						JSONObjResource resource = result.getResource();
						if (resource.has(COL_NAME_SHARE_COUNT)) {
							shareCountView.setText(JSONUtils.getJSONStringValue(resource,
									COL_NAME_SHARE_COUNT));
						}
						if (resource.has(COL_NAME_SALE_DIS_COUNT)) {
							saleDiscussCountView.setText(JSONUtils.getJSONStringValue(
									resource, COL_NAME_SALE_DIS_COUNT));
						}
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);

						shareCountView.setText("0");
						saleDiscussCountView.setText("0");
					}

				});

		// TODO: v1.1版本中增加此功能
		// Button sendMessButton = (Button) findViewById(R.id.b_send_message);
		// final UserEntity user = RunEnv.getInstance().getUser();
		// if(user.getFriends().contains(friend)){
		// sendMessButton.setVisibility(View.VISIBLE);
		// sendMessButton.setOnClickListener(new View.OnClickListener() {
		//
		// @Override
		// public void onClick(View v) {
		// Intent intent = new Intent(FriendProfileActivity.this,
		// MessageBoardActivity.class);
		// intent.putExtra(MessageConst.COL_NAME_RECEIVER, friend);
		// startActivity(intent);
		// }
		// });
		// }
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
