package com.seekon.yougouhui.func.setting.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.setting.SettingEntity;

public class SettingListAdapter extends BaseAdapter {
	private Context context;
	
	private List<SettingEntity> settingList;

	public SettingListAdapter(Context context, List<SettingEntity> settingList) {
		super();
		this.context = context;
		this.settingList = settingList;
	}

	@Override
	public int getCount() {
		return settingList.size();
	}

	@Override
	public Object getItem(int position) {
		return settingList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public void updateData(List<SettingEntity> settingList){
		this.settingList = settingList;
		this.notifyDataSetChanged();
	}
	
	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			view = LayoutInflater.from(context).inflate(R.layout.setting_item, null);
			holder = new ViewHolder();	
			holder.nameView = (TextView) view.findViewById(R.id.setting_item_text);
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}
		SettingEntity settings = settingList.get(position);
		holder.nameView.setText(settings.getName());
		
		return view;
	}

	class ViewHolder{
		ImageView imageView;
		TextView nameView;
	}
}
