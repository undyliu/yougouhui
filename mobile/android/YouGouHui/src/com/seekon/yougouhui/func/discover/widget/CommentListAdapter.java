package com.seekon.yougouhui.func.discover.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;

import java.util.List;
import java.util.Map;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.os.AsyncTask;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 分享信息评论列表adapter
 * 
 * @author undyliu
 * 
 */
public class CommentListAdapter extends SimpleAdapter {

	private Context context;

	private ContentValues user = null;

	private List data = null;

	public CommentListAdapter(Context context,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
		this.user = RunEnv.getInstance().getUser();
		this.context = context;
		this.data = data;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		final Map comment = (Map) getItem(position);
		final String commentId = (String) comment.get(COL_NAME_UUID);

		// 设置朋友的点击监听
		TextView publisherView = (TextView) view
				.findViewById(R.id.share_comment_publisher);
		publisherView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理
		publisherView.setOnClickListener(new UserClickListener((String) comment
				.get(COL_NAME_PUBLISHER), context));

		// 设置评论的删除监听
		ImageView commentDelete = (ImageView) view
				.findViewById(R.id.b_comment_delete);
		String userId = (String) comment.get(COL_NAME_PUBLISHER);
		if (userId.equals(user.get(COL_NAME_UUID))) {
			commentDelete.setVisibility(View.VISIBLE);
			commentDelete.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {
					AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

						@Override
						protected RestMethodResult<JSONObjResource> doInBackground(
								Void... params) {
							ShareProcessor processor = new ShareProcessor(context);
							return processor.deleteComment(commentId);
						}

						@Override
						protected void onPostExecute(
								RestMethodResult<JSONObjResource> result) {
							int status = result.getStatusCode();
							if (status == 200) {
								ContentResolver resolver = context.getContentResolver();
								String where = COL_NAME_UUID + "=?";
								String[] selectionArgs = new String[] { commentId };
								resolver.delete(CommentConst.CONTENT_URI, where, selectionArgs);

								data.remove(comment);
								CommentListAdapter.this.notifyDataSetChanged();
							} else {
								ViewUtils.showToast("删除失败.");
							}
						}
					};

					task.execute((Void) null);
				}
			});
		} else {
			commentDelete.setVisibility(View.GONE);
		}

		return view;
	}

}
