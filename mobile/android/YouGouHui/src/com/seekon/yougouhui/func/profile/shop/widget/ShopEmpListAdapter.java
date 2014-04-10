package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.CompoundButton.OnCheckedChangeListener;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.user.UserEntity;

public class ShopEmpListAdapter extends BaseAdapter {

	private static final int USER_ICON_WIDTH = 80;

	private List<UserEntity> empList = null;

	private Context context;

	private OnCheckedChangeListener onCheckedChangeListener = null;

	private String ownerId = null;
	
	public ShopEmpListAdapter(List<UserEntity> empList, Context context,
			OnCheckedChangeListener onCheckedChangeListener, String ownerId) {
		super();
		this.empList = empList;
		this.context = context;
		this.onCheckedChangeListener = onCheckedChangeListener;
		this.ownerId = ownerId;
	}

	@Override
	public int getCount() {
		return empList.size();
	}

	@Override
	public Object getItem(int position) {
		return empList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public void updateEmpList(List<UserEntity> empList) {
		this.empList = empList;
		this.notifyDataSetChanged();
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
			holder.photoView.setLayoutParams(new LinearLayout.LayoutParams(
					USER_ICON_WIDTH, USER_ICON_WIDTH));

			holder.nameView = (TextView) view.findViewById(R.id.shop_emp_name);
			holder.pwdView = (TextView) view.findViewById(R.id.shop_emp_pwd);
			holder.checkBox = (CheckBox) view.findViewById(R.id.c_shop_emp);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		UserEntity user = (UserEntity) this.getItem(position);
		if(user.getUuid().equals(ownerId)){
			holder.checkBox.setVisibility(View.INVISIBLE);
		}else{
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
