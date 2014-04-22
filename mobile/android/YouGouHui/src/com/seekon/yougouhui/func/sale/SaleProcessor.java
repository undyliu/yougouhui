package com.seekon.yougouhui.func.sale;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.SyncSupportProcessor;
import com.seekon.yougouhui.func.sale.SaleConst.RequetsType;
import com.seekon.yougouhui.func.spi.ISaleProcessor;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.Logger;

public class SaleProcessor extends SyncSupportProcessor implements
		ISaleProcessor {

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
		super(mContext, SaleData.COL_NAMES, SaleConst.CONTENT_URI,
				SaleConst.TABLE_NAME);
	}

	@Override
	protected void modifyContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.modifyContentProvider(jsonObj, colNames, contentUri);

		try {
			if (jsonObj.has(SaleConst.DATA_IMAGES_KEY)) {
				String saleId = jsonObj.getString(DataConst.COL_NAME_UUID);
				JSONArray images = jsonObj.getJSONArray(SaleConst.DATA_IMAGES_KEY);
				for (int i = 0; i < images.length(); i++) {
					JSONObject image = images.getJSONObject(i);
					image.put(SaleImgConst.COL_NAME_SALE_ID, saleId);
					modifyContentProvider(image, SaleImgData.COL_NAMES,
							SaleImgConst.CONTENT_URI);
				}
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		}
	}

	/**
	 * 重载同步时间
	 * 
	 */
	@Override
	protected void recordUpdateTime(String updateTime, JSONObjResource resource) {
		if (resource.has(DataConst.NAME_TYPE)) {
			try {
				SaleConst.RequetsType type = (RequetsType) resource
						.get(DataConst.COL_NAME_TYPE);
				if (type == SaleConst.RequetsType.CHANNEL_SALE) {
					SyncData syncData = SyncData.getInstance(mContext);
					syncData.updateData(syncTableName, "*", updateTime);
				} else if (type == SaleConst.RequetsType.SHOP_SALE) {
					String shopId = resource.getString(SaleConst.COL_NAME_SHOP_ID);
					SyncData syncData = SyncData.getInstance(mContext);
					syncData.updateData(SaleConst.NAME_SHOP_SALE, shopId, updateTime);
				}
			} catch (Exception e) {
				Logger.warn(TAG, e.getMessage(), e);
				throw new RuntimeException();
			}
		}
	}

	public RestMethodResult<JSONObjResource> getSalesByChannel(String channelId,
			String updateTime) {
		return (RestMethodResult) this.execMethod(new GetSalesByChannelMethod(
				mContext, channelId, updateTime));
	}

	public RestMethodResult<JSONObjResource> getSalesByShop(String shopId,
			String updateTime) {
		return (RestMethodResult) this.execMethod(new GetSalesByShopMethod(
				mContext, shopId, updateTime));
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
