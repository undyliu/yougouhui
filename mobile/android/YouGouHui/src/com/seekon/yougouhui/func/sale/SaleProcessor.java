package com.seekon.yougouhui.func.sale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.spi.ISaleProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.Logger;

public class SaleProcessor extends ContentProcessor implements ISaleProcessor {

	private static ISaleProcessor instance = null;
	private static Object lock = new Object();

	public static ISaleProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ISaleProcessor) proxy.bind(new SaleProcessor(mContext));
			}
		}
		return instance;
	}

	private SaleProcessor(Context mContext) {
		super(mContext, SaleData.COL_NAMES, SaleConst.CONTENT_URI);
	}

	@Override
	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.updateContentProvider(jsonObj, colNames, contentUri);

		try {
			if (jsonObj.has(SaleConst.DATA_IMAGES_KEY)) {
				String saleId = jsonObj.getString(DataConst.COL_NAME_UUID);
				JSONArray images = jsonObj.getJSONArray(SaleConst.DATA_IMAGES_KEY);
				for (int i = 0; i < images.length(); i++) {
					JSONObject image = images.getJSONObject(i);
					image.put(SaleImgConst.COL_NAME_SALE_ID, saleId);
					updateContentProvider(image, SaleImgData.COL_NAMES,
							SaleImgConst.CONTENT_URI);
				}
				// if (jsonObj.has(ShopConst.DATA_SHOP_KEY)) {
				// JSONObject shopObj = jsonObj.getJSONObject(ShopConst.DATA_SHOP_KEY);
				// RestMethodResult<JSONObjResource> restResult = new
				// RestMethodResult<JSONObjResource>(
				// 200, "", new JSONObjResource(shopObj.toString()));
				// ShopProcessor.getInstance(mContext).updateContentProvider(restResult);
				// }
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
	}

	public RestMethodResult<JSONArrayResource> getSalesByChannel(String channelId) {
		return (RestMethodResult) this.execMethod(new GetSalesByChannelMethod(
				mContext, channelId));
	}

	public RestMethodResult<JSONArrayResource> getSalesByShop(String shopId) {
		return (RestMethodResult) this.execMethod(new GetSalesByShopMethod(
				mContext, shopId));
	}

	public RestMethodResult<JSONObjResource> publishSale(SaleEntity sale) {
		return (RestMethodResult) this
				.execMethod(new PostSaleMethod(mContext, sale));
	}

	public RestMethodResult<JSONObjResource> getSale(String saleId) {
		return (RestMethodResult) this.execMethod(new GetSaleMethod(mContext,
				saleId));
	}

	@Override
	public RestMethodResult<JSONObjResource> cancelSale(SaleEntity sale) {
		RestMethodResult<JSONObjResource> result = new CancelSaleMethod(mContext,
				sale).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			ContentValues values = new ContentValues();
			values.put(SaleConst.COL_NAME_STATUS, DataConst.STATUS_CANCELED);
			String where = DataConst.COL_NAME_UUID + "=?";
			String[] selectionArgs = new String[] { sale.getUuid() };
			mContext.getContentResolver().update(contentUri, values, where,
					selectionArgs);
			sale.setStatus(DataConst.STATUS_CANCELED);
		}
		return result;
	}
}
