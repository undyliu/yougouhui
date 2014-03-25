package com.seekon.yougouhui.widget;

import java.util.List;
import java.util.Map;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.layout.FixGridLayout;
import com.seekon.yougouhui.util.RemoteImageHelper;

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

		FixGridLayout picContainer = (FixGridLayout) view
				.findViewById(R.id.share_pic_container);
		picContainer.removeAllViews();
		picContainer.setmCellHeight(0);
		picContainer.setmCellWidth(0);
		
		Map share = (Map) getItem(position);
		List<String> images = (List) share.get(ShareConst.DATA_IMAGE_KEY);
		if (images != null && !images.isEmpty()) {			
			picContainer.setmCellHeight(IMAGE_VIEW_HEIGHT);
			picContainer.setmCellWidth(IMAGE_VIEW_WIDTH);

			for (String image : images) {
				FrameLayout sharePicItem = (FrameLayout) activity.getLayoutInflater()
						.inflate(R.layout.discover_share_pic_item, null);
				ImageView imageView = (ImageView) sharePicItem
						.findViewById(R.id.share_pic);
				imageView.setBackgroundResource(0);// 去掉background
				RemoteImageHelper.loadImage(imageView, image);
				picContainer.addView(sharePicItem);
			}
		}

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
