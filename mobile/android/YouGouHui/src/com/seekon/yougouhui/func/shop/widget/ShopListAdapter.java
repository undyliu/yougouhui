package com.seekon.yougouhui.func.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class ShopListAdapter<T extends ShopEntity > extends EntityListAdapter<T> {

	private static final int USER_SHOP_WIDTH = 80;

	public ShopListAdapter(Context context, List<T> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {
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
			holder.distanceView = (TextView) view.findViewById(R.id.shop_distance);
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

		holder.radioButton.setVisibility(View.GONE);

		return view;
	}

	public class ViewHolder {
		protected ImageView photoView;
		protected TextView nameView;
		public TextView distanceView;
		public RadioButton radioButton;
	}
}
