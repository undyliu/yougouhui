package com.seekon.yougouhui.func.profile.share.widget;

import static com.seekon.yougouhui.func.DataConst.NAME_COUNT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_DATE;

import java.util.Date;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareEntity;
import com.seekon.yougouhui.util.DateUtils;

public class MyShareListAdapter extends BaseAdapter {

	private List<? extends Map<String, ?>> shareCountList = null;

	private Activity activity;

	public MyShareListAdapter(Activity activity,
			List<? extends Map<String, ?>> shareCountList) {
		super();
		this.shareCountList = shareCountList;
		this.activity = activity;
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {

		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(activity).inflate(R.layout.my_share_item,
					null, false);
			holder.view = view;
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		Map shareCount = (Map) getItem(position);

		Date publishDate = DateUtils.getDate_yyyyMMdd((String) shareCount
				.get(COL_NAME_PUBLISH_DATE));
		TextView monthView = (TextView) view.findViewById(R.id.share_publish_date);
		monthView.setText(DateUtils.getDayOfMoth(publishDate) + "日");
		TextView dateView = (TextView) view.findViewById(R.id.share_publish_month);
		dateView.setText(DateUtils.getMonth(publishDate) + "月");
		monthView.getPaint().setFakeBoldText(true);
		dateView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理

		String shareItemCount = shareCount.get(NAME_COUNT).toString();
		((TextView) view.findViewById(R.id.share_publish_count))
				.setText(shareItemCount + "笔");

		List<ShareEntity> shareItemList = (List<ShareEntity>) shareCount
				.get(ShareConst.DATA_SHARE_KEY);
		ListView sharesView = (ListView) view.findViewById(R.id.share_item_list);
		sharesView.setAdapter(new MyShareItemListAdapter(activity, shareItemList,
				position));

		return view;
	}

	@Override
	public int getCount() {
		return shareCountList.size();
	}

	@Override
	public Object getItem(int position) {
		return shareCountList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		View view;
	}
}
