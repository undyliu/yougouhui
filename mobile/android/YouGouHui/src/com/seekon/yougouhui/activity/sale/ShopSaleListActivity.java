package com.seekon.yougouhui.activity.sale;

import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_ID;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.Window;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.DateIndexedListActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.ShopSaleListAdapter;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

public class ShopSaleListActivity extends DateIndexedListActivity {

	public static final int SALE_PROMOTE_REQUEST_CODE = 1;

	private String shopId;

	private SaleData saleData;
	
	private boolean shopEmp = false;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		shopId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);
		saleData = new SaleData(this);

		super.onCreate(savedInstanceState);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_sale_list, menu);

		if (UserUtils.isAnonymousUser() || shopEmp) {
			return true;
		}

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopProcessor.getInstance(ShopSaleListActivity.this)
								.checkShopEmp(shopId, RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						JSONObjResource resource = result.getResource();
						if(resource.has(DataConst.COL_NAME_UUID)){
							shopEmp = true;
							getWindow().invalidatePanelMenu(Window.FEATURE_OPTIONS_PANEL);
						}
					}
				});

		return true;
	}
	
	@Override
	public boolean onPrepareOptionsMenu(Menu menu) {
		MenuItem item = menu.findItem(R.id.menu_shop_sale_publish);
		item.setVisible(shopEmp);
		return super.onPrepareOptionsMenu(menu);
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case SALE_PROMOTE_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				boolean salePublish = data.getBooleanExtra(
						SaleConst.DATA_REQUEST_PUBLISH_RESULT, false);
				if (salePublish) {
					loadDataList();
				}
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case R.id.menu_shop_sale_publish:
			doSalePromote();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void doSalePromote() {
		Intent intent = new Intent(this, SalePublishActivity.class);
		intent.putExtra(SaleConst.COL_NAME_SHOP_ID, shopId);
		startActivityForResult(intent, SALE_PROMOTE_REQUEST_CODE);
	}

	@Override
	public DateIndexedListAdapter getListAdapter() {
		return new ShopSaleListAdapter(dataList, this);
	}

	@Override
	protected List<DateIndexedEntity> getDataListFromLocal(String searchWord,
			String limitSql) {
		String where = COL_NAME_SHOP_ID + "=?";
		List<String> argList = new ArrayList<String>();
		argList.add(shopId);

		if (searchWord != null && searchWord.trim().length() > 0) {
			where += " and content like ? ";
			argList.add("%" + searchWord + "%");
		}

		String[] whereArgs = argList.toArray(new String[argList.size()]);
		List<DateIndexedEntity> result = saleData.getSaleCountByPublishDate(where,
				whereArgs, limitSql);
		for (DateIndexedEntity entity : result) {
			String publishDate = DateUtils.getDateString_yyyyMMdd(entity.getDate());
			entity.setSubItemList(saleData.getSaleListByPublishDate(where, whereArgs,
					publishDate));
		}
		return result;
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return SaleProcessor.getInstance(this).getSalesByShop(shopId, updateTime);
	}

	@Override
	protected String getUpdateTime() {
		String result = SyncData.getInstance(this).getUpdateTime(
				SaleConst.NAME_SHOP_SALE, shopId);
		if (result == null) {
			result = ShopUtils.getShopRegisterTime(this, shopId);
		}
		return result;
	}

}
