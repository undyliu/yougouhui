package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_REGISTER_TIME;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BARCODE;

import org.json.JSONObject;

import com.seekon.yougouhui.util.JSONUtils;

public class ShopUtils {
	private ShopUtils() {
	}

	public static ShopEntity createFromJSONObject(JSONObject jsonObj) {
		ShopEntity shop = new ShopEntity();
		shop.setUuid(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_UUID));
		shop.setName(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_NAME));
		shop.setDesc(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_DESC));
		shop.setAddress(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_ADDRESS));
		shop.setBusiLicense(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_BUSI_LICENSE));
		shop.setShopImage(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_SHOP_IMAGE));
		shop.setOwner(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_OWNER));
		shop.setBarcode(JSONUtils.getJSONStringValue(jsonObj, COL_NAME_BARCODE));
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
}
