package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.seekon.yougouhui.activity.sale.SaleDetailActivity;
import com.seekon.yougouhui.activity.sale.SaleEditActivity;
import com.seekon.yougouhui.activity.sale.ShopSaleListActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;

public class ShopSaleListAdapter extends DateIndexedListAdapter {

	public ShopSaleListAdapter(List<DateIndexedEntity> dateIndexedList,
			Context context) {
		super(dateIndexedList, context);
	}

	@Override
	public void initSubItemListView(ListView subItemListView,
			final List subItemDataList) {
		subItemListView.setAdapter(new ShopSaleItemListAdapter(context,
				subItemDataList));

		subItemListView
				.setOnItemClickListener(new AdapterView.OnItemClickListener() {

					@Override
					public void onItemClick(AdapterView<?> arg0, View arg1, int position,
							long arg3) {
						SaleEntity sale = (SaleEntity) subItemDataList.get(position);
						
						Class startActivity = null;
						UserEntity publisher = sale.getPublisher();
						if(publisher != null && publisher.equals(RunEnv.getInstance().getUser())){
							startActivity = SaleEditActivity.class;
						}else{
							startActivity = SaleDetailActivity.class;
						}
						
						Intent intent = new Intent(context, startActivity);
						intent.putExtra(SaleConst.COL_NAME_SHOP_ID, sale.getShop().getUuid());
						intent.putExtra(DataConst.COL_NAME_UUID, sale.getUuid());
						((Activity) context).startActivityForResult(intent,
								ShopSaleListActivity.SALE_PROMOTE_REQUEST_CODE);
					}

				});
	}

}
