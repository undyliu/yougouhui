package com.seekon.yougouhui.func.discover.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.graphics.drawable.BitmapDrawable;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.GridView;
import android.widget.ImageView;
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

	private Activity activity = null;

	public ShareListAdapter(Activity context,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
		this.activity = context;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		Map share = (Map) getItem(position);
		List<String> images = (List) share.get(ShareConst.DATA_IMAGE_KEY);

		GridView picContainer = (GridView) view
				.findViewById(R.id.share_pic_container);
		// 设置GridView的列数
		DisplayMetrics displayMetrics = activity.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels
				/ ShareImageAdapter.IMAGE_VIEW_WIDTH;
		picContainer.setNumColumns(colNumber);
		picContainer.setAdapter(new ShareImageAdapter(activity, images));

		ListView commentView = (ListView) view.findViewById(R.id.comment_list);
		List<Map<String, ?>> comments = (List<Map<String, ?>>) share
				.get(ShareConst.DATA_COMMENT_KEY);
		final SimpleAdapter commentAdapter = new SimpleAdapter(activity, comments,
				R.layout.discover_friends_item_comment, new String[] {
						COL_NAME_CONTENT, COL_NAME_PUBLISHER }, new int[] {
						R.id.share_comment_content, R.id.share_comment_publisher });
		commentView.setAdapter(commentAdapter);

		ImageView commentButton = (ImageView) view
				.findViewById(R.id.share_comment_action);
		commentButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				showPopupWindow(position, commentAdapter, v);
			}
		});

		return view;
	}

	private void showPopupWindow(final int position,
			final SimpleAdapter commentAdapter, View v) {
		ShareActionPopupWindow popupWindow = new ShareActionPopupWindow();
		popupWindow.setHeight(WindowManager.LayoutParams.WRAP_CONTENT);
		popupWindow.setWidth(WindowManager.LayoutParams.WRAP_CONTENT);
		popupWindow.setOutsideTouchable(true);
		popupWindow.setFocusable(true);
		popupWindow.setBackgroundDrawable(new BitmapDrawable());
		popupWindow.init(activity, (Map) getItem(position), commentAdapter);
		popupWindow.showAsDropDown(v);
	}

}
