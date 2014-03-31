package com.seekon.yougouhui.func.discover.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER_NAME;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;

import android.app.Activity;
import android.content.ContentValues;
import android.os.AsyncTask;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 评论录入的弹出框
 * 
 * @author undyliu
 * 
 */
public class CommentPopupWindow extends PopupWindow {
	private final static String TAG = CommentPopupWindow.class.getSimpleName();

	public void init(final Activity activity, final Map share,
			final SimpleAdapter commentAdapter) {
		View view = activity.getLayoutInflater().inflate(
				R.layout.discover_friends_input_comment, null);
		this.setContentView(view);

		final EditText commentText = (EditText) view
				.findViewById(R.id.share_comment);
		Button sendComment = (Button) view.findViewById(R.id.action_comment_send);
		sendComment.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				commentText.setError(null);
				String content = commentText.getText().toString();
				if (TextUtils.isEmpty(content)) {
					commentText.setHint(R.string.error_field_required);
					commentText.requestFocus();
					return;
				}

				final Map<String, String> comment = new HashMap<String, String>();
				comment.put(ShareConst.COL_NAME_SHARE_ID,
						(String) share.get(COL_NAME_UUID));
				comment.put(COL_NAME_CONTENT, commentText.getText().toString());
				comment.put(COL_NAME_PUBLISHER, RunEnv.getInstance().getUser()
						.getAsString(COL_NAME_UUID));

				AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Map<String, String>, Void, RestMethodResult<JSONObjResource>>() {

					@Override
					protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
						showProgress(activity, false);
						int statusCode = result.getStatusCode();
						if (statusCode == 200) {
							CommentPopupWindow.this.dismiss();
							try {
								comment.put(COL_NAME_UUID,
										result.getResource().getString(COL_NAME_UUID));
								comment.put(COL_NAME_PUBLISH_TIME, result.getResource()
										.getString(COL_NAME_PUBLISH_TIME));
							} catch (JSONException e) {
								Logger.warn(TAG, e.getMessage());
								return;
							}

							// TODO:使用监听的方式更新e_comment的数据
							ContentValues values = ContentValuesUtils.fromMap(comment, null);
							activity.getContentResolver().insert(CommentConst.CONTENT_URI,
									values);

							comment.put(COL_NAME_PUBLISHER_NAME, RunEnv.getInstance()
									.getUser().getAsString(COL_NAME_NAME));
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
						showProgress(activity, false);
						super.onCancelled();
					}

					@Override
					protected RestMethodResult<JSONObjResource> doInBackground(
							Map<String, String>... params) {
						ShareProcessor processor = new ShareProcessor(activity);
						return processor.postComment(params[0]);
					}
				};

				showProgress(activity, true);
				task.execute(comment);
			}
		});
	}

	private void showProgress(Activity activity, boolean show) {
		ViewUtils.showProgress(activity,
				activity.findViewById(R.id.freind_share_list), show);
	}
}
