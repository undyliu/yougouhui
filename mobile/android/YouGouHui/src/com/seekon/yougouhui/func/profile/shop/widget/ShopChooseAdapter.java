package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;

public class ShopChooseAdapter extends BaseAdapter {

	private Context context;

	private List<ShopEntity> shopList;

	public ShopChooseAdapter(Context context, List<ShopEntity> shopList) {
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

	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			LayoutInflater layoutInflater = LayoutInflater.from(context);
			view = layoutInflater.inflate(R.layout.shop_choose_item, null);
			holder.imageView = (ImageView) view
					.findViewById(R.id.shop_choose_item_image);
			holder.textView = (TextView) view
					.findViewById(R.id.shop_choose_item_name);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		ShopEntity shop = (ShopEntity) this.getItem(position);
		holder.textView.setText(shop.getName());

		holder.imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		holder.imageView.setLayoutParams(new LinearLayout.LayoutParams(50, 50));
		ImageLoader.getInstance().displayImage(shop.getShopImage(),
				holder.imageView, true);

		return view;
	}

	class ViewHolder {
		ImageView imageView;
		TextView textView;
	}
}
