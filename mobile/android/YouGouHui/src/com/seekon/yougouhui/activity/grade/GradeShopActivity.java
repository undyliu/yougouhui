package com.seekon.yougouhui.activity.grade;

import com.seekon.yougouhui.R;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;

public class GradeShopActivity extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.grade_shop);

		initViews();
	}
	
	private void initViews(){
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
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
