package com.seekon.yougouhui.activity.shop;

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
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CompoundButton;
import android.widget.GridView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.shop.GetTradesTaskCallback;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopTradeProcessor;
import com.seekon.yougouhui.func.shop.TradeConst;
import com.seekon.yougouhui.func.shop.TradeEntity;
import com.seekon.yougouhui.func.shop.widget.TradeListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
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
		AsyncRestRequestTask<JSONArrayResource> task = new AsyncRestRequestTask<JSONArrayResource>(
				this, new GetTradesTaskCallback(this) {

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						loadTradeListFromLocal();
						updateViews();
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

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("修改主营业务失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopTradeProcessor.getInstance(ChangeTradesActivity.this)
								.saveShopTrades(shop.getUuid(), checkedTradeList);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						shop.setTrades(checkedTradeList);
						Intent intent = new Intent();
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						setResult(RESULT_OK, intent);
						finish();
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						onCancelled();
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
					}

				});
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
