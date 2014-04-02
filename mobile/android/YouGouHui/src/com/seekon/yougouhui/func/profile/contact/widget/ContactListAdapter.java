package com.seekon.yougouhui.func.profile.contact.widget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.SectionIndexer;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.contact.ContactEntity;

public class ContactListAdapter extends BaseAdapter implements SectionIndexer{
	private List<ContactEntity> contactList;
	private Map<String, Integer> catalogMap = new HashMap<String, Integer>();
	private Context mContext;

	public ContactListAdapter(Context mContext, List<ContactEntity> contactList) {
		this.mContext = mContext;
		this.contactList = contactList;
		initCatalogList();
	}

	/**
	 * 当ListView数据发生变化时,调用此方法来更新ListView
	 * 
	 * @param list
	 */
	public void updateListView(List<ContactEntity> contactList) {
		this.contactList = contactList;
		initCatalogList();
		notifyDataSetChanged();
	}

	private void initCatalogList() {
		int size = contactList.size();
		for (int i = 0; i < size; i++) {
			String firstLetter = contactList.get(i).getFirstLetter().toUpperCase();
			Set<String> keys = catalogMap.keySet();
			if(!keys.contains(firstLetter)){
				catalogMap.put(firstLetter, i);
			}
		}
	}
	
	public Set<String> getCatalogKeys(){
		return catalogMap.keySet();
	}
	
	@Override
	public int getCount() {
		return this.contactList.size();
	}

	@Override
	public Object getItem(int position) {
		return contactList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(final int position, View view, ViewGroup arg2) {
		ViewHolder viewHolder = null;
		final ContactEntity mContent = contactList.get(position);
		if (view == null) {
			viewHolder = new ViewHolder();
			view = LayoutInflater.from(mContext).inflate(R.layout.contact_list_item,
					null);
			viewHolder.tvTitle = (TextView) view.findViewById(R.id.contact_user_name);
			viewHolder.tvLetter = (TextView) view
					.findViewById(R.id.contact_user_catalog);
			view.setTag(viewHolder);
		} else {
			viewHolder = (ViewHolder) view.getTag();
		}

		String firstLetter = mContent.getFirstLetter().toUpperCase();
		int catalogIndex = catalogMap.get(firstLetter);
		if(position == catalogIndex){
			viewHolder.tvLetter.setVisibility(View.VISIBLE);
			viewHolder.tvLetter.setText(firstLetter);
		}else{
			viewHolder.tvLetter.setVisibility(View.GONE);
		}

		viewHolder.tvTitle.setText(this.contactList.get(position).getName());

		return view;

	}

	final static class ViewHolder {
		TextView tvLetter;
		TextView tvTitle;
	}

	@Override
	public int getPositionForSection(int section) {
		Set<String> keys = getCatalogKeys();
		for(String key : keys){
			if(key.toUpperCase().charAt(0) == section){
				return catalogMap.get(key);
			}
		}
		return 0;
	}

	@Override
	public int getSectionForPosition(int position) {
		return contactList.get(position).getFirstLetter().toUpperCase().charAt(0);
	}

	@Override
	public Object[] getSections() {
		return getCatalogKeys().toArray();
	}

}