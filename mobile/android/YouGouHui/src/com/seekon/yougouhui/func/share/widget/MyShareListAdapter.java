package com.seekon.yougouhui.func.share.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.widget.ListView;

import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;

public class MyShareListAdapter extends DateIndexedListAdapter {

	public MyShareListAdapter(List<DateIndexedEntity> dateIndexedList,
			Context context) {
		super(context, dateIndexedList);
	}

	@Override
	public void initSubItemListView(ListView subItemListView, List subItemDataList) {
		subItemListView.setAdapter(new MyShareItemListAdapter((Activity) context,
				subItemDataList));
	}

}
