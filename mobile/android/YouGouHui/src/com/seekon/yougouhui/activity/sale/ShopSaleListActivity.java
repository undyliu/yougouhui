package com.seekon.yougouhui.activity.sale;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

public class ShopSaleListActivity extends Activity{
	
	private static final int SALE_PROMOTE_REQUEST_CODE = 1;
	
	private String shopId;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.shop_sale_list);
		
		shopId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_sale_info, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;
		case R.id.menu_shop_sale_publish:
			doSalePromote();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
	
	private void doSalePromote(){
		Intent intent = new Intent(this, SalePromoteActivity.class);
		intent.putExtra(DataConst.COL_NAME_UUID, shopId);
		startActivity(intent);
	}
}
