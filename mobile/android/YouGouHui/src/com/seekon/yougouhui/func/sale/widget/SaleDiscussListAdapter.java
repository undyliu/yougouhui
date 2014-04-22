package com.seekon.yougouhui.func.sale.widget;

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
import com.seekon.yougouhui.func.sale.SaleDiscussConst;
import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.func.sale.SaleDiscussProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.UserClickListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class SaleDiscussListAdapter extends EntityListAdapter<SaleDiscussEntity> {

	public SaleDiscussListAdapter(Context context,
			List<SaleDiscussEntity> dataList) {
		super(context, dataList);
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

		final SaleDiscussEntity discuss = (SaleDiscussEntity) getItem(position);
		UserEntity publisher = discuss.getPublisher();
		final String discussId = discuss.getUuid();

		TextView contentView = (TextView) convertView
				.findViewById(R.id.share_comment_content);
		contentView.setText(discuss.getContent());

		// 设置朋友的点击监听
		TextView publisherView = (TextView) convertView
				.findViewById(R.id.share_comment_publisher);
		publisherView.getPaint().setFakeBoldText(true);// TODO:使用样式表来处理
		publisherView.setText(publisher.getName());
		publisherView.setOnClickListener(new UserClickListener(publisher,
				(Activity) context, -1));

		// 设置评论的删除监听
		ImageView commentDelete = (ImageView) convertView
				.findViewById(R.id.b_comment_delete);
		if (publisher.equals(RunEnv.getInstance().getUser())) {
			commentDelete.setVisibility(View.VISIBLE);
			commentDelete.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {
					RestUtils
							.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
									"删除评论失败.") {

								@Override
								public RestMethodResult<JSONObjResource> doInBackground() {
									return SaleDiscussProcessor.getInstance(context)
											.deleteDiscuss(discussId);
								}

								@Override
								public void onSuccess(RestMethodResult<JSONObjResource> result) {
									ContentResolver resolver = context.getContentResolver();
									String where = COL_NAME_UUID + "=?";
									String[] selectionArgs = new String[] { discussId };
									resolver.delete(SaleDiscussConst.CONTENT_URI, where,
											selectionArgs);

									dataList.remove(discuss);
									SaleDiscussListAdapter.this.notifyDataSetChanged();
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
