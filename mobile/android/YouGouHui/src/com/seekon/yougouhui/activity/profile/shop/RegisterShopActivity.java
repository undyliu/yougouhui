package com.seekon.yougouhui.activity.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.FrameLayout;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.profile.shop.TradeProcessor;
import com.seekon.yougouhui.func.profile.shop.widget.TradeListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 注册商铺
 * 
 * @author undyliu
 * 
 */
public class RegisterShopActivity extends Activity {

	private static final int SHOP_ICON_WIDTH = 100;

	private static final int LOAD_IMAGE_REQUEST_CODE = 1;

	private static final int LOAD_LICENSE_REQUEST_CODE = 1;

	private TextView nameView;
	private ImageView shopImgView;
	private TextView addrView;
	private TextView descView;
	private ImageView licenseView;
	private BaseAdapter tradeAdapter;
	private List<TradeEntity> trades = new ArrayList<TradeEntity>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_register);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();

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
		case R.menu.common_save:
			registerShop();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		GridView tradeView = (GridView) findViewById(R.id.shop_trade_view);
		tradeAdapter = new TradeListAdapter(this, trades);
		
		loadTrades();

		nameView = (TextView) findViewById(R.id.shop_name);
		addrView = (TextView) findViewById(R.id.shop_address);
		descView = (TextView) findViewById(R.id.shop_desc);
		shopImgView = (ImageView) findViewById(R.id.shop_image);
		licenseView = (ImageView) findViewById(R.id.shop_busi_license);

		shopImgView.setLayoutParams(new FrameLayout.LayoutParams(SHOP_ICON_WIDTH,
				SHOP_ICON_WIDTH));
		shopImgView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_IMAGE_REQUEST_CODE);
			}
		});

		licenseView.setLayoutParams(new FrameLayout.LayoutParams(SHOP_ICON_WIDTH,
				SHOP_ICON_WIDTH));
		licenseView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_LICENSE_REQUEST_CODE);
			}
		});
	
	}

	private void loadTrades() {
		loadTradeFromLocal();
		if (trades.isEmpty()) {
			loadTradesFromRemote();
		} else {
			tradeAdapter.notifyDataSetChanged();
		}
	}

	private void loadTradeFromLocal() {
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
			cursor.close();
		}
	}

	private void loadTradesFromRemote() {

		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>>() {

			@Override
			protected RestMethodResult<JSONArrayResource> doInBackground(
					Void... params) {
				return TradeProcessor.getInstance(RegisterShopActivity.this)
						.getTrades();
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
				int status = result.getStatusCode();
				if (status == 200) {
					try {
						JSONArrayResource resource = result.getResource();
						for (int i = 0; i < resource.length(); i++) {
							JSONObject jsonObj = resource.getJSONObject(i);
							TradeEntity trade = new TradeEntity();
							trade.setUuid(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_UUID));
							trade.setCode(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_CODE));
							trade.setName(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_NAME));
							trades.add(trade);
						}
						
						tradeAdapter.notifyDataSetChanged();
					} catch (Exception e) {
						ViewUtils.showToast("获取主营业务数据失败.");
					}
				} else {
					ViewUtils.showToast("获取主营业务数据失败.");
				}
			}

		};

		task.execute((Void) null);
	}

	private void registerShop() {

	}
}
