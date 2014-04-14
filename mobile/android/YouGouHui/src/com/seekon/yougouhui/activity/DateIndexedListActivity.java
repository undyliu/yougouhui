package com.seekon.yougouhui.activity;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ClearEditText;

public abstract class DateIndexedListActivity extends Activity implements
		IXListViewListener {

	protected List<DateIndexedEntity> dataList = new ArrayList<DateIndexedEntity>();

	protected XListView listView = null;

	protected ClearEditText mClearEditText;

	protected DateIndexedListAdapter listAdapter = null;

	protected String searchWord = "";

	private Handler mHandler;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.searched_xlistview);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
	}

	protected void initViews() {
		dataList = this.getDateIndexedEntityList();
		mHandler = new Handler();

		listView = (XListView) findViewById(R.id.listview_main);
		listView.setPullLoadEnable(true);
		listView.setXListViewListener(this);

		listAdapter = getListAdapter();
		listView.setAdapter(listAdapter);

		mClearEditText = (ClearEditText) findViewById(R.id.listview_filter_edit);
		mClearEditText.setOnKeyListener(new View.OnKeyListener() {
			@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (keyCode == KeyEvent.KEYCODE_ENTER) {
					String word = mClearEditText.getText().toString();
//					if (TextUtils.isEmpty(word)) {
//						mClearEditText.setError(getString(R.string.error_field_required));
//						return false;
//					}
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
				if(s == null || s.length() == 0){
					filterData("");
				}
			}
			
			@Override
			public void beforeTextChanged(CharSequence s, int start, int count, int after) {
				
			}
			
			@Override
			public void afterTextChanged(Editable s) {
				
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

	private void filterData(String word) {
		ViewUtils.hideInputMethodWindow(DateIndexedListActivity.this);
		searchWord = word;
		doFilterData(word);
	}

	protected void updateListView() {
		listAdapter.notifyDataSetChanged();
		onPostLoad();
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
				dataList.addAll(getDateIndexedEntityList());
				updateListView();
			}
		}, 2000);
	}

	public abstract void doFilterData(String word);

	public abstract DateIndexedListAdapter getListAdapter();

	public abstract List<DateIndexedEntity> getDateIndexedEntityList();

}
