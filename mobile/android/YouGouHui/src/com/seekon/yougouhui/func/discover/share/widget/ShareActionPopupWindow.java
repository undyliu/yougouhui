package com.seekon.yougouhui.func.discover.share.widget;

import java.util.List;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.discover.FriendShareActivity;
import com.seekon.yougouhui.activity.profile.ShareDetailActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareEntity;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 分享信息的动作选择弹出框
 * 
 * @author undyliu
 * 
 */
@SuppressLint("ViewConstructor")
public class ShareActionPopupWindow extends PopupWindow {

	public ShareActionPopupWindow() {
		super();
	}

	public void init(final Activity activity, final ShareEntity share,
			final CommentListAdapter commentAdapter) {
		final View view = activity.getLayoutInflater().inflate(
				R.layout.discover_friends_action_pop, null);
		this.setContentView(view);

		// 评论操作
		Button commentButton = (Button) view.findViewById(R.id.b_share_comment);
		commentButton.setCompoundDrawablesWithIntrinsicBounds(
				R.drawable.b_share_comment, 0, 0, 0);
		commentButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				ShareActionPopupWindow.this.dismiss();
				ViewUtils.popupInputMethodWindow(activity);// 打开输入键盘

				CommentPopupWindow popupWindow = new CommentPopupWindow();
				popupWindow.setHeight(WindowManager.LayoutParams.WRAP_CONTENT);
				popupWindow.setWidth(WindowManager.LayoutParams.FILL_PARENT);
				popupWindow.init(activity, share, commentAdapter);
				popupWindow.setBackgroundDrawable(new BitmapDrawable());
				popupWindow.setOutsideTouchable(true);
				popupWindow.setFocusable(true);
				popupWindow
						.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
				View parentView = activity.findViewById(R.id.listview_main);
				if (parentView != null) {
					popupWindow.showAtLocation(parentView, Gravity.BOTTOM, 0, 0);
				} else {
					popupWindow.showAtLocation(view, Gravity.BOTTOM, 0, 0);
				}
			}
		});

		// 点赞操作
		Button praiseButton = (Button) view.findViewById(R.id.b_share_praise);
		praiseButton.setCompoundDrawablesWithIntrinsicBounds(
				R.drawable.b_share_heart, 0, 0, 0);
		praiseButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				ShareActionPopupWindow.this.dismiss();
			}
		});

		// 删除操作
		Button deleteButton = (Button) view.findViewById(R.id.b_share_delete);
		deleteButton.setCompoundDrawablesWithIntrinsicBounds(
				R.drawable.b_share_delete, 0, 0, 0);

		UserEntity user = RunEnv.getInstance().getUser();
		UserEntity publisher = share.getPublisher();
		if (publisher.equals(user)) {
			deleteButton.setVisibility(View.VISIBLE);
			deleteButton.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {
					final String shareId = share.getUuid();
					ShareActionPopupWindow.this.dismiss();
					showProgress(activity, true);

					RestUtils
							.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
									"删除分享失败.") {

								@Override
								public RestMethodResult<JSONObjResource> doInBackground() {
									return ShareProcessor.getInstance(activity).deleteShare(
											shareId);
								}

								@Override
								public void onSuccess(RestMethodResult<JSONObjResource> result) {
									if (activity instanceof FriendShareActivity) {
										ShareListAdapter adapter = ((FriendShareActivity) activity)
												.getShareListAdapter();

										List<FileEntity> images = share.getImages();
										for (FileEntity image : images) {
											FileHelper.deleteCacheFile(image);
										}

										((FriendShareActivity) activity).getShares().remove(share);
										adapter.notifyDataSetChanged();
									} else if (activity instanceof ShareDetailActivity) {
										Intent intent = new Intent();
										intent.putExtra("position", activity.getIntent()
												.getIntExtra("position", -1));
										intent.putExtra(ShareConst.DATA_SHARE_KEY, share);
										activity.setResult(Activity.RESULT_OK, intent);
										activity.finish();
									}
									showProgress(activity, false);
								}

								@Override
								public void onFailed(String errorMessage) {
									showProgress(activity, false);
									super.onFailed(errorMessage);
								}

								@Override
								public void onCancelled() {
									showProgress(activity, false);
									super.onCancelled();
								}
							});
				}

			});

		} else {
			deleteButton.setVisibility(View.GONE);
		}
	}

	private void showProgress(Activity activity, boolean show) {
		ViewUtils.showProgress(activity, null, show);
	}
}
