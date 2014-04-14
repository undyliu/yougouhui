package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.widget.ListView;

import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;

public class ShopSaleListAdapter extends DateIndexedListAdapter {

	public ShopSaleListAdapter(List<DateIndexedEntity> dateIndexedList,
			Context context) {
		super(dateIndexedList, context);
	}

	@Override
	public void initSubItemListView(ListView subItemListView, List subItemDataList) {
		subItemListView.setAdapter(new ShopSaleItemListAdapter(context,
				subItemDataList));
	}

}
