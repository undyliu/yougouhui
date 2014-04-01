package com.seekon.yougouhui.func.profile.widget;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.activity.profile.MyShareActivity;
import com.seekon.yougouhui.activity.profile.ShareDetailActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;

public class MyShareItemListAdapter extends SimpleAdapter {

	private Activity activity;

	public MyShareItemListAdapter(Activity activity,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(activity, data, resource, from, to);
		this.activity = activity;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		final Map share = (Map) getItem(position);

//		TextView contentView = (TextView) view
//				.findViewById(R.id.share_item_content);
		view.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(activity, ShareDetailActivity.class);
				intent.putExtra(ShareConst.COL_NAME_SHARE_ID,
						(String) share.get(DataConst.COL_NAME_UUID));
				activity.startActivityForResult(intent,
						MyShareActivity.SHARE_DETAIL_REQUEST_RESULT_CODE);
			}
		});

		return view;
	}

}
