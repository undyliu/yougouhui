package com.seekon.yougouhui.func.shop.widget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.shop.ShopEntity;

public class ChooseShopListAdapter extends BaseAdapter {

	private static final int USER_SHOP_WIDTH = 80;

	private Context context;
	private List<ShopEntity> shopList;

	private Map<Integer, Boolean> states = new HashMap<Integer, Boolean>();

	public ChooseShopListAdapter(Context context, List<ShopEntity> shopList) {
		super();
		this.context = context;
		this.shopList = shopList;
	}

	@Override
	public int getCount() {
		return shopList.size();
	}

	@Override
	public Object getItem(int position) {
		return shopList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public void updateData(List<ShopEntity> shopList) {
		this.shopList = shopList;
		this.notifyDataSetChanged();
	}

	public ShopEntity getCheckedShop() {
		ShopEntity shop = null;
		for (Integer key : states.keySet()) {
			if (states.get(key) == true) {
				shop = this.shopList.get(key);
				break;
			}
		}
		return shop;
	}

	@Override
	public View getView(final int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.choose_shop_item,
					null);

			holder.photoView = (ImageView) view.findViewById(R.id.shop_image);
			holder.photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			holder.photoView.setLayoutParams(new LinearLayout.LayoutParams(
					USER_SHOP_WIDTH, USER_SHOP_WIDTH));

			holder.nameView = (TextView) view.findViewById(R.id.shop_name);
			holder.radioButton = (RadioButton) view.findViewById(R.id.r_shop_choose);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		ShopEntity shop = (ShopEntity) getItem(position);

		holder.nameView.setText(shop.getName());
		String photo = shop.getShopImage();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance().displayImage(photo, holder.photoView, true);
		}

		final RadioButton radio = holder.radioButton;
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

	class ViewHolder {
		ImageView photoView;
		TextView nameView;
		RadioButton radioButton;
	}
}
