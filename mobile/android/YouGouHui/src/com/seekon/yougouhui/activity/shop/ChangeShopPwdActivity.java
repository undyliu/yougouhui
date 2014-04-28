package com.seekon.yougouhui.activity.shop;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangePasswordActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

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

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("修改密码失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopProcessor.getInstance(ChangeShopPwdActivity.this)
								.changeShopEmpPwd(shop.getUuid(),
										RunEnv.getInstance().getUser().getUuid(), oldPwd, pwd);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						JSONObjResource resource = result.getResource();
						String errorType = JSONUtils.getJSONStringValue(resource,
								LoginConst.LOGIN_RESULT_ERROR_TYPE);
						if (errorType != null) {
							pwdOldView.setError("原密码不正确.");
							pwdOldView.requestFocus();
						} else {
							finish();
						}
					}

					@Override
					public void onFailed(String errorMessage) {
						item.setEnabled(true);
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						super.onCancelled();
					}
				});
	}

}
