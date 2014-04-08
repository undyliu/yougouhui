package com.seekon.yougouhui.activity.profile.shop;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.seekon.yougouhui.activity.ChangePasswordActivity;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;

public class ChangeShopPwdActivity extends ChangePasswordActivity {

	private ShopEntity shop;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		Intent intent = this.getIntent();
		shop = (ShopEntity) intent.getSerializableExtra(ShopConst.DATA_SHOP_KEY);

		super.onCreate(savedInstanceState);
	}

	@Override
	protected String getOldPassword() {
		return null;
	}

	@Override
	protected void doSavePassword(MenuItem item) {

	}

}
