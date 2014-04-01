package com.seekon.yougouhui.func.discover.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER_NAME;

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
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.discover.share.ShareConst;

/**
 * 分享列表adapter
 * 
 * @author undyliu
 * 
 */
public class ShareListAdapter extends SimpleAdapter {

	private static final int PUBLISHER_IMAGE_WIDTH = 60;

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
		UserClickListener userClickListener = new UserClickListener(
				(String) share.get(COL_NAME_PUBLISHER), activity);

		// 设置分享者的头像
		ImageView userImg = (ImageView) view.findViewById(R.id.user_img);
		userImg.setScaleType(ImageView.ScaleType.CENTER_CROP);
		userImg.setLayoutParams(new LinearLayout.LayoutParams(
				PUBLISHER_IMAGE_WIDTH, PUBLISHER_IMAGE_WIDTH));
		String userPhoto = (String) share.get(ShareConst.COL_NAME_PUBLISHER_PHOTO);
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto, userImg, true);
		} else {
			userImg.setImageResource(R.drawable.default_user_photo);
		}
		userImg.setOnClickListener(userClickListener);

		// 设置朋友的点击监听
		TextView userView = (TextView) view.findViewById(R.id.user_name);
		userView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理
		userView.setOnClickListener(userClickListener);

		// 设置上传的图片
		List<String> images = (List) share.get(ShareConst.DATA_IMAGE_KEY);
		GridView picContainer = (GridView) view
				.findViewById(R.id.share_pic_container);
		// 设置GridView的列数
		DisplayMetrics displayMetrics = activity.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels
				/ (ShareImageAdapter.IMAGE_VIEW_WIDTH + 25);
		picContainer.setNumColumns(colNumber);
		picContainer.setAdapter(new ShareImageAdapter(activity, images));

		// 设置评论信息
		ListView commentView = (ListView) view.findViewById(R.id.comment_list);
		List<Map<String, ?>> comments = (List<Map<String, ?>>) share
				.get(ShareConst.DATA_COMMENT_KEY);
		final SimpleAdapter commentAdapter = new CommentListAdapter(activity,
				comments, R.layout.discover_friends_item_comment, new String[] {
						COL_NAME_CONTENT, COL_NAME_PUBLISHER_NAME }, new int[] {
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
