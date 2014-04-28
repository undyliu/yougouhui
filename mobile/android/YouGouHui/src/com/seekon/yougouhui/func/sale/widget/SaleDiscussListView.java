package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.sale.SaleDiscussConst;
import com.seekon.yougouhui.func.sale.SaleDiscussData;
import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.func.sale.SaleDiscussProcessor;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.PagedXListView;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class SaleDiscussListView extends PagedXListView<SaleDiscussEntity> {

	private SaleDiscussData saleDiscussData;
	private SaleEntity sale;

	public SaleDiscussListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public SaleDiscussListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public SaleDiscussListView(Context context) {
		super(context);
	}

	public void init() {
		saleDiscussData = new SaleDiscussData(context);
		super.init();
	}

	public void loadDiscussData(SaleEntity sale) {
		if (sale == null) {
			return;
		}
		this.sale = sale;
		super.loadDataList();
	}

	@Override
	protected List<SaleDiscussEntity> getDataListFromLocal(String limitSql) {
		return saleDiscussData.getDiscussList(sale.getUuid(), limitSql);
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return SaleDiscussProcessor.getInstance(context).getDiscusses(
				sale.getUuid(), updateTime);
	}

	@Override
	protected String getUpdateTime() {
		String result = SyncData.getInstance(context).getUpdateTime(
				SaleDiscussConst.TABLE_NAME, "*");
		if (result == null) {
			result = sale != null ? String.valueOf(sale.getPublishTime()) : null;
		}
		return result;
	}

	@Override
	public EntityListAdapter<SaleDiscussEntity> getEntityListAdapter() {
		return new SaleDiscussListAdapter(context, dataList);
	}
}
