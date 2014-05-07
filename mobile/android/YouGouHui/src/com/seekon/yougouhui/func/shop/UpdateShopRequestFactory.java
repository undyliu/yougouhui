package com.seekon.yougouhui.func.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.NAME_FIELD;
import static com.seekon.yougouhui.func.DataConst.NAME_VALUE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_ADDRESS;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.Request;

public class UpdateShopRequestFactory {

	private UpdateShopRequestFactory() {
	}

	public static Request getRequest(ShopEntity shop, String fieldName) {
		String requestPath = "/updateShop";
		Map<String, String> params = new HashMap<String, String>();
		List<FileEntity> fileEntities = new ArrayList<FileEntity>();

		if (COL_NAME_NAME.equals(fieldName)) {
			params.put(NAME_VALUE, shop.getName());
		} else if (COL_NAME_DESC.equals(fieldName)) {
			params.put(NAME_VALUE, shop.getDesc());
		} else if (COL_NAME_ADDRESS.equals(fieldName)) {
			params.put(NAME_VALUE, shop.getAddress());
		}
		if (params.isEmpty()) {
			throw new UnsupportedOperationException();
		}
		params.put(NAME_FIELD, fieldName);
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shop.getUuid());

		return new MultipartRequest(URI.create(Const.SERVER_APP_URL + requestPath),
				null, params, fileEntities);
	}
}
