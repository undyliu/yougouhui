package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.database.Cursor;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ShopTradeProcessor extends ContentProcessor {

	private static ShopTradeProcessor instance = null;

	private static Object lock = new Object();

	public static ShopTradeProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				instance = new ShopTradeProcessor(mContext);
			}
		}
		return instance;
	}

	public ShopTradeProcessor(Context mContext) {
		super(mContext, ShopTradeData.COL_NAMES, ShopTradeConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> saveShopTrades(String shopId,
			List<TradeEntity> trades) {
		RestMethodResult<JSONObjResource> result = new UpdateShopTradesMethod(
				mContext, shopId, trades).execute();
		if (result.getStatusCode() == 200) {
			try {
				// for(TradeEntity trade : shop.getTrades()){//删除原有的主营业务
				// JSONObject jsonObj = new JSONObject();
				// JSONUtils.putJSONValue(jsonObj, DataConst.COL_NAME_UUID,
				// trade.getUuid());
				// super.deleteContentProvider(jsonObj, ShopTradeConst.CONTENT_URI);
				// }
				new ShopTradeData(mContext).deleteShopTradesByShopId(shopId);

				JSONArray tradeList = result.getResource().getJSONArray(
						ShopConst.NAME_REQUEST_PARAMETER_TRADES);// 设置tradelist主营业务
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
		return result;
	}

	public List<TradeEntity> getShopTradeList(String shopId) {
		List<TradeEntity> tradeList = new ArrayList<TradeEntity>();
		String[] projection = new String[] { COL_NAME_UUID, COL_NAME_CODE,
				COL_NAME_NAME };
		String selection = COL_NAME_UUID
				+ " in (select trade_id from e_shop_trade where shop_id = ?)";
		String[] selectionArgs = new String[] { shopId };
		Cursor cursor= null;
		try {
			cursor = mContext.getContentResolver().query(TradeConst.CONTENT_URI,
					projection, selection, selectionArgs, COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				int i = 0;
				TradeEntity trade = new TradeEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++));
				tradeList.add(trade);
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return tradeList;
	}
}
