package com.seekon.yougouhui.func.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.CommentProcessor;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
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
			final CommentListAdapter commentAdapter) {
		View view = activity.getLayoutInflater().inflate(
				R.layout.base_comment_input, null);
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

				showProgress(activity, true);

				RestUtils
						.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
								"发送评论失败.") {

							@Override
							public RestMethodResult<JSONObjResource> doInBackground() {
								return CommentProcessor.getInstance(activity).postComment(
										commentMap);
							}

							@Override
							public void onSuccess(RestMethodResult<JSONObjResource> result) {
								JSONObjResource resource = result.getResource();
								CommentPopupWindow.this.dismiss();
								CommentEntity commentEntity = new CommentEntity(JSONUtils
										.getJSONStringValue(resource, COL_NAME_UUID), content);
								commentEntity.setPublishTime(Long.valueOf(JSONUtils
										.getJSONStringValue(resource, COL_NAME_PUBLISH_TIME)));
								commentEntity.setPublisher(RunEnv.getInstance().getUser());
								commentAdapter.addEntity(commentEntity);
								onCancelled();
							}

							@Override
							public void onFailed(String errorMessage) {
								onCancelled();
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
	}

	private void showProgress(Activity activity, boolean show) {
		ViewUtils.showProgress(activity, activity.findViewById(R.id.listview_main),
				show);
	}
}
