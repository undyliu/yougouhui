package com.seekon.yougouhui.func.discover.share.widget;

import java.util.List;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareEntity;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends BaseAdapter {

	private Activity activity = null;

	private List<ShareEntity> shareList = null;

	public ShareListAdapter(Activity activity, List<ShareEntity> shareList) {
		super();
		this.activity = activity;
		this.shareList = shareList;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {

		ViewHolder holder = null;
		if (convertView == null) {
			holder = new ViewHolder();
			convertView = LayoutInflater.from(activity).inflate(
					R.layout.discover_friends_item, null, false);
			holder.view = convertView;
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		ShareEntity share = (ShareEntity) getItem(position);
		ShareUtils.updateShareDetailView(share, activity, convertView);

		return convertView;
	}

	@Override
	public int getCount() {
		return shareList.size();
	}

	@Override
	public Object getItem(int position) {
		return shareList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		View view;
	}
}
