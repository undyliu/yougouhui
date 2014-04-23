package com.seekon.yougouhui.func.shop.widget;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.text.InputFilter;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.PopupWindow;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.shop.ShareReplyActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShopReplyEntity;
import com.seekon.yougouhui.func.share.ShopReplyProcessor;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.widget.InputFilterMinMax;

public class ShareReplyPopWindow extends PopupWindow {

	private Context context;

	public void init(final Context context, final ShareEntity share) {
		this.context = context;
		View view = LayoutInflater.from(context).inflate(
				R.layout.shop_share_reply_input, null);
		this.setContentView(view);

		final EditText gradeView = (EditText) view.findViewById(R.id.reply_grade);
		gradeView.setFilters(new InputFilter[]{ new InputFilterMinMax(0, 20)});
		
		final EditText contentView = (EditText) view
				.findViewById(R.id.reply_content);
		Button sendButton = (Button) view.findViewById(R.id.action_reply_send);
		sendButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				final String content = contentView.getText().toString();
				if (TextUtils.isEmpty(content)) {
					contentView.setHint(R.string.error_field_required);
					contentView.requestFocus();
					return;
				}

				String grade = gradeView.getText().toString();
				if (TextUtils.isEmpty(grade)) {
					grade = "0";
				}

				final int gradeVal = Integer.valueOf(grade);

				AlertDialog.Builder logoutConfirm = new AlertDialog.Builder(context);
				logoutConfirm.setTitle("积分确认");
				logoutConfirm.setMessage("是否赠送:" + gradeVal + "积分");
				logoutConfirm
						.setPositiveButton("是", new DialogInterface.OnClickListener() {
							@Override
							public void onClick(DialogInterface dialog, int which) {
								sendShareReply(content, gradeVal, share);
							}
						}).setNegativeButton("否", new DialogInterface.OnClickListener() {

							@Override
							public void onClick(DialogInterface dialog, int which) {
								dialog.cancel();
							}
						}).show();
			}
		});
	}

	private void sendShareReply(String content, int grade, final ShareEntity share) {
		final ShopReplyEntity reply = new ShopReplyEntity();
		reply.setContent(content);
		reply.setGrade(grade);
		reply.setReplier(RunEnv.getInstance().getUser().getUuid());
		reply.setShareId(share.getUuid());
		reply.setShopId(share.getShopId());
		
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"提交反馈信息失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopReplyProcessor.getInstance(context)
								.saveShareReply(reply);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						share.setShopReply(reply);
						if(context instanceof ShareReplyActivity){
							((ShareReplyActivity)context).updateView(share);
						}
						ShareReplyPopWindow.this.dismiss();
					}

				});

	}
}
