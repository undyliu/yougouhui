package com.seekon.yougouhui.activity.shop;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangeTextInfoActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.widget.ChangeTextInfoTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class ChangeShopTextActivity extends ChangeTextInfoActivity {

	private String fieldName = null;

	private ShopEntity shop = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		Intent intent = this.getIntent();
		this.getActionBar()
				.setTitle(
						intent.getIntExtra(DataConst.NAME_TITLE,
								R.string.title_shop_base_info));

		fieldName = intent.getStringExtra(DataConst.NAME_TYPE);
		shop = (ShopEntity) intent.getSerializableExtra(ShopConst.DATA_SHOP_KEY);

		super.onCreate(savedInstanceState);
	}

	@Override
	protected void doSaveTextInfo(final MenuItem item) {
		final String textValue = textView.getText().toString();
		final String oldFieldVal = ShopUtils.getFieldValue(shop, fieldName);
		if (textValue.equals(oldFieldVal)) {
			ViewUtils.showToast("数据未修改不需要保存.");
			return;
		}

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this, new ChangeTextInfoTaskCallback(item) {

			@Override
			public RestMethodResult<JSONObjResource> doInBackground() {
				ShopUtils.setFieldValue(shop, fieldName, textValue);
				return ShopProcessor.getInstance(ChangeShopTextActivity.this)
						.changeShop(shop, fieldName);
			}

			@Override
			public void onSuccess(RestMethodResult<JSONObjResource> result) {
				Intent intent = new Intent();
				intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
				setResult(RESULT_OK, intent);
				finish();
			}
			
			@Override
			public void onFailed(String errorMessage) {
				super.onFailed(errorMessage);
				ShopUtils.setFieldValue(shop, fieldName, oldFieldVal);
			}
			
			@Override
			public void onCancelled() {
				super.onCancelled();
				ShopUtils.setFieldValue(shop, fieldName, oldFieldVal);
			}
		});
	}

	@Override
	protected void initViews() {
		textView.setText(ShopUtils.getFieldValue(shop, fieldName));
	}

}
