package com.seekon.yougouhui.activity.profile.shop;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.profile.shop.LoginShopMethod;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopTradeConst;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 登录商铺
 * 
 * @author undyliu
 * 
 */
public class LoginShopActivity extends Activity {

	private static final int REGISTER_REQUEST_CODE = 1;

	private Button bLogin = null;

	private TextView pwdView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_login);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case REGISTER_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				// do nothing
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void initViews() {
		pwdView = (TextView) findViewById(R.id.password);
		Button bRegister = (Button) findViewById(R.id.b_register);
		bRegister.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(LoginShopActivity.this,
						RegisterShopActivity.class);
				startActivityForResult(intent, REGISTER_REQUEST_CODE);
			}
		});

		bLogin = (Button) findViewById(R.id.sign_in_button);
		bLogin.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				loginShop();
			}
		});
		
	}

	private void loginShop() {
		pwdView.setError(null);
		final String password = pwdView.getText().toString();
		if (TextUtils.isEmpty(password)) {
			pwdView.setError(getString(R.string.error_field_required));
			pwdView.findFocus();
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return new LoginShopMethod(LoginShopActivity.this, RunEnv.getInstance()
						.getUser().getUuid(), password).execute();
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				String errorMessage = "登录失败.";
				int status = result.getStatusCode();
				if (status == 200) {
					JSONObjResource jsonObj = result.getResource();
					try {
						boolean authed = jsonObj.getBoolean(LoginConst.LOGIN_RESULT_AUTHED);
						if (authed) {
							ArrayList<String> shopIdList = new ArrayList<String>();
							JSONArray shopList = jsonObj
									.getJSONArray(ShopConst.NAME_SHOP_LIST);
							for (int i = 0; i < shopList.length(); i++) {
								JSONObject shop = shopList.getJSONObject(i);
								shopIdList.add(shop.getString(ShopTradeConst.COL_NAME_SHOP_ID));
							}
							showShopMain(shopIdList);
							return;
						} else {
							String errorType = jsonObj
									.getString(LoginConst.LOGIN_RESULT_ERROR_TYPE);
							if (LoginConst.AUTH_ERROR_PASS.equals(errorType)) {
								ViewUtils
										.showToast(getString(R.string.error_incorrect_password));
							} else if (LoginConst.AUTH_ERROR_USER.equals(errorType)) {
								ViewUtils.showToast("此账号还未注册商铺.");
							} else {
								ViewUtils.showToast(errorMessage);
							}
						}
					} catch (JSONException e) {
						ViewUtils.showToast(errorMessage);
					}

				} else {
					ViewUtils.showToast(errorMessage);
				}
				bLogin.setEnabled(true);
				super.onPostExecute(result);
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				bLogin.setEnabled(true);
				super.onCancelled();
			}
		};

		showProgress(true);
		bLogin.setEnabled(false);
		task.execute((Void) null);
	}

	private void showProgress(final boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.shop_login_form), show);
	}

	private void showShopMain(ArrayList<String> shopIdList) {
		Intent intent = new Intent(this, ShopMainActivity.class);
		intent.putStringArrayListExtra(ShopConst.NAME_SHOP_LIST, shopIdList);
		startActivity(intent);
		finish();
	}
}
