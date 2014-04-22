package com.seekon.yougouhui.func.setting.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.setting.SettingEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class SettingListAdapter extends EntityListAdapter<SettingEntity> {

	public SettingListAdapter(Context context, List<SettingEntity> dataList) {
		super(context, dataList);
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
		SettingEntity settings = (SettingEntity) getItem(position);
		holder.nameView.setText(settings.getName());
		
		return view;
	}

	class ViewHolder{
		ImageView imageView;
		TextView nameView;
	}
}
