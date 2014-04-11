package com.seekon.yougouhui.activity.profile.shop;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopProcessor;
import com.seekon.yougouhui.func.profile.shop.ShopUtils;
import com.seekon.yougouhui.func.profile.shop.widget.ChooseShopListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ClearEditText;

public class ChooseShopActivity extends Activity {
	private final static String TAG = ChooseShopActivity.class.getSimpleName();

	private ClearEditText mClearEditText;
	private ChooseShopListAdapter chooseShopListAdapter = null;

	private String searchWord = "";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.choose_shop);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.choose_shop, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_shop_choose_confirm:
			shopChooseConfirm();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		chooseShopListAdapter = new ChooseShopListAdapter(this,
				new ArrayList<ShopEntity>());
		ListView resultView = (ListView) findViewById(R.id.result_shop_list);
		resultView.setAdapter(chooseShopListAdapter);
		resultView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				ShopEntity shop = (ShopEntity) chooseShopListAdapter.getItem(position);
				Intent intent = new Intent(ChooseShopActivity.this, ShopBaseInfoActivity.class);
				intent.putExtra(ShopConst.COL_NAME_UUID, shop.getUuid());
				startActivity(intent);
			}
		});
		
		mClearEditText = (ClearEditText) findViewById(R.id.shop_filter_edit);
		mClearEditText.setOnKeyListener(new View.OnKeyListener() {
			@Override
			public boolean onKey(View v, int keyCode, KeyEvent event) {
				if (keyCode == KeyEvent.KEYCODE_ENTER) {
					String word = mClearEditText.getText().toString();
					if (TextUtils.isEmpty(word)) {
						mClearEditText.setError(getString(R.string.error_field_required));
						return false;
					}
					if (!searchWord.equals(word)) {
						ViewUtils.hideInputMethodWindow(ChooseShopActivity.this);
						filterData(word);
					}
					return true;
				}
				return false;
			}
		});
	}

	private void filterData(final String word) {
		searchWord = word;
		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>>() {

			@Override
			protected RestMethodResult<JSONArrayResource> doInBackground(
					Void... params) {
				return ShopProcessor.getInstance(ChooseShopActivity.this).searchShops(
						word);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
				String errorMessage = "获取商家数据失败.";
				if (result.getStatusCode() == 200) {
					try {
						List<ShopEntity> shopList = new ArrayList<ShopEntity>();
						JSONArrayResource resource = result.getResource();
						for (int i = 0; i < resource.length(); i++) {
							JSONObject data = resource.getJSONObject(i);
							shopList.add(ShopUtils.createFromJSONObject(data));
						}
						chooseShopListAdapter.updateData(shopList);
						if(shopList.isEmpty()){
							ViewUtils.showToast("没找到符合条件的商家.");
						}
						return;
					} catch (Exception e) {
						Logger.warn(TAG, e.getMessage());
					}
				}
				ViewUtils.showToast(errorMessage);
			}

		};

		task.execute((Void) null);
	}

	private void shopChooseConfirm() {
		ShopEntity checkedShop = chooseShopListAdapter.getCheckedShop();
		Intent intent = new Intent();
		intent.putExtra(ShopConst.DATA_SHOP_KEY, checkedShop);
		setResult(RESULT_OK, intent);
		finish();
	}
}
