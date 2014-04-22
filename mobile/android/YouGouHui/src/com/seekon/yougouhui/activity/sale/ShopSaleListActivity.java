package com.seekon.yougouhui.activity.sale;

import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_ID;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.DateIndexedListActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.ShopSaleListAdapter;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

public class ShopSaleListActivity extends DateIndexedListActivity {

	public static final int SALE_PROMOTE_REQUEST_CODE = 1;

	private String shopId;

	private SaleData saleData;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		shopId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);
		saleData = new SaleData(this);

		super.onCreate(savedInstanceState);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_sale_list, menu);
		return true;
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
			result = getShopRegisterTime();
		}
		return result;
	}

	private String getShopRegisterTime() {
		String registerTime = null;
		Cursor cursor = null;
		try {
			String selection = DataConst.COL_NAME_UUID + "=?";
			String[] selectionArgs = new String[] { shopId };
			cursor = this.getContentResolver().query(ShopConst.CONTENT_URI,
					new String[] { ShopConst.COL_NAME_REGISTER_TIME }, selection,
					selectionArgs, null);
			if (cursor.moveToNext()) {
				registerTime = cursor.getString(0);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return registerTime;
	}
}
