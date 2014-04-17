package com.seekon.yougouhui.func.discover.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_SHARE_ID;

import java.io.File;
import java.util.List;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.discover.FriendShareActivity;
import com.seekon.yougouhui.activity.profile.ShareDetailActivity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareEntity;
import com.seekon.yougouhui.func.discover.share.ShareImgConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.func.spi.IShareProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
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
			final BaseAdapter commentAdapter) {
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
					AsyncTask<String, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<String, Void, RestMethodResult<JSONObjResource>>() {

						@Override
						protected RestMethodResult<JSONObjResource> doInBackground(
								String... params) {
							IShareProcessor processor = ShareProcessor.getInstance(activity);
							return processor.deleteShare(params[0]);
						}

						@Override
						protected void onPostExecute(
								RestMethodResult<JSONObjResource> result) {
							showProgress(activity, false);
							int status = result.getStatusCode();
							if (status == 200) {
								// TODO:本地删除放到一个事物中
								String selection = COL_NAME_UUID + "=?";
								String[] selectionArgs = new String[] { shareId };

								ContentResolver resolver = activity.getContentResolver();
								resolver.delete(ShareConst.CONTENT_URI, selection,
										selectionArgs);

								selection = COL_NAME_SHARE_ID + "=?";
								resolver.delete(ShareImgConst.CONTENT_URI, selection,
										selectionArgs);
								resolver.delete(CommentConst.CONTENT_URI, selection,
										selectionArgs);
								if (activity instanceof FriendShareActivity) {
									ShareListAdapter adapter = ((FriendShareActivity) activity)
											.getShareListAdapter();

									List<String> images = share.getImages();
									for (String image : images) {
										File file = FileHelper.getFileFromCache(image);
										file.delete();
									}

									((FriendShareActivity) activity).getShares().remove(share);
									adapter.notifyDataSetChanged();
								} else if (activity instanceof ShareDetailActivity) {
									Intent intent = new Intent();
									intent.putExtra("position",
											activity.getIntent().getIntExtra("position", -1));
									intent.putExtra(ShareConst.DATA_SHARE_KEY, share);
									activity.setResult(Activity.RESULT_OK, intent);
									activity.finish();
								}
							} else {
								// TODO:
								ViewUtils.showToast("删除失败.");
							}
						}

						@Override
						protected void onCancelled() {
							showProgress(activity, false);
							super.onCancelled();
						}

					};

					ShareActionPopupWindow.this.dismiss();
					showProgress(activity, true);
					task.execute(shareId);
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
