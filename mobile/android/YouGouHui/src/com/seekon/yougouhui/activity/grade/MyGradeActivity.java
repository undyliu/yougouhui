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
import com.seekon.yougouhui.func.user.UserEntity;

public class MyGradeActivity extends Activity {
	private static final int GRADE_SHOP_REQUEST_CODE = 1;
	private TextView gradeInfoView;

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
		UserEntity user = RunEnv.getInstance().getUser();
		StringBuffer gradeInfo = new StringBuffer();
		gradeInfo.append("<html><body>");
		gradeInfo.append("您好,");
		gradeInfo.append(user.getName() + ":<br><br>");
		gradeInfo.append("您尚剩余");
		gradeInfo.append("<font color=\"#00bbaa\">500</font>");
		gradeInfo.append("积分,其中");
		gradeInfo.append("<font color=\"red\">30</font>");
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
