package com.seekon.yougouhui.func.sale.widget;

import android.app.Activity;
import android.text.TextUtils;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.func.sale.SaleDiscussProcessor;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class DiscussPopupWindow extends PopupWindow {

	public void init(final Activity activity, final String saleId,
			final BaseAdapter discussAdapter) {
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

				final SaleDiscussEntity discuss = new SaleDiscussEntity();
				discuss.setContent(content);

				SaleEntity sale = new SaleEntity();
				sale.setUuid(saleId);
				discuss.setSale(sale);

				discuss.setPublisher(RunEnv.getInstance().getUser());

				showProgress(activity, true);

				RestUtils
						.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
								"发送活动评论数据失败.") {

							@Override
							public RestMethodResult<JSONObjResource> doInBackground() {
								return SaleDiscussProcessor.getInstance(activity).postDiscuss(
										discuss);
							}

							@Override
							public void onSuccess(RestMethodResult<JSONObjResource> result) {
								DiscussPopupWindow.this.dismiss();
								if (discussAdapter instanceof SaleDiscussListAdapter) {
									((SaleDiscussListAdapter) discussAdapter)
											.addSaleDiscuss(discuss);
								} else {
									discussAdapter.notifyDataSetChanged();
								}
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
		ViewUtils.showProgress(activity,
				activity.findViewById(R.id.sale_detail_main), show);
	}
}
