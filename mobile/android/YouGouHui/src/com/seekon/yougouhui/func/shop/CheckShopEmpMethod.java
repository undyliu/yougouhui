package com.seekon.yougouhui.func.shop;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class CheckShopEmpMethod extends JSONObjResourceMethod{
	private static final String CHECK_SHOP_EMP_URI = Const.SERVER_APP_URL
			+ "/checkShopEmp/";
			
	private String shopId;
	private String empId;
	
	public CheckShopEmpMethod(Context context, String shopId, String empId) {
		super(context);
		this.shopId = shopId;
		this.empId = empId;
	}

	@Override
	protected Request buildRequest() {
		StringBuffer uri = new StringBuffer();
		uri.append(CHECK_SHOP_EMP_URI + shopId);
		uri.append("/" + empId);
		
		return new BaseRequest(Method.GET, uri.toString(), null, null);
	}
	
	
}
