package com.seekon.yougouhui.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.login.UserHelper.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
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
				R.layout.discover_friends_item_comment,
				new String[] { COL_NAME_CONTENT, COL_NAME_PUBLISHER },
				new int[] { R.id.share_comment_content, R.id.share_comment_publisher });
		commentView.setAdapter(commentAdapter);

		ImageView button = (ImageView) view.findViewById(R.id.share_comment_action);
		button.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				ViewUtils.popupInputMethodWindow();
				showPopupWindow(position, commentAdapter);
			}
		});

		return view;
	}

	private void showPopupWindow(final int position, final SimpleAdapter commentAdapter) {
		View view = activity.getLayoutInflater().inflate(
				R.layout.discover_friends_input_comment, null);
		final PopupWindow popWindow = new PopupWindow(view,
				WindowManager.LayoutParams.FILL_PARENT,
				WindowManager.LayoutParams.WRAP_CONTENT, false);
		popWindow.setFocusable(true);
		popWindow.setBackgroundDrawable(new BitmapDrawable());
		popWindow
				.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
		popWindow.showAtLocation(parentView, Gravity.BOTTOM, 0, 0);

		final EditText commentText = (EditText) view
				.findViewById(R.id.share_comment);

		Button sendComment = (Button) view.findViewById(R.id.action_comment_send);
		sendComment.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				final Map share = (Map) getItem(position);

				final Map<String, String> comment = new HashMap<String, String>();
				comment.put(ShareConst.COL_NAME_SHARE_ID,
						(String) share.get(COL_NAME_UUID));
				comment.put(COL_NAME_CONTENT, commentText.getText().toString());
				comment.put(COL_NAME_PUBLISHER,
						RunEnv.getInstance().getUser().getAsString(COL_NAME_PHONE));

				AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>>() {

					@Override
					protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
						showProgress(false);
						int statusCode = result.getStatusCode();
						if (statusCode == 200) {
							popWindow.dismiss();
							List<Map<String, ?>> comments = (List<Map<String, ?>>) share
									.get(ShareConst.DATA_COMMENT_KEY);
							comments.add(comment);
							share.put(ShareConst.DATA_COMMENT_KEY, comments);
							commentAdapter.notifyDataSetChanged();
						} else {
							ViewUtils.showToast("发送失败.");
						}
					}

					@Override
					protected void onCancelled() {
						showProgress(false);
						super.onCancelled();
					}

					@Override
					protected RestMethodResult<JSONObjResource> doInBackground(
							Map<String, String>... params) {
						ShareProcessor processor = new ShareProcessor(activity);
						return processor.postComment(params[0]);
					}
				};

				showProgress(true);
				task.execute(comment);
			}
		});
	}

	private void showProgress(final boolean show) {
		ViewUtils.showProgress(activity,
				activity.findViewById(R.id.freind_share_list), show);
	}
}
