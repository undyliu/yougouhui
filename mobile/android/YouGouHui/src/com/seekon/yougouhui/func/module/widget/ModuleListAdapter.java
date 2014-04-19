package com.seekon.yougouhui.func.module.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.module.ModuleEntity;

public class ModuleListAdapter extends BaseAdapter {

	private Context context;
	private List<ModuleEntity> moduleList;

	public ModuleListAdapter(Context context, List<ModuleEntity> moduleList) {
		super();
		this.context = context;
		this.moduleList = moduleList;
	}

	@Override
	public int getCount() {
		return moduleList.size();
	}

	@Override
	public Object getItem(int position) {
		return moduleList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}
	
	public void updateData(List<ModuleEntity> moduleList){
		this.moduleList = moduleList;
		this.notifyDataSetChanged();
	}
	
	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.module_item, null);

			holder.imageView = (ImageView) view.findViewById(R.id.module_img);
			holder.nameView = (TextView) view.findViewById(R.id.module_name);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		ModuleEntity module = moduleList.get(position);
		holder.imageView.setImageResource(module.getImageResourceId());
		holder.nameView.setText(module.getName());

		return view;
	}

	class ViewHolder {
		ImageView imageView;
		TextView nameView;
	}
}
