package com.seekon.yougouhui.func.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.LinearLayout.LayoutParams;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class ShopChooseAdapter extends EntityListAdapter<ShopEntity> {

	public ShopChooseAdapter(Context context, List<ShopEntity> dataList) {
		super(context, dataList);
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
			holder.imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			LayoutParams params = new LinearLayout.LayoutParams(
					50, 50);
			holder.imageView.setLayoutParams(params);
			
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
