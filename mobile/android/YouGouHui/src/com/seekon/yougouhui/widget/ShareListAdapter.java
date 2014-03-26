package com.seekon.yougouhui.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.graphics.drawable.BitmapDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends SimpleAdapter {

	private Activity activity = null;
	private View parentView = null;

	public ShareListAdapter(Activity context, View parentView,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
		this.activity = context;
		this.parentView = parentView;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);

		Map share = (Map) getItem(position);
		final String shareId = (String) share.get(COL_NAME_UUID);
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

		ImageButton button = (ImageButton) view
				.findViewById(R.id.share_comment_action);
		button.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				ViewUtils.popupInputMethodWindow();
				showPopupWindow(shareId);
			}
		});

		return view;
	}

	private void showPopupWindow(String shareId) {
		View view = activity.getLayoutInflater().inflate(
				R.layout.discover_friends_input_comment, null);
		PopupWindow popWindow = new PopupWindow(view,
				WindowManager.LayoutParams.FILL_PARENT,
				WindowManager.LayoutParams.WRAP_CONTENT, false);
		popWindow.setFocusable(true);
		popWindow.setBackgroundDrawable(new BitmapDrawable());
		popWindow
				.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
		popWindow.showAtLocation(parentView, Gravity.BOTTOM, 0, 0);

		Button sendComment = (Button) view.findViewById(R.id.action_comment_send);
		sendComment.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {

			}
		});
	}
}
