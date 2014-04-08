package com.seekon.yougouhui.func.profile.shop;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ShopProcessor extends ContentProcessor {

	private static final String TAG = ShopProcessor.class.getSimpleName();

	private static ShopProcessor instance = null;

	private static Object lock = new Object();

	public static ShopProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ShopProcessor(mContext);
			}
		}
		return instance;
	}

	private ShopProcessor(Context mContext) {
		super(mContext, ShopData.COL_NAMES, ShopConst.CONTENT_URI);
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		super.updateContentProvider(result, colNames);

		if (result.getResource() instanceof JSONObjResource) {
			JSONObjResource resource = (JSONObjResource) result.getResource();
			String shopId = JSONUtils.getJSONStringValue(resource,
					DataConst.COL_NAME_UUID);
			try {
				JSONArray tradeList = resource
						.getJSONArray(ShopConst.NAME_REQUEST_PARAMETER_TRADES);// 设置tradelist主营业务
				if (tradeList != null && tradeList.length() > 0) {
					for (int i = 0; i < tradeList.length(); i++) {
						JSONObject trade = tradeList.getJSONObject(i);
						JSONUtils.putJSONValue(trade, ShopTradeConst.COL_NAME_SHOP_ID,
								shopId);
						super.updateContentProvider(trade, ShopTradeData.COL_NAMES,
								ShopTradeConst.CONTENT_URI);
					}
				}
			} catch (JSONException e) {
				Logger.warn(TAG, e.getMessage());
			}
		}
	}

	public RestMethodResult<JSONObjResource> loginShop(String userId, String pwd) {
		return new LoginShopMethod(mContext, userId, pwd).execute();
	}

	public RestMethodResult<JSONObjResource> registerShop(ShopEntity shop) {
		return (RestMethodResult) this.execMethod(new RegisterShopMethod(mContext,
				shop));
	}

	public RestMethodResult<JSONObjResource> getShop(String shopId) {
		return (RestMethodResult) this.execMethod(new GetShopMethod(mContext,
				shopId));
	}
	
	public RestMethodResult<JSONObjResource> changeShop(ShopEntity shop, String fieldName){
		return (RestMethodResult)this.execMethod(new ChangeShopMethod(mContext, shop, fieldName));
	}
}
