package com.seekon.yougouhui.func.sale.widget;

import android.app.Activity;
import android.os.AsyncTask;
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
import com.seekon.yougouhui.rest.RestMethodResult;
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

				AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

					@Override
					protected RestMethodResult<JSONObjResource> doInBackground(
							Void... params) {
						return SaleDiscussProcessor.getInstance(activity).postDiscuss(
								discuss);
					}

					@Override
					protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
						showProgress(activity, false);
						int statusCode = result.getStatusCode();
						if (statusCode == 200) {
							DiscussPopupWindow.this.dismiss();
							if (discussAdapter instanceof SaleDiscussListAdapter) {
								((SaleDiscussListAdapter) discussAdapter)
										.addSaleDiscuss(discuss);
							} else {
								discussAdapter.notifyDataSetChanged();
							}
						} else {
							ViewUtils.showToast("发送活动评论数据失败.");
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
		ViewUtils.showProgress(activity, activity.findViewById(R.id.sale_detail_main),
				show);
	}
}
