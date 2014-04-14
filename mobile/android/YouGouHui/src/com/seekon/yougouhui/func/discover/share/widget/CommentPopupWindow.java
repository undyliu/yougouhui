package com.seekon.yougouhui.func.discover.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.ContentValues;
import android.os.AsyncTask;
import android.text.TextUtils;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.CommentEntity;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareEntity;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 评论录入的弹出框
 * 
 * @author undyliu
 * 
 */
public class CommentPopupWindow extends PopupWindow {
	private final static String TAG = CommentPopupWindow.class.getSimpleName();

	public void init(final Activity activity, final ShareEntity share,
			final BaseAdapter commentAdapter) {
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
				final String content = commentText.getText().toString();
				if (TextUtils.isEmpty(content)) {
					commentText.setHint(R.string.error_field_required);
					commentText.requestFocus();
					return;
				}

				final Map<String, String> commentMap = new HashMap<String, String>();
				commentMap.put(ShareConst.COL_NAME_SHARE_ID, share.getUuid());
				commentMap.put(COL_NAME_CONTENT, content);
				commentMap.put(COL_NAME_PUBLISHER, RunEnv.getInstance().getUser()
						.getUuid());

				AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

					@Override
					protected RestMethodResult<JSONObjResource> doInBackground(
							Void... params) {

						ShareProcessor processor = ShareProcessor.getInstance(activity);
						return processor.postComment(commentMap);
					}

					@Override
					protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
						showProgress(activity, false);
						int statusCode = result.getStatusCode();
						if (statusCode == 200) {
							CommentPopupWindow.this.dismiss();

							JSONObjResource resource = result.getResource();
							String commentUuid = JSONUtils.getJSONStringValue(resource,
									COL_NAME_UUID);
							String publishTime = JSONUtils.getJSONStringValue(resource,
									COL_NAME_PUBLISH_TIME);
							commentMap.put(COL_NAME_UUID, commentUuid);
							commentMap.put(COL_NAME_PUBLISH_TIME, publishTime);

							// TODO:使用监听的方式更新e_comment的数据
							ContentValues values = ContentValuesUtils.fromMap(commentMap,
									null);
							activity.getContentResolver().insert(CommentConst.CONTENT_URI,
									values);

							CommentEntity commentEntity = new CommentEntity(commentUuid,
									content);
							commentEntity.setPublishTime(Long.valueOf(publishTime));
							commentEntity.setPublisher(RunEnv.getInstance().getUser());

							List<CommentEntity> comments = share.getComments();
							comments.add(commentEntity);
							share.setComments(comments);

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

				};

				showProgress(activity, true);
				task.execute((Void) null);
			}
		});
	}

	private void showProgress(Activity activity, boolean show) {
		ViewUtils.showProgress(activity, activity.findViewById(R.id.listview_main),
				show);
	}
}
