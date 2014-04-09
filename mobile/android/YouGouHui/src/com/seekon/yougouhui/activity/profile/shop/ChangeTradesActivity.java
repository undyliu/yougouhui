package com.seekon.yougouhui.activity.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.ActionBar;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CompoundButton;
import android.widget.GridView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopTradeProcessor;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.profile.shop.widget.GetTradesTask;
import com.seekon.yougouhui.func.profile.shop.widget.TradeCheckedChangeActivity;
import com.seekon.yougouhui.func.profile.shop.widget.TradeListAdapter;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class ChangeTradesActivity extends TradeCheckedChangeActivity {

	private List<TradeEntity> trades = new ArrayList<TradeEntity>();

	private List<TradeEntity> checkedTradeList = null;

	private ShopEntity shop;

	private TradeListAdapter tradeListAdatper;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_change_trades);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		shop = (ShopEntity) this.getIntent().getSerializableExtra(
				ShopConst.DATA_SHOP_KEY);
		checkedTradeList = shop.getTrades();

		initViews();
		loadTradeList();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			saveTrades(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		GridView view = (GridView) findViewById(R.id.shop_trade_view);
		tradeListAdatper = new TradeListAdapter(this, getTradeMapList());
		view.setAdapter(tradeListAdatper);
	}

	private void loadTradeList() {
		loadTradeListFromLocal();
		if (trades.isEmpty()) {
			loadTradeListFromRemote();
		} else {
			updateViews();
		}
	}

	private void loadTradeListFromLocal() {
		Cursor cursor = null;
		try {
			cursor = this.getContentResolver().query(TradeConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME }, null,
					null, COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				int i = 0;
				trades.add(new TradeEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++)));
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
	}

	private void loadTradeListFromRemote() {
		GetTradesTask task = new GetTradesTask(this,
				new TaskCallback<RestMethodResult<JSONArrayResource>>() {

					@Override
					public void onPostExecute(RestMethodResult<JSONArrayResource> result) {
						if (result.getStatusCode() == 200) {
							loadTradeListFromLocal();
							updateViews();
						} else {
							ViewUtils.showToast("加载主营业务数据失败.");
						}
					}

					@Override
					public void onCancelled() {

					}
				});
		task.execute((Void) null);
	}

	private void updateViews() {
		tradeListAdatper.updateData(getTradeMapList());
	}

	private List<Map<String, ?>> getTradeMapList() {
		List<Map<String, ?>> result = new ArrayList<Map<String, ?>>();
		for (TradeEntity trade : trades) {
			Map data = new HashMap();
			if (checkedTradeList.contains(trade)) {
				data.put(DataConst.NAME_CHECKED, true);
			} else {
				data.put(DataConst.NAME_CHECKED, false);
			}
			data.put(TradeConst.DATA_TRADE_KEY, trade);
			result.add(data);
		}
		return result;
	}

	private void saveTrades(final MenuItem item) {
		if (checkedTradeList.isEmpty()) {
			ViewUtils.showToast("请选择主营业务.");
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return ShopTradeProcessor.getInstance(ChangeTradesActivity.this)
						.saveShopTrades(shop, checkedTradeList);
			}
			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				if(result.getStatusCode() == 200){
					shop.setTrades(checkedTradeList);
					Intent intent = new Intent();
					intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
					setResult(RESULT_OK, intent);
					finish();
				}else{
					ViewUtils.showToast("保存失败.");
				}
			}
			
			@Override
			protected void onCancelled() {
				item.setEnabled(true);
				showProgress(false);
				
				super.onCancelled();
			}
		};
		
		item.setEnabled(false);
		showProgress(true);
		task.execute((Void)null);
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.shop_trade_view), show);
	}

	@Override
	public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
		int id = buttonView.getId();
		TradeEntity trade = trades.get(id);
		if (isChecked) {
			if (!checkedTradeList.contains(trade)) {
				checkedTradeList.add(trade);
			}
		} else {
			checkedTradeList.remove(trade);
		}
	}
}
