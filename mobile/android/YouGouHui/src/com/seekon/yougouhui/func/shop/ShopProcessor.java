package com.seekon.yougouhui.func.shop;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.SyncSupportProcessor;
import com.seekon.yougouhui.func.spi.IShopProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ShopProcessor extends SyncSupportProcessor implements
		IShopProcessor {

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
		super(mContext, ShopData.COL_NAMES, ShopConst.CONTENT_URI, null);
	}

	@Override
	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.updateContentProvider(jsonObj, colNames, contentUri);

		if (jsonObj.has(ShopConst.NAME_REQUEST_PARAMETER_TRADES)) {// 设置tradelist主营业务
			String shopId = JSONUtils.getJSONStringValue(jsonObj,
					DataConst.COL_NAME_UUID);
			try {
				JSONArray tradeList = jsonObj
						.getJSONArray(ShopConst.NAME_REQUEST_PARAMETER_TRADES);
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

	@Override
	protected void recordUpdateTime(String updateTime, JSONObjResource resource) {
		// do nothing
	}

	public RestMethodResult<JSONObjResource> loginShop(String userId, String pwd) {
		return (RestMethodResult) this.execMethod(new LoginShopMethod(mContext,
				userId, pwd));
	}

	@Override
	public RestMethodResult<JSONObjResource> loginShopbyPhone(String phone,
			String pwd) {
		return (RestMethodResult) this.execMethod(new LoginShopByPhoneMethod(
				mContext, phone, pwd));
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
		RestMethodResult<JSONObjResource> result = new UpdateShopMethod(mContext,
				shop, fieldName).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			try {
				this.updateContentProvider(result.getResource(),
						new String[] { fieldName }, contentUri);
			} catch (JSONException e) {
				Logger.warn(TAG, e.getMessage(), e);
				throw new RuntimeException(e);
			}
		}
		return result;
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

	public RestMethodResult<JSONArrayResource> getShopeByDistance(
			LocationEntity location, int distance, int offset) {
		return new GetShopsByDistanceMethod(mContext, distance, location, offset)
				.execute();
	}

	@Override
	public RestMethodResult<JSONObjResource> checkShopEmp(String shopId,
			String empId) {
		return new CheckShopEmpMethod(mContext, shopId, empId).execute();
	}

	@Override
	public RestMethodResult<JSONObjResource> changeShopImage(ShopEntity shop,
			FileEntity image, String fieldName) {
		RestMethodResult<JSONObjResource> result = new ChangeShopImageMethod(
				mContext, shop, image, fieldName).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			try {
				this.updateContentProvider(result.getResource(),
						new String[] { fieldName }, contentUri);
			} catch (JSONException e) {
				Logger.warn(TAG, e.getMessage(), e);
				throw new RuntimeException(e);
			}
		}
		return result;
	}
}
