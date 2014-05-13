package com.seekon.yougouhui.activity.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_STATUS;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.login.LoginConst;
import com.seekon.yougouhui.func.shop.GetTradesTaskCallback;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.shop.TradeConst;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
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

	private TextView phoneView = null;

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
		UserEntity user = RunEnv.getInstance().getUser();
		phoneView = (TextView) findViewById(R.id.phone);
		phoneView.setText(user.getPhone());
		// if(!UserUtils.isAnonymousUser()){
		// ViewUtils.setEditTextReadOnly(phoneView);
		// }
		if (!TextUtils.isEmpty(phoneView.getText().toString())) {
			phoneView.setEnabled(false);
		}

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
		phoneView.setError(null);
		pwdView.setError(null);

		boolean cancel = false;
		View focusView = null;
		final String password = pwdView.getText().toString();
		if (TextUtils.isEmpty(password)) {
			pwdView.setError(getString(R.string.error_field_required));
			focusView = pwdView;
			cancel = true;
		}

		final String phone = phoneView.getText().toString();
		if (TextUtils.isEmpty(phone)) {
			phoneView.setError(getString(R.string.error_field_required));
			focusView = phoneView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}

		bLogin.setEnabled(false);
		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("登录失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopProcessor.getInstance(LoginShopActivity.this)
								.loginShopbyPhone(phone, password);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						JSONObjResource jsonObj = result.getResource();
						try {
							boolean authed = jsonObj
									.getBoolean(LoginConst.LOGIN_RESULT_AUTHED);
							if (authed) {
								ArrayList<ShopEntity> shopEntityList = new ArrayList<ShopEntity>();
								JSONArray shopList = jsonObj.getJSONArray(DataConst.NAME_DATA);
								for (int i = 0; i < shopList.length(); i++) {
									JSONObject json = shopList.getJSONObject(i);
									ShopEntity shop = new ShopEntity();
									shop.setUuid(json.getString(COL_NAME_UUID));
									shop.setName(json.getString(COL_NAME_NAME));
									shop.setShopImage(json.getString(COL_NAME_SHOP_IMAGE));
									shop.setOwner(json.getString(COL_NAME_OWNER));
									shop.setStatus(json.getString(COL_NAME_STATUS));
									shopEntityList.add(shop);
								}

								UserEntity user = UserUtils.createFromJSONObject(jsonObj
										.getJSONObject(UserConst.DATA_KEY_USER));
								showShopMain(shopEntityList, user);
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
									ViewUtils.showToast(failedShowMsg);
								}
							}
						} catch (JSONException e) {
							ViewUtils.showToast(failedShowMsg + "原因:"
									+ LoginShopActivity.this.getString(R.string.runtime_error));
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
						bLogin.setEnabled(true);
						super.onCancelled();
					}
				});
	}

	private void showShopMain(final ArrayList<ShopEntity> shopIdList,
			final UserEntity shopEmp) {
		boolean loadTrade = true;
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(TradeConst.CONTENT_URI,
					new String[] { "count(1)" }, null, null, null);
			if (cursor.moveToNext()) {
				loadTrade = cursor.getInt(0) == 0;
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}

		if (loadTrade) {
			new AsyncRestRequestTask<JSONArrayResource>(this,
					new GetTradesTaskCallback(this) {

						@Override
						public void onSuccess(RestMethodResult<JSONArrayResource> result) {
							_showShopMain(shopIdList, shopEmp);
						}

						@Override
						public void onFailed(String errorMessage) {
							ViewUtils.showToast("登录失败，加载主营业务数据出错.原因:" + errorMessage);
						}

					}).execute((Void) null);
		} else {
			_showShopMain(shopIdList, shopEmp);
		}
	}

	private void _showShopMain(ArrayList<ShopEntity> shopIdList,
			UserEntity shopEmp) {
		Intent intent = new Intent(this, ShopMainActivity.class);
		intent.putExtra(ShopConst.NAME_SHOP_LIST, shopIdList);
		intent.putExtra(UserConst.DATA_KEY_USER, shopEmp);
		startActivity(intent);
		finish();
	}
}
