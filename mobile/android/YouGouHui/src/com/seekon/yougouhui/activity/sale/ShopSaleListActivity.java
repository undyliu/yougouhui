package com.seekon.yougouhui.activity.sale;

import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_ID;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.DateIndexedListActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.ShopSaleListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.DateUtils;

public class ShopSaleListActivity extends DateIndexedListActivity {

	public static final int SALE_PROMOTE_REQUEST_CODE = 1;

	private String shopId;

	private SaleData saleData;

	private int currentOffset = 0;

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
					doFilterData(searchWord);
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

	/**
	 * 搜索过滤数据仅在本地的数据库中进行
	 */
	@Override
	public void doFilterData(String word) {
		currentOffset = 0;
		searchWord = word;
		dataList.clear();
		dataList.addAll(getDataFromLocal());
		updateListView();
	}

	@Override
	public DateIndexedListAdapter getListAdapter() {
		return new ShopSaleListAdapter(dataList, this);
	}

	@Override
	public List<DateIndexedEntity> getDateIndexedEntityList() {
		List<DateIndexedEntity> result = this.getDataFromLocal();
		if (result.isEmpty()) {
			loadDataFormRemote();
		}
		return result == null ? new ArrayList<DateIndexedEntity>() : result;
	}

	private List<DateIndexedEntity> getDataFromLocal() {
		String where = COL_NAME_SHOP_ID + "=?";
		List<String> argList = new ArrayList<String>();
		argList.add(shopId);

		if (searchWord != null && searchWord.trim().length() > 0) {
			where += " and content like ? ";
			argList.add("%" + searchWord + "%");
		}

		String[] whereArgs = argList.toArray(new String[argList.size()]);
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		List<DateIndexedEntity> result = saleData.getSaleCountByPublishDate(where,
				whereArgs, limitSql);
		for (DateIndexedEntity entity : result) {
			String publishDate = DateUtils.getDateString_yyyyMMdd(entity.getDate());
			entity.setSubItemList(saleData.getSaleListByPublishDate(where, whereArgs,
					publishDate));
		}
		currentOffset += result.size();
		return result;
	}

	private void loadDataFormRemote() {
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>(
						"获取活动数据失败.") {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return SaleProcessor.getInstance(ShopSaleListActivity.this)
								.getSalesByShop(shopId);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						doFilterData("");
					}
				});
	}
}
