package com.seekon.yougouhui.activity.profile.shop;

import java.util.List;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.shop.ShopConst;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

public class ShopMainActivity extends Activity{

	private List<String> shopIdList = null;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.shop_main);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		Intent intent = this.getIntent();
		shopIdList = intent.getStringArrayListExtra(ShopConst.NAME_SHOP_LIST);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			logout();
			break;

		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
	
	private void logout(){
		this.finish();
	}
}
