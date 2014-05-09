package com.seekon.yougouhui.activity.grade;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.grade.GradeItemsEntity;
import com.seekon.yougouhui.func.grade.widget.GradeItemsListAdapter;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.func.user.UserProfileConst;
import com.seekon.yougouhui.func.user.UserProfileEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.Logger;

public class GradeItemsActivity extends Activity {
	private static final String TAG = GradeItemsActivity.class.getSimpleName();

	private TextView gradeItemsView;
	private ListView listView;
	private GradeItemsListAdapter listAdapter;

	private UserProfileEntity userProfile;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.grade_items);

		userProfile = (UserProfileEntity) this.getIntent().getSerializableExtra(
				UserProfileConst.DATA_KEY_USER_PROFILE);

		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		gradeItemsView = (TextView) findViewById(R.id.grade_items_info);

		initTableTitle();

		listAdapter = new GradeItemsListAdapter(this,
				new ArrayList<GradeItemsEntity>());

		listView = (ListView) findViewById(R.id.listview_main);
		listView.setAdapter(listAdapter);

		loadGradeItemsData();
	}

	private void initTableTitle() {
		int itemBaseWith = this.getResources().getDisplayMetrics().widthPixels / 9;

		TextView gradeTimeView = (TextView) findViewById(R.id.grade_time);
		gradeTimeView.setText(R.string.label_grade_time);
		gradeTimeView.setWidth(itemBaseWith * 2);
		// gradeTimeView.setTextSize(16);

		TextView shopNameView = (TextView) findViewById(R.id.shop_name);
		shopNameView.setText(R.string.label_shop_name);
		shopNameView.setWidth(itemBaseWith * 3);
		// shopNameView.setTextSize(16);

		TextView gradeAmountView = (TextView) findViewById(R.id.grade_amount);
		gradeAmountView.setText(R.string.label_grade_amount);
		gradeAmountView.setWidth(itemBaseWith);
		// gradeAmountView.setTextSize(16);

		TextView gradeUsedView = (TextView) findViewById(R.id.grade_used);
		gradeUsedView.setText(R.string.label_grade_used);
		gradeUsedView.setWidth(itemBaseWith);
		// gradeUsedView.setTextSize(16);

		TextView endTimeView = (TextView) findViewById(R.id.end_time);
		endTimeView.setText(R.string.label_end_time);
		endTimeView.setWidth(itemBaseWith * 2);
		// endTimeView.setTextSize(16);
	}

	private void loadGradeItemsData() {
		StringBuffer gradeInfo = new StringBuffer();
		gradeInfo.append("<html><body>");
		gradeInfo.append("您共有" + userProfile.getGradeAmount() + "积分,已消费"
				+ userProfile.getGradeUsed() + "积分,剩余");
		gradeInfo.append("<font color=\"#00bbaa\">" + userProfile.getGradeRemain()
				+ "</font>");
		gradeInfo.append("积分<br>其中");
		gradeInfo.append("<font color=\"red\">" + userProfile.getGradeExceed()
				+ "</font>");
		gradeInfo.append("积分即将过期.");
		gradeInfo.append("</body></html>");

		gradeItemsView.setText(Html.fromHtml(gradeInfo.toString()));

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONArrayResource>("获取积分明细失败.") {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return UserProcessor.getInstance(GradeItemsActivity.this)
								.getUserGradeItems(RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						JSONArrayResource resource = result.getResource();
						if (resource.length() > 0) {
							List<GradeItemsEntity> dataList = new ArrayList<GradeItemsEntity>();
							try {
								for (int i = 0; i < resource.length(); i++) {
									GradeItemsEntity entity = new GradeItemsEntity();
									JSONObject obj = resource.getJSONObject(i);

									entity.setUuid(obj.getString(DataConst.COL_NAME_UUID));
									entity.setUserId(RunEnv.getInstance().getUser().getUuid());
									entity.setEndTime(obj.getLong(UserProfileConst.NAME_END_TIME));
									entity.setGradeAmout(obj
											.getInt(UserProfileConst.COL_NAME_GRADE_AMOUNT));
									entity.setGradeUsed(obj
											.getInt(UserProfileConst.COL_NAME_GRADE_USED));
									entity.setGrader(obj.getString(UserProfileConst.NAME_GRADER));
									entity.setGradeTime(obj
											.getLong(UserProfileConst.NAME_GRADE_TIME));

									ShopEntity shop = new ShopEntity();
									shop.setUuid(obj.getString(SaleConst.COL_NAME_SHOP_ID));
									shop.setName(obj.getString(SaleConst.COL_NAME_SHOP_NAME));
									entity.setShop(shop);

									dataList.add(entity);
								}

								listAdapter.updateData(dataList);
							} catch (Exception e) {
								Logger.error(TAG, e.getMessage(), e);
								throw new RuntimeException(e);
							}
						}
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

}
