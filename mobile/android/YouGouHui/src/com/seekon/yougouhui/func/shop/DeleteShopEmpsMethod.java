package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.List;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class DeleteShopEmpsMethod extends JSONObjResourceMethod {

	private static final String DEL_SHOP_EMPS_URI = Const.SERVER_APP_URL
			+ "/deleteShopEmps/";

	private String shopId;

	private List<UserEntity> empList;

	public DeleteShopEmpsMethod(Context context, String shopId,
			List<UserEntity> empList) {
		super(context);
		this.shopId = shopId;
		this.empList = empList;
	}

	@Override
	protected Request buildRequest() {
		String uri = DEL_SHOP_EMPS_URI + shopId + "/";

		StringBuffer emps = new StringBuffer();
		for (UserEntity user : empList) {
			emps.append("|" + user.getUuid());
		}
		if (emps.length() > 0) {
			uri += emps.substring(1);
		}

		return new BaseRequest(Method.DELETE, URI.create(uri), null, null);
	}
}
