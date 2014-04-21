package com.seekon.yougouhui.func.shop;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.spi.IShopProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ShopProcessor extends ContentProcessor implements IShopProcessor {

	private static final String TAG = ShopProcessor.class.getSimpleName();

	private static IShopProcessor instance = null;

	private static Object lock = new Object();

	public static IShopProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IShopProcessor) proxy.bind(new ShopProcessor(mContext));
			}
		}
		return instance;
	}

	private ShopProcessor(Context mContext) {
		super(mContext, ShopData.COL_NAMES, ShopConst.CONTENT_URI);
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result) {
		super.updateContentProvider(result);

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

	public RestMethodResult<JSONObjResource> changeShop(ShopEntity shop,
			String fieldName) {
		return (RestMethodResult) this.execMethod(new UpdateShopMethod(mContext,
				shop, fieldName));
	}

	public RestMethodResult<JSONObjResource> changeShopEmpPwd(String shopId,
			String userId, String oldPwd, String pwd) {
		return new UpdateShopPwdMethod(mContext, shopId, userId, oldPwd, pwd)
				.execute();
	}

	public RestMethodResult<JSONObjResource> createShopBarcode(ShopEntity shop) {
		return (RestMethodResult) this.execMethod(new CreateShopBarcodeMethod(
				mContext, shop));
	}

	public RestMethodResult<JSONArrayResource> searchShops(String searchWord) {
		return new SearchShopMethod(mContext, searchWord).execute();
	}
}
