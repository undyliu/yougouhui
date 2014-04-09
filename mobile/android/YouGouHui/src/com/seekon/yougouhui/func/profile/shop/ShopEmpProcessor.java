package com.seekon.yougouhui.func.profile.shop;

import android.content.Context;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.service.ContentProcessor;

public class ShopEmpProcessor extends ContentProcessor{

	private static ShopEmpProcessor instance ;
	
	private static final Object lock = new Object();
	
	public static ShopEmpProcessor getInstance(Context mContext){
		synchronized (lock) {
			if(instance == null){
				instance = new ShopEmpProcessor(mContext);
			}
		}
		return instance;
	}
	
	public ShopEmpProcessor(Context mContext) {
		super(mContext, new String[]{}, null);		
	}

	public RestMethodResult<JSONArrayResource> getShopEmps(String shopId){
		return new GetShopEmpsMethod(mContext, shopId).execute();
	}
}
