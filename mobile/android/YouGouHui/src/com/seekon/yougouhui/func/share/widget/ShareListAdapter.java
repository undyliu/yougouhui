package com.seekon.yougouhui.func.share.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends EntityListAdapter<ShareEntity> {

	public ShareListAdapter(Context context, List<ShareEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {

		ViewHolder holder = null;
		if (convertView == null) {
			holder = new ViewHolder();
			convertView = LayoutInflater.from(context).inflate(
					R.layout.discover_friends_item, null, false);
			holder.view = convertView;
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		if (context instanceof Activity) {
			ShareEntity share = (ShareEntity) getItem(position);
			ShareUtils.updateFriendShareItemView(share, (Activity) context, convertView);
		}
		return convertView;
	}

	class ViewHolder {
		View view;
	}
}
