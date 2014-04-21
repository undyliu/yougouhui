package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class PostShopEmpsMethod extends JSONObjResourceMethod {

	private static final URI POST_SHOP_EMPS_URI = URI.create(Const.SERVER_APP_URL
			+ "/addShopEmps");

	private String shopId;

	private List<UserEntity> empList;

	public PostShopEmpsMethod(Context context, String shopId,
			List<UserEntity> empList) {
		super(context);
		this.shopId = shopId;
		this.empList = empList;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shopId);

		StringBuffer emps = new StringBuffer();
		for (UserEntity user : empList) {
			emps.append("|" + user.getUuid());
		}
		if (emps.length() > 0) {
			params.put(ShopEmpConst.DATA_EMP_LSIT_KEY, emps.substring(1));
		} else {
			params.put(ShopEmpConst.DATA_EMP_LSIT_KEY, "");
		}

		return new BaseRequest(Method.POST, POST_SHOP_EMPS_URI, null, params);
	}

}
