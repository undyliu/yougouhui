package com.seekon.yougouhui.func.share.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.List;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.CommentConst;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.CommentProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.UserClickListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 分享信息评论列表adapter
 * 
 * @author undyliu
 * 
 */
public class CommentListAdapter extends EntityListAdapter<CommentEntity> {
	
	private boolean readonly = false;
	
	public CommentListAdapter(Context context, List<CommentEntity> dataList,
			boolean readonly) {
		super(context, dataList);
		this.readonly = readonly;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		ViewHolder holder = null;
		if (convertView == null) {
			holder = new ViewHolder();
			convertView = LayoutInflater.from(context).inflate(
					R.layout.base_comment_item, null, false);
			holder.view = convertView;
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		final CommentEntity comment = (CommentEntity) getItem(position);
		UserEntity publisher = comment.getPublisher();
		final String commentId = comment.getUuid();

		TextView contentView = (TextView) convertView
				.findViewById(R.id.share_comment_content);
		contentView.setText(comment.getContent());

		// 设置朋友的点击监听
		TextView publisherView = (TextView) convertView
				.findViewById(R.id.share_comment_publisher);
		publisherView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理
		publisherView.setText(publisher.getName());
		if (context instanceof Activity) {
			publisherView.setOnClickListener(new UserClickListener(publisher,
					(Activity) context, -1));
		}
		// 设置评论的删除监听
		ImageView commentDelete = (ImageView) convertView
				.findViewById(R.id.b_comment_delete);
		if (!readonly && publisher.equals(RunEnv.getInstance().getUser())) {
			commentDelete.setVisibility(View.VISIBLE);
			commentDelete.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {

					RestUtils
							.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
									"删除评论失败.") {

								@Override
								public RestMethodResult<JSONObjResource> doInBackground() {
									return CommentProcessor.getInstance(context).deleteComment(
											commentId);
								}

								@Override
								public void onSuccess(RestMethodResult<JSONObjResource> result) {
									ContentResolver resolver = context.getContentResolver();
									String where = COL_NAME_UUID + "=?";
									String[] selectionArgs = new String[] { commentId };
									resolver.delete(CommentConst.CONTENT_URI, where,
											selectionArgs);

									removeEntity(comment);
								}
							});
				}
			});
		} else {
			commentDelete.setVisibility(View.GONE);
		}

		return convertView;
	}

	class ViewHolder {
		View view;
	}
}
