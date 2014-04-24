package com.seekon.yougouhui.activity.shop;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.shop.widget.ShopShareListView;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ClearEditText;

public class ShareInteractAcitivity extends Activity {

	private static final int SHARE_REPLY_REQUEST_CODE = 1;

	private ShopShareListView listView;

	protected ClearEditText mClearEditText;

	private String searchWord = "";

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
				Intent intent = new Intent(ShareInteractAcitivity.this,
						ShareReplyActivity.class);
				intent.putExtra(ShareConst.DATA_SHARE_KEY, share);
				startActivityForResult(intent, SHARE_REPLY_REQUEST_CODE);
			}
		});

		mClearEditText = (ClearEditText) findViewById(R.id.listview_filter_edit);
		mClearEditText.setOnKeyListener(new View.OnKeyListener() {
			@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (keyCode == KeyEvent.KEYCODE_ENTER) {
					String word = mClearEditText.getText().toString();
					if (!searchWord.equals(word)) {
						filterData(word);
					}
					return true;
				}
				return false;
			}
		});

		mClearEditText.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				if (s == null || s.length() == 0) {
					filterData("");
				}
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {

			}

			@Override
			public void afterTextChanged(Editable s) {

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

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case SHARE_REPLY_REQUEST_CODE:
			if(resultCode == RESULT_OK && data != null && selectedPosition > 0){
				ShareEntity share = (ShareEntity) data.getSerializableExtra(ShareConst.DATA_SHARE_KEY);
				listView.getEntityListAdapter().updateEntity(share, selectedPosition);
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	private void filterData(String word) {
		ViewUtils.hideInputMethodWindow(ShareInteractAcitivity.this);
		searchWord = word;
		listView.filterData(searchWord);
	}
}
