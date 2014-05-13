package com.seekon.yougouhui.func.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_BARCODE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_LOCATION;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_REGISTER_TIME;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_STATUS;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.favorit.ShopFavoritConst;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.LocationUtils;
import com.seekon.yougouhui.util.Logger;

public class ShopUtils {
	private static final String TAG = ShopUtils.class.getSimpleName();

	private ShopUtils() {
	}

	public static ShopEntity createFromJSONObject(JSONObject jsonObj) {
		ShopEntity shop = new ShopEntity();
		shop.setUuid(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_UUID));
		shop.setName(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_NAME));
		shop.setDesc(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_DESC));
		shop.setAddress(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_ADDRESS));
		shop.setBusiLicense(JSONUtils.getJSONStringValue(jsonObj,
				COL_NAME_BUSI_LICENSE));
		shop.setShopImage(JSONUtils
				.getJSONStringValue(jsonObj, COL_NAME_SHOP_IMAGE));
		shop.setOwner(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_OWNER));
		shop.setBarcode(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_BARCODE));
		shop.setStatus(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_STATUS));
		return shop;
	}

	public static JSONObject toJson(ShopEntity shop) {
		JSONObject jsonObj = new JSONObject();
		JSONUtils.putJSONValue(jsonObj, COL_NAME_UUID, shop.getUuid());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_NAME, shop.getName());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_DESC, shop.getDesc());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_ADDRESS, shop.getAddress());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_BUSI_LICENSE,
				shop.getBusiLicense());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_SHOP_IMAGE, shop.getShopImage());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_OWNER, shop.getOwner());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_REGISTER_TIME,
				shop.getRegisterTime());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_BARCODE, shop.getBarcode());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_STATUS, shop.getStatus());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_LOCATION,
				LocationUtils.toJSONObject(shop.getLocation()));
		return jsonObj;
	}

	public static void setFieldValue(ShopEntity shop, String fieldName,
			String fieldValue) {
		if (COL_NAME_ADDRESS.equals(fieldName)) {
			shop.setAddress(fieldValue);
		} else if (COL_NAME_BUSI_LICENSE.equals(fieldName)) {
			shop.setBusiLicense(fieldValue);
		} else if (COL_NAME_DESC.equals(fieldName)) {
			shop.setDesc(fieldValue);
		} else if (COL_NAME_NAME.equals(fieldName)) {
			shop.setName(fieldValue);
		} else if (COL_NAME_SHOP_IMAGE.equals(fieldName)) {
			shop.setShopImage(fieldValue);
		}
	}

	public static String getFieldValue(ShopEntity shop, String fieldName) {
		if (COL_NAME_ADDRESS.equals(fieldName)) {
			return shop.getAddress();
		} else if (COL_NAME_BUSI_LICENSE.equals(fieldName)) {
			return shop.getBusiLicense();
		} else if (COL_NAME_DESC.equals(fieldName)) {
			return shop.getDesc();
		} else if (COL_NAME_NAME.equals(fieldName)) {
			return shop.getName();
		} else if (COL_NAME_SHOP_IMAGE.equals(fieldName)) {
			return shop.getShopImage();
		}
		return null;
	}

	public static ShopEntity loadDataFromLocal(Context context, String shopId) {
		ShopEntity shop = null;
		Cursor cursor = null;
		try {
			String[] projection = new String[] { COL_NAME_NAME, COL_NAME_ADDRESS,
					COL_NAME_DESC, COL_NAME_SHOP_IMAGE, COL_NAME_BUSI_LICENSE,
					COL_NAME_OWNER, COL_NAME_BARCODE, COL_NAME_STATUS, COL_NAME_LOCATION };
			String selection = COL_NAME_UUID + "=?";
			String[] selectionArgs = new String[] { shopId };

			cursor = context.getContentResolver().query(ShopConst.CONTENT_URI,
					projection, selection, selectionArgs, null);
			if (cursor.moveToNext()) {
				int i = 0;
				shop = new ShopEntity();
				shop.setUuid(shopId);
				shop.setName(cursor.getString(i++));
				shop.setAddress(cursor.getString(i++));
				shop.setDesc(cursor.getString(i++));
				shop.setShopImage(cursor.getString(i++));
				shop.setBusiLicense(cursor.getString(i++));
				shop.setOwner(cursor.getString(i++));
				shop.setBarcode(cursor.getString(i++));
				shop.setStatus(cursor.getString(i++));
				shop.setLocation(LocationUtils.fromJSONObject(JSONUtils
						.createJSONObject(cursor.getString(i++))));
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}

		if (shop != null) {
			shop.setTrades(ShopUtils.getShopTradeList(context, shopId));
		}
		return shop;
	}

	public static void loadDataFromRemote(Context context,
			final AbstractRestTaskCallback<JSONObjResource> taskCallback) {
		AsyncRestRequestTask<JSONObjResource> task = new AsyncRestRequestTask<JSONObjResource>(
				context, taskCallback);
		task.execute((Void) null);
	}

	public static List<TradeEntity> getShopTradeList(Context mContext,
			String shopId) {
		List<TradeEntity> tradeList = new ArrayList<TradeEntity>();
		String[] projection = new String[] { COL_NAME_UUID, COL_NAME_CODE,
				COL_NAME_NAME };
		String selection = COL_NAME_UUID
				+ " in (select trade_id from e_shop_trade where shop_id = ?)";
		String[] selectionArgs = new String[] { shopId };
		Cursor cursor = null;
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

	public static boolean isShopFavorited(Context context, String shopId,
			String userId) {
		String selection = ShopFavoritConst.COL_NAME_SHOP_ID + "=? and "
				+ ShopFavoritConst.COL_NAME_USER_ID + "=?";
		String[] selectionArgs = new String[] { shopId, userId };
		Cursor cursor = null;
		try {
			cursor = context.getContentResolver().query(ShopFavoritConst.CONTENT_URI,
					new String[] { " count(1) " }, selection, selectionArgs, null);
			if (cursor.moveToNext()) {
				return cursor.getInt(0) > 0;
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return false;
	}

	public static String getShopRegisterTime(Context context, String shopId) {
		String registerTime = null;
		Cursor cursor = null;
		try {
			String selection = DataConst.COL_NAME_UUID + "=?";
			String[] selectionArgs = new String[] { shopId };
			cursor = context.getContentResolver().query(ShopConst.CONTENT_URI,
					new String[] { ShopConst.COL_NAME_REGISTER_TIME }, selection,
					selectionArgs, null);
			if (cursor.moveToNext()) {
				registerTime = cursor.getString(0);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return registerTime;
	}

	public static void updateShopContentProvider(Context context,
			JSONObject jsonObj) throws JSONException {
		ShopProcessor processor = new ShopProcessor(context);
		processor.updateContentProvider(jsonObj, processor.getColNames(),
				processor.getContentUri());
	}
}
