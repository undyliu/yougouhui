package com.seekon.yougouhui.func.widget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SectionIndexer;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.PinyinEntity;

public class CatalogListAdapter extends BaseAdapter implements SectionIndexer {
	protected List<? extends PinyinEntity> dataList;
	private Map<String, Integer> catalogMap = new HashMap<String, Integer>();
	protected Context mContext;

	public CatalogListAdapter(Context mContext, List<? extends PinyinEntity> contactList) {
		this.mContext = mContext;
		this.dataList = contactList;
		initCatalogList();
	}

	/**
	 * 当ListView数据发生变化时,调用此方法来更新ListView
	 * 
	 * @param list
	 */
	public void updateListView(List<? extends PinyinEntity> contactList) {
		this.dataList = contactList;
		initCatalogList();
		notifyDataSetChanged();
	}

	private void initCatalogList() {
		catalogMap.clear();
		int size = dataList.size();
		for (int i = 0; i < size; i++) {
			String firstLetter = dataList.get(i).getFirstLetter().toUpperCase();
			Set<String> keys = catalogMap.keySet();
			if (!keys.contains(firstLetter)) {
				catalogMap.put(firstLetter, i);
			}
		}
	}

	public Set<String> getCatalogKeys() {
		return catalogMap.keySet();
	}

	@Override
	public int getCount() {
		return this.dataList.size();
	}

	@Override
	public Object getItem(int position) {
		return dataList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(final int position, View view, ViewGroup arg2) {
		ViewHolder viewHolder = null;
		final PinyinEntity mContent = dataList.get(position);
		if (view == null) {
			viewHolder = new ViewHolder();
			view = LayoutInflater.from(mContext).inflate(R.layout.catalog_list_item,
					null);
			viewHolder.tvTitle = (TextView) view.findViewById(R.id.contact_user_name);
			viewHolder.tvLetter = (TextView) view
					.findViewById(R.id.contact_user_catalog);
			viewHolder.imageView = (ImageView) view
					.findViewById(R.id.contact_user_photo);
			view.setTag(viewHolder);
		} else {
			viewHolder = (ViewHolder) view.getTag();
		}

		String firstLetter = mContent.getFirstLetter().toUpperCase();
		int catalogIndex = catalogMap.get(firstLetter);
		if (position == catalogIndex) {
			viewHolder.tvLetter.setVisibility(View.VISIBLE);
			viewHolder.tvLetter.setText(firstLetter);
		} else {
			viewHolder.tvLetter.setVisibility(View.GONE);
		}

		viewHolder.tvTitle.setText(this.dataList.get(position).getName());
		return view;

	}

	 public static class ViewHolder {
		public TextView tvLetter;
		public TextView tvTitle;
		public ImageView imageView;
		public CheckBox checkBox;
	}

	@Override
	public int getPositionForSection(int section) {
		Set<String> keys = getCatalogKeys();
		for (String key : keys) {
			if (key.toUpperCase().charAt(0) == section) {
				return catalogMap.get(key);
			}
		}
		return 0;
	}

	@Override
	public int getSectionForPosition(int position) {
		return dataList.get(position).getFirstLetter().toUpperCase().charAt(0);
	}

	@Override
	public Object[] getSections() {
		return getCatalogKeys().toArray();
	}

}
