package com.seekon.yougouhui.activity.grade;

import java.util.ArrayList;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.text.Html;
import android.view.MenuItem;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.grade.GradeItemsEntity;
import com.seekon.yougouhui.func.grade.widget.GradeItemsListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;

public class GradeItemsActivity extends Activity implements IXListViewListener {

	private TextView gradeItemsView;
	private XListView listView;
	private GradeItemsListAdapter listAdapter;

	private Handler mHandler;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.grade_items);

		mHandler = new Handler();

		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		gradeItemsView = (TextView) findViewById(R.id.grade_items_info);

		listAdapter = new GradeItemsListAdapter(this,
				new ArrayList<GradeItemsEntity>());

		listView = (XListView) findViewById(R.id.listview_main);
		listView.setPullLoadEnable(true);
		listView.setXListViewListener(this);
		listView.setAdapter(listAdapter);

		loadGradeItemsData();
	}

	private void loadGradeItemsData() {
		StringBuffer gradeInfo = new StringBuffer();
		gradeInfo.append("<html><body>");
		gradeInfo.append("您共有800积分,已消费300积分,剩余");
		gradeInfo.append("<font color=\"#00bbaa\">500</font>");
		gradeInfo.append("积分<br><br>其中");
		gradeInfo.append("<font color=\"red\">30</font>");
		gradeInfo.append("积分将于 2014年6月1日 过期.");
		gradeInfo.append("</body></html>");

		gradeItemsView.setText(Html.fromHtml(gradeInfo.toString()));
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

	private void onPostLoad() {
		listView.stopRefresh();
		listView.stopLoadMore();
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {

				onPostLoad();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				onPostLoad();
			}
		}, 2000);
	}
}
