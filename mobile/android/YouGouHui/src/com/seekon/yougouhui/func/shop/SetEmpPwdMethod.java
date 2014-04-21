package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class SetEmpPwdMethod extends JSONObjResourceMethod {

	private static final URI SET_EMP_PWD_URI = URI.create(Const.SERVER_APP_URL
			+ "/setShopEmpPwd");

	private String shopId;
	private String userId;
	private String pwd;

	public SetEmpPwdMethod(Context context, String shopId, String userId,
			String pwd) {
		super(context);
		this.shopId = shopId;
		this.userId = userId;
		this.pwd = pwd;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shopId);
		params.put("user_id", userId);
		params.put("pwd", pwd);

		return new BaseRequest(Method.PUT, SET_EMP_PWD_URI, null, params);
	}
}
