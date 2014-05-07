package com.seekon.yougouhui.func.shop.widget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RadioButton;

import com.seekon.yougouhui.func.shop.ShopEntity;

public class ChooseShopListAdapter extends ShopListAdapter<ShopEntity> {

	private Map<Integer, Boolean> states = new HashMap<Integer, Boolean>();

	public ChooseShopListAdapter(Context context, List<ShopEntity> dataList) {
		super(context, dataList);
	}

	public ShopEntity getCheckedShop() {
		ShopEntity shop = null;
		for (Integer key : states.keySet()) {
			if (states.get(key) == true) {
				shop = dataList.get(key);
				break;
			}
		}
		return shop;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		ViewHolder holder = (ViewHolder) view.getTag();

		final RadioButton radio = holder.radioButton;
		radio.setVisibility(View.VISIBLE);

		holder.radioButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				for (Integer key : states.keySet()) {
					states.put(key, false);
				}
				states.put(position, radio.isChecked());
				ChooseShopListAdapter.this.notifyDataSetChanged();
			}
		});

		holder.radioButton.setChecked(states.get(position) != null
				&& states.get(position));

		return view;
	}

}
