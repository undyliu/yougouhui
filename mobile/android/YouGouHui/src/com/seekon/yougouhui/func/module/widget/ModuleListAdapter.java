package com.seekon.yougouhui.func.module.widget;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.module.ModuleEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class ModuleListAdapter extends EntityListAdapter<ModuleEntity> {
	
	private static List<String> anonymousAccessModelList = new ArrayList<String>();
	
	static{
		anonymousAccessModelList.add(ModuleConst.CODE_FRIENDS);
		anonymousAccessModelList.add(ModuleConst.CODE_RADAR);
		anonymousAccessModelList.add(ModuleConst.CODE_SETTING);
		anonymousAccessModelList.add(ModuleConst.CODE_MY_SHOP);
	}
	
	public ModuleListAdapter(Context context, List<ModuleEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.module_item, null);

			holder.imageView = (ImageView) view.findViewById(R.id.module_img);
			holder.nameView = (TextView) view.findViewById(R.id.module_name);
			holder.accessView = (TextView) view.findViewById(R.id.module_access);
			
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		ModuleEntity module = (ModuleEntity) getItem(position);
		
		holder.imageView.setImageResource(module.getImageResourceId());
		holder.nameView.setText(module.getName());
		
		String code = module.getCode();
		if(anonymousAccessModelList.contains(code)){
			holder.accessView.setVisibility(View.GONE);
		}else{
			holder.accessView.setVisibility(View.VISIBLE);
			holder.accessView.setText(R.string.label_account_access);
		}

		return view;
	}

	class ViewHolder {
		ImageView imageView;
		TextView nameView;
		TextView accessView;
	}
}
