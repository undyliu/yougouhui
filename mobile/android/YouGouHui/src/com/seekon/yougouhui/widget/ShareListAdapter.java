package com.seekon.yougouhui.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends SimpleAdapter {

	private static final int IMAGE_VIEW_WIDTH = 150;

	private static final int IMAGE_VIEW_HEIGHT = 150;

	private Activity activity = null;

	public ShareListAdapter(Activity context,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
		this.activity = context;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		Map share = (Map) getItem(position);
		List<String> images = (List) share.get(ShareConst.DATA_IMAGE_KEY);
		GridView picContainer = (GridView) view
				.findViewById(R.id.share_pic_container);

		picContainer.setAdapter(new ShareImageAdapter(activity, images));
		
		ListView commentView = (ListView) view.findViewById(R.id.comment_list);
		List<Map<String, ?>> comments = (List<Map<String, ?>>) share
				.get(ShareConst.DATA_COMMENT_KEY);
		commentView.setAdapter(new SimpleAdapter(activity, comments,
				R.layout.discover_friends_item_comment,
				new String[] { COL_NAME_CONTENT },
				new int[] { R.id.share_comment_content }));

		return view;
	}

}
