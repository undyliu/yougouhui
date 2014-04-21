package com.seekon.yougouhui.func.favorit.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.favorit.FavoritEntity;
import com.seekon.yougouhui.func.widget.CatalogListAdapter;

public class FavoritListAdapter extends CatalogListAdapter {

	public FavoritListAdapter(Context mContext, List<FavoritEntity> contactList) {
		super(mContext, contactList);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup arg2) {
		View view = super.getView(position, convertView, arg2);
		ViewHolder viewHolder = (ViewHolder) view.getTag();

		viewHolder.imageView.setLayoutParams(new LinearLayout.LayoutParams(80, 80));
		FavoritEntity mContent = (FavoritEntity) dataList.get(position);

		String image = mContent.getImage();
		if (image != null && image.length() > 0) {
			ImageLoader.getInstance().displayImage(image, viewHolder.imageView, true);
		}
		return view;
	}
}
