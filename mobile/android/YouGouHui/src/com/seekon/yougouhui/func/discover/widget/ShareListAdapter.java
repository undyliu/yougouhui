package com.seekon.yougouhui.func.discover.widget;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SimpleAdapter;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends SimpleAdapter {

	private Activity activity = null;

	public ShareListAdapter(Activity context,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
		this.activity = context;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		final Map share = (Map) getItem(position);
		ShareUtils.updateShareDetailView(share, activity, view);
		
		return view;
	}

}
