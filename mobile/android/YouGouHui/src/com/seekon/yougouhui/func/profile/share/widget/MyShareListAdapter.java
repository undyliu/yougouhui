package com.seekon.yougouhui.func.profile.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.NAME_COUNT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_DATE;

import java.util.Date;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.util.DateUtils;

public class MyShareListAdapter extends SimpleAdapter {

	private List<? extends Map<String, ?>> shareList = null;

	private Activity activity;

	public MyShareListAdapter(Activity activity,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(activity, data, resource, from, to);
		this.shareList = data;
		this.activity = activity;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		Map share = (Map) getItem(position);

		Date publishDate = DateUtils.getDate_yyyyMMdd((String) share
				.get(COL_NAME_PUBLISH_DATE));
		((TextView) view.findViewById(R.id.share_publish_date)).setText(DateUtils
				.getDate(publishDate) + "日");
		((TextView) view.findViewById(R.id.share_publish_month)).setText(DateUtils
				.getMonth(publishDate) + "月");

		String shareCount = share.get(NAME_COUNT).toString();
		((TextView) view.findViewById(R.id.share_publish_count)).setText(shareCount
				+ "笔");

		List<? extends Map<String, ?>> shareItemList = (List<? extends Map<String, ?>>) share
				.get(ShareConst.DATA_SHARE_KEY);
		ListView sharesView = (ListView) view.findViewById(R.id.share_item_list);
		sharesView.setAdapter(new MyShareItemListAdapter(activity, shareItemList,
				R.layout.my_share_item_item, new String[] { COL_NAME_CONTENT },
				new int[] { R.id.share_item_content }));

		return view;
	}
}
