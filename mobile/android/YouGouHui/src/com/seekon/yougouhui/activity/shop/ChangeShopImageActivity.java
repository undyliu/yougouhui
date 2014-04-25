package com.seekon.yougouhui.activity.shop;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ChangeImageInfoActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.ChangeTextInfoTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class ChangeShopImageActivity extends ChangeImageInfoActivity {

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
	protected void doChangeImage(final MenuItem item) {
		if (imageFile.equals(ShopUtils.getFieldValue(shop, fieldName))) {
			ViewUtils.showToast("数据未修改不需要保存.");
			return;
		}

		item.setEnabled(false);

		RestUtils.executeAsyncRestTask(this,
				new ChangeTextInfoTaskCallback(item) {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopProcessor.getInstance(ChangeShopImageActivity.this)
								.changeShop(shop, fieldName);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						Intent intent = new Intent();
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						setResult(RESULT_OK, intent);
						finish();
					}

				});
	}

	@Override
	protected FileEntity getImageFile() {
		return new FileEntity(null, ShopUtils.getFieldValue(shop, fieldName));
	}

	@Override
	protected int getImageLabel() {
		if (ShopConst.COL_NAME_SHOP_IMAGE.equals(fieldName)) {
			return R.string.label_shop_choose_image;
		} else if (ShopConst.COL_NAME_BUSI_LICENSE.equals(fieldName)) {
			return R.string.label_shop_choose_license;
		}
		return 0;
	}

}
