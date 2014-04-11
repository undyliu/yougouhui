package com.seekon.yougouhui.activity.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_STATUS;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
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
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopProcessor;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.widget.GetTradesTask;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ContentUtils;
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
				return ShopProcessor.getInstance(LoginShopActivity.this).loginShop(
						RunEnv.getInstance().getUser().getUuid(), password);
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
							ArrayList<ShopEntity> shopEntityList = new ArrayList<ShopEntity>();
							JSONArray shopList = jsonObj
									.getJSONArray(ShopConst.NAME_SHOP_LIST);
							for (int i = 0; i < shopList.length(); i++) {
								JSONObject json = shopList.getJSONObject(i);
								ShopEntity shop = new ShopEntity();
								shop.setUuid(json.getString(COL_NAME_UUID));
								shop.setName(json.getString(COL_NAME_NAME));
								shop.setShopImage(json.getString(COL_NAME_SHOP_IMAGE));
								shop.setOwner(json.getString(COL_NAME_OWNER));
								shop.setStatus(json.getString(COL_NAME_STATUS));
								shopEntityList.add(shop);

								ContentValues values = new ContentValues();
								values.put(COL_NAME_STATUS, json.getString(COL_NAME_STATUS));

								getContentResolver().update(
										ContentUtils.withAppendedId(ShopConst.CONTENT_URI,
												json.getString(COL_NAME_UUID)), values, null, null);// 修改状态
							}
							showShopMain(shopEntityList);
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

	private void showShopMain(final ArrayList<ShopEntity> shopIdList) {
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
			new GetTradesTask(LoginShopActivity.this,
					new TaskCallback<RestMethodResult<JSONArrayResource>>() {

						@Override
						public void onPostExecute(RestMethodResult<JSONArrayResource> result) {
							if (result.getStatusCode() == 200) {
								_showShopMain(shopIdList);
							} else {
								ViewUtils.showToast("登录失败，获取主营业务数据出错.");
							}
						}

						@Override
						public void onCancelled() {

						}
					}).execute((Void) null);
		} else {
			_showShopMain(shopIdList);
		}
	}

	private void _showShopMain(ArrayList<ShopEntity> shopIdList) {
		Intent intent = new Intent(this, ShopMainActivity.class);
		intent.putExtra(ShopConst.NAME_SHOP_LIST, shopIdList);
		startActivity(intent);
		finish();
	}
}
