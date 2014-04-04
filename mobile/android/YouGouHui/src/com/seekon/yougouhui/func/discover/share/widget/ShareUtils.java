package com.seekon.yougouhui.func.discover.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_SHARE_ID;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.database.Cursor;
import android.graphics.drawable.BitmapDrawable;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.discover.share.CommentEntity;
import com.seekon.yougouhui.func.discover.share.ShareEntity;
import com.seekon.yougouhui.func.discover.share.ShareImgConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.DateUtils;

public class ShareUtils {

	public static final int PUBLISHER_IMAGE_WIDTH = 60;

	public static List<String> getShareImagesFromLocal(Context context,
			String shareId) {
		List<String> imageUrls = new ArrayList<String>();
		Cursor cursor = context.getContentResolver().query(
				ShareImgConst.CONTENT_URI, new String[] { COL_NAME_IMG },
				COL_NAME_SHARE_ID + "=?", new String[] { shareId }, COL_NAME_ORD_INDEX);
		while (cursor.moveToNext()) {
			String image = cursor.getString(0);
			if (image == null || image.trim().length() == 0) {
				continue;
			}
			imageUrls.add(image);
		}
		cursor.close();
		return imageUrls;
	}

	public static void updateShareDetailView(final ShareEntity share,
			final Activity activity, View shareView) {
		if (share == null) {
			return;
		}

		UserEntity publisher = share.getPublisher();
		UserClickListener userClickListener = new UserClickListener(publisher,
				activity, -1);

		// 设置分享者的头像
		ImageView userImg = (ImageView) shareView.findViewById(R.id.user_img);
		userImg.setScaleType(ImageView.ScaleType.CENTER_CROP);
		userImg.setLayoutParams(new LinearLayout.LayoutParams(
				PUBLISHER_IMAGE_WIDTH, PUBLISHER_IMAGE_WIDTH));
		String userPhoto = publisher.getPhoto();
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto, userImg, true);
		} else {
			userImg.setImageResource(R.drawable.default_user_photo);
		}
		userImg.setOnClickListener(userClickListener);

		// 设置朋友的点击监听
		TextView userView = (TextView) shareView.findViewById(R.id.user_name);
		userView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理
		userView.setOnClickListener(userClickListener);
		userView.setText(publisher.getName());

		// 设置内容
		TextView contentView = (TextView) shareView
				.findViewById(R.id.share_content);
		contentView.setText(share.getContent());

		// 设置时间
		long publishTime = share.getPublishTime();
		TextView publishTimeView = (TextView) shareView
				.findViewById(R.id.share_publish_time);
		publishTimeView.setText(DateUtils.formatTime_MMdd(publishTime));

		// 设置上传的图片
		List<String> images = share.getImages();
		GridView picContainer = (GridView) shareView
				.findViewById(R.id.share_pic_container);
		// 设置GridView的列数
		DisplayMetrics displayMetrics = activity.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels
				/ (ShareImageAdapter.IMAGE_VIEW_WIDTH + 25);
		picContainer.setNumColumns(colNumber);
		picContainer.setAdapter(new ShareImageAdapter(activity, images));

		// 设置评论信息
		ListView commentView = (ListView) shareView.findViewById(R.id.comment_list);
		List<CommentEntity> comments = share.getComments();
		final BaseAdapter commentAdapter = new CommentListAdapter(activity,
				comments);
		commentView.setAdapter(commentAdapter);

		ImageView commentButton = (ImageView) shareView
				.findViewById(R.id.share_comment_action);
		commentButton.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				showPopupWindow(share, activity, commentAdapter, v);
			}
		});
	}

	private static void showPopupWindow(final ShareEntity share,
			Activity activity, final BaseAdapter commentAdapter, View v) {
		ShareActionPopupWindow popupWindow = new ShareActionPopupWindow();
		popupWindow.setHeight(WindowManager.LayoutParams.WRAP_CONTENT);
		popupWindow.setWidth(WindowManager.LayoutParams.WRAP_CONTENT);
		popupWindow.setOutsideTouchable(true);
		popupWindow.setFocusable(true);
		popupWindow.setBackgroundDrawable(new BitmapDrawable());
		popupWindow.init(activity, share, commentAdapter);
		popupWindow.showAsDropDown(v);
	}
}
