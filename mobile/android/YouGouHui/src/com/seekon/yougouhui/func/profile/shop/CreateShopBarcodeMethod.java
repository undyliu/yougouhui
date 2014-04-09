package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BARCODE;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class CreateShopBarcodeMethod extends JSONObjResourceMethod {

	private static final URI CREATE_SHOP_BARCODE_URI = URI
			.create(Const.SERVER_APP_URL + "/createShopBarcode");

	private ShopEntity shop;

	public CreateShopBarcodeMethod(Context context, ShopEntity shop) {
		super(context);
		this.shop = shop;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shop.getUuid());

		return new BaseRequest(Method.POST, CREATE_SHOP_BARCODE_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		String barcode = JSONUtils.getJSONStringValue(resource, COL_NAME_BARCODE);
		if(barcode != null && barcode.length() > 0){
			shop.setBarcode(barcode);
			resource = new JSONObjResource(ShopUtils.toJson(shop).toString());
		}
		return resource;
	}
}
