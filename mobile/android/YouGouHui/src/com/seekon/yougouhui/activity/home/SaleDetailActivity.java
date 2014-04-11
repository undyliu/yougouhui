package com.seekon.yougouhui.activity.home;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.os.Bundle;
import android.view.MenuItem;

import com.seekon.yougouhui.func.sale.SaleConst;

/**
 * 活动详细
 * 
 * @author undyliu
 * 
 */
public class SaleDetailActivity extends Activity {

	private ContentValues message = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		message = (ContentValues) this.getIntent().getExtras()
				.get(SaleConst.DATA_SALE_KEY);

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
