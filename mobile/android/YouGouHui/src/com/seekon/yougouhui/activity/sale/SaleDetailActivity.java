package com.seekon.yougouhui.activity.sale;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleEntity;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;

public class SaleDetailActivity extends Activity{
	
	private SaleEntity sale = null;
	
	private SaleData saleData = null;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.channel_sale_detail);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		String saleId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);
		saleData = new SaleData(this);
		sale = saleData.getSale(saleId);
		
		initViews();
	}
	
	private void initViews(){
		
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
