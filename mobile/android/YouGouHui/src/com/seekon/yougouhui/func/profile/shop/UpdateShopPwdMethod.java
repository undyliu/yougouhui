package com.seekon.yougouhui.func.profile.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class UpdateShopPwdMethod extends JSONObjResourceMethod {

	private static final URI UPDATE_SHOP_EMP_PWD_URI = URI
			.create(Const.SERVER_APP_URL + "/updateShopEmpPwd");

	private String shopId;
	private String userId;
	private String oldPwd;
	private String pwd;

	public UpdateShopPwdMethod(Context context, String shopId, String userId,
			String oldPwd, String pwd) {
		super(context);
		this.shopId = shopId;
		this.userId = userId;
		this.oldPwd = oldPwd;
		this.pwd = pwd;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shopId);
		params.put("user_id", userId);
		params.put("old_pwd", oldPwd);
		params.put("pwd", pwd);

		return new BaseRequest(Method.PUT, UPDATE_SHOP_EMP_PWD_URI, null, params);
	}

}
