package com.seekon.yougouhui.func.profile.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.func.user.UserEntity;

public class ShopEmpListAdapter extends BaseAdapter{
	
	private List<UserEntity> empList = null;
	
	private Context context;

	public ShopEmpListAdapter(List<UserEntity> empList, Context context) {
		super();
		this.empList = empList;
		this.context = context;
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

	public void updateEmpList(List<UserEntity> empList){
		this.empList = empList;
		this.notifyDataSetChanged();
	}
	
	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = new CheckBox(context);
			holder.photoView = new ImageView(context);
			holder.nameView = new TextView(context);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}
		return view;
	}
	
	class ViewHolder{
		ImageView photoView;
		TextView nameView;
	}
}
