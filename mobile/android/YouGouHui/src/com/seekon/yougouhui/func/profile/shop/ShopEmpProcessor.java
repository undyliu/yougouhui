package com.seekon.yougouhui.func.profile.shop;

import java.util.List;

import android.content.Context;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class ShopEmpProcessor extends ContentProcessor {

	private static ShopEmpProcessor instance;

	private static final Object lock = new Object();

	public static ShopEmpProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ShopEmpProcessor(mContext);
			}
		}
		return instance;
	}

	public ShopEmpProcessor(Context mContext) {
		super(mContext, new String[] {}, null);
	}

	public RestMethodResult<JSONArrayResource> getShopEmps(String shopId) {
		return new GetShopEmpsMethod(mContext, shopId).execute();
	}

	public RestMethodResult<JSONObjResource> addShopEmps(String shopId,
			List<UserEntity> empList) {
		return new PostShopEmpsMethod(mContext, shopId, empList).execute();
	}

	public RestMethodResult<JSONObjResource> deleteShopEmps(String shopId,
			List<UserEntity> empList) {
		return new DeleteShopEmpsMethod(mContext, shopId, empList).execute();
	}
	
	public RestMethodResult<JSONObjResource> setShopEmpPwd(String shopId, String userId, String pwd){
		return new SetEmpPwdMethod(mContext, shopId, userId, pwd).execute();
	}
}
