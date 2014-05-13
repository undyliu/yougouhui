package com.seekon.yougouhui.func.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class ShopEmpListAdapter extends EntityListAdapter<UserEntity> {

	private static final int USER_ICON_WIDTH = 80;

	private OnCheckedChangeListener onCheckedChangeListener = null;

	private String ownerId = null;

	public ShopEmpListAdapter(Context context, List<UserEntity> dataList,
			OnCheckedChangeListener onCheckedChangeListener, String ownerId) {
		super(context, dataList);
		this.onCheckedChangeListener = onCheckedChangeListener;
		this.ownerId = ownerId;
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(
					R.layout.shop_emp_setting_item, null);
			holder.photoView = (ImageView) view.findViewById(R.id.shop_emp_photo);
			holder.photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			LayoutParams params = new LinearLayout.LayoutParams(
					USER_ICON_WIDTH, USER_ICON_WIDTH);
			params.setMargins(0, 5, 5, 5);
			holder.photoView.setLayoutParams(params);

			holder.nameView = (TextView) view.findViewById(R.id.shop_emp_name);
			holder.pwdView = (TextView) view.findViewById(R.id.shop_emp_pwd);
			holder.checkBox = (CheckBox) view.findViewById(R.id.c_shop_emp);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		UserEntity user = (UserEntity) this.getItem(position);
		if (user.getUuid().equals(ownerId)) {
			holder.checkBox.setVisibility(View.INVISIBLE);
		} else {
			holder.checkBox.setVisibility(View.VISIBLE);
		}
		holder.checkBox.setId(position);

		holder.nameView.setText(user.getName());
		String photo = user.getPhoto();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance().displayImage(photo, holder.photoView, true);
		}

		String pwd = user.getPwd();
		if (pwd != null && pwd.length() > 0) {
			holder.pwdView.setText("......");
		} else {
			holder.pwdView.setText(R.string.label_shop_emp_pwd_no);
		}

		if (onCheckedChangeListener != null) {
			holder.checkBox.setOnCheckedChangeListener(onCheckedChangeListener);
		}
		holder.checkBox.setChecked(false);

		return view;
	}

	class ViewHolder {
		ImageView photoView;
		TextView nameView;
		TextView pwdView;
		CheckBox checkBox;
	}
}
