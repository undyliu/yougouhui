package com.seekon.yougouhui.func.widget;

import java.util.List;

import android.content.Context;
import android.widget.BaseAdapter;

import com.seekon.yougouhui.func.Entity;

public abstract class EntityListAdapter<T extends Entity> extends BaseAdapter {

	protected Context context;

	protected List<T> dataList;

	public EntityListAdapter(Context context, List<T> dataList2) {
		super();
		this.context = context;
		this.dataList = dataList2;
	}

	@Override
	public int getCount() {
		return dataList.size();
	}

	@Override
	public Object getItem(int position) {
		return dataList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public void updateData(List<T> dataList) {
		this.dataList = dataList;
		this.notifyDataSetChanged();
	}

	public void addEntity(T entity) {
		this.dataList.add(entity);
		this.notifyDataSetChanged();
	}

	public void removeEntity(T entity) {
		this.dataList.remove(entity);
		this.notifyDataSetChanged();
	}

	public void updateEntity(T entity, int position) {
		if (this.dataList.contains(entity) && this.dataList.size() >= position) {
			T old = this.dataList.get(position);
			if (old.equals(entity)) {
				this.dataList.remove(position);
				this.dataList.add(position, entity);
				this.notifyDataSetChanged();
			}
		}
	}
}
