package com.seekon.yougouhui.func.contact.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.CatalogListAdapter;

public class ContactListAdapter extends CatalogListAdapter {

	public ContactListAdapter(Context mContext, List<UserEntity> contactList) {
		super(mContext, contactList);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup arg2) {
		View view = super.getView(position, convertView, arg2);
		ViewHolder viewHolder = (ViewHolder) view.getTag();
		
		LayoutParams params = new LinearLayout.LayoutParams(80, 80);
		params.setMargins(15, 5, 10, 5);
		viewHolder.imageView.setLayoutParams(params);
		viewHolder.imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		UserEntity mContent = (UserEntity) dataList.get(position);

		String userPhoto = mContent.getPhoto();
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto, viewHolder.imageView,
					true);
		}
		return view;
	}

}