package com.seekon.yougouhui.activity.shop;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.shop.widget.ShopShareListView;

public class ShareInteractAcitivity extends Activity {

	private static final int SHARE_REPLY_REQUEST_CODE = 1;
	
	private ShopShareListView listView;

	private int selectedPosition = -1;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_share_list);

		initViews();

		String shopId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);
		listView.loadData(shopId);
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		listView = (ShopShareListView) findViewById(R.id.listview_main);
		listView.init();

		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				selectedPosition = position - 1;
				ShareEntity share = listView.getDataEntity(selectedPosition);
				Intent intent = new Intent(ShareInteractAcitivity.this, ShareReplyActivity.class);
				intent.putExtra(ShareConst.DATA_SHARE_KEY, share);
				startActivityForResult(intent, SHARE_REPLY_REQUEST_CODE);
			}
		});
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;

		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
}
