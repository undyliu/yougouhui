package com.seekon.yougouhui.activity.grade;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.user.UserProfileConst;
import com.seekon.yougouhui.func.user.UserProfileEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;

public class MyGradeActivity extends Activity {
	private final static String TAG = MyGradeActivity.class.getSimpleName();

	private static final int GRADE_SHOP_REQUEST_CODE = 1;
	private TextView gradeInfoView;

	private UserProfileEntity userProfile;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.my_grade);

		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		gradeInfoView = (TextView) findViewById(R.id.my_grade_info);

		Button gradeItems = (Button) findViewById(R.id.b_grade_item);
		gradeItems.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(MyGradeActivity.this,
						GradeItemsActivity.class);
				intent.putExtra(UserProfileConst.DATA_KEY_USER_PROFILE, userProfile);
				startActivity(intent);
			}
		});

		Button gradeShop = (Button) findViewById(R.id.b_grade_shop);
		gradeShop.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(MyGradeActivity.this,
						GradeShopActivity.class);
				startActivityForResult(intent, GRADE_SHOP_REQUEST_CODE);
			}
		});

		getGradeAmout();
	}

	private void getGradeAmout() {

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("获取积分数据失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return UserProcessor.getInstance(MyGradeActivity.this)
								.getUserTotalGrade(RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						UserProfileEntity userProfile = new UserProfileEntity(RunEnv
								.getInstance().getUser());
						JSONObjResource resource = result.getResource();
						try {
							userProfile.setGradeAmount(resource
									.getInt(UserProfileConst.COL_NAME_GRADE_AMOUNT));
							userProfile.setGradeUsed(resource
									.getInt(UserProfileConst.COL_NAME_GRADE_USED));
							userProfile.setGradeExceed(resource
									.getInt(UserProfileConst.NAME_GRADE_EXCEED));
						} catch (Exception e) {
							Logger.warn(TAG, e.getMessage(), e);
						}
						udpateGradeInfoView(userProfile);
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						udpateGradeInfoView(new UserProfileEntity(RunEnv.getInstance()
								.getUser()));
					}
				});

	}

	private void udpateGradeInfoView(UserProfileEntity userProfile) {
		this.userProfile = userProfile;

		final StringBuffer gradeInfo = new StringBuffer();
		gradeInfo.append("<html><body>");
		gradeInfo.append("您好,");
		gradeInfo.append(userProfile.getUser().getName() + ":<br><br>");

		gradeInfo.append("目前您尚剩余");
		gradeInfo.append("<font color=\"#00bbaa\">" + userProfile.getGradeRemain()
				+ "</font>");
		gradeInfo.append("积分,其中");
		gradeInfo.append("<font color=\"red\">" + userProfile.getGradeExceed()
				+ "</font>");
		gradeInfo.append("积分即将过期.");
		gradeInfo.append("</body></html>");

		gradeInfoView.setText(Html.fromHtml(gradeInfo.toString()));
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
		case GRADE_SHOP_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				// TODO:如果兑换了商品，剩余积分更新
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
