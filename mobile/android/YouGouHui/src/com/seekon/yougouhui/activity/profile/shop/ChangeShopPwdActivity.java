package com.seekon.yougouhui.activity.profile.shop;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangePasswordActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.ViewUtils;

public class ChangeShopPwdActivity extends ChangePasswordActivity {

	private ShopEntity shop;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		Intent intent = this.getIntent();
		shop = (ShopEntity) intent.getSerializableExtra(ShopConst.DATA_SHOP_KEY);

		super.onCreate(savedInstanceState);

		((TextView) findViewById(R.id.label_name))
				.setText(R.string.label_shop_name);
		TextView nameView = (TextView) findViewById(R.id.name);
		nameView.setText(shop.getName());
	}

	@Override
	protected boolean validateOldPassword() {
		return true;
	}

	@Override
	protected void doSavePassword(final MenuItem item) {
		final String oldPwd = pwdOldView.getText().toString();
		final String pwd = pwdNewView.getText().toString();
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return ShopProcessor.getInstance(ChangeShopPwdActivity.this)
						.changeShopEmpPwd(shop.getUuid(),
								RunEnv.getInstance().getUser().getUuid(), oldPwd, pwd);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				int status = result.getStatusCode();
				if (status == 200) {
					JSONObjResource resource = result.getResource();
					String errorType = JSONUtils.getJSONStringValue(resource,
							LoginConst.LOGIN_RESULT_ERROR_TYPE);
					if (errorType != null) {
						ViewUtils.showToast("原密码不正确.");
					} else {
						finish();
					}
				} else {
					ViewUtils.showToast("修改密码失败.");
				}

				item.setEnabled(true);
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				item.setEnabled(true);
				super.onCancelled();
			}
		};

		showProgress(true);
		item.setEnabled(false);
		task.execute((Void) null);
	}

}
