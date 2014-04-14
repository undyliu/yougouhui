package com.seekon.yougouhui.func.sale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;
import com.seekon.yougouhui.util.Logger;

public class SaleProcessor extends ContentProcessor {

	private static SaleProcessor instance = null;
	private static Object lock = new Object();

	public static SaleProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new SaleProcessor(mContext);
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
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
	}

	public void getSalesByChannel(ProcessorCallback callback, String channelId) {
		GetSalesByChannelMethod method = new GetSalesByChannelMethod(mContext, channelId);
		this.execMethodWithCallback(method, callback);
	}

	public RestMethodResult<JSONArrayResource> getSalesByShop(String shopId){
		return (RestMethodResult)this.execMethod(new GetSalesByShopMethod(mContext, shopId));
	}
	
	public RestMethodResult<JSONObjResource> publishSale(SaleEntity sale) {
		return (RestMethodResult) this
				.execMethod(new PostSaleMethod(mContext, sale));
	}
}
