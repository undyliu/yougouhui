package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;

import java.io.File;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.Request;

public class ChangeShopRequestFactory {

	private ChangeShopRequestFactory() {
	}

	public static Request getRequest(ShopEntity shop, String fieldName) {
		String requestPath = null;
		Map<String, String> params = new HashMap<String, String>();
		List<FileEntity> fileEntities = new ArrayList<FileEntity>();

		if (COL_NAME_NAME.equals(fieldName)) {
			requestPath = "/updateShopName";
			params.put(COL_NAME_NAME, shop.getName());
		} else if (COL_NAME_DESC.equals(fieldName)) {
			requestPath = "/updateShopDesc";
			params.put(COL_NAME_DESC, shop.getDesc());
		} else if (COL_NAME_ADDRESS.equals(fieldName)) {
			requestPath = "/updateShopAddress";
			params.put(COL_NAME_ADDRESS, shop.getAddress());
		} else if (COL_NAME_SHOP_IMAGE.equals(fieldName)) {
			requestPath = "/updateShopImage";
			String shopImage = shop.getShopImage();
			String aliasName = new File(shopImage).getPath().hashCode() + "_"
					+ System.currentTimeMillis() + ".png";
			fileEntities.add(new FileEntity(shopImage, aliasName));
			params.put(COL_NAME_SHOP_IMAGE, aliasName);
		} else if (COL_NAME_BUSI_LICENSE.equals(fieldName)) {
			requestPath = "/updateShopBusiLicense";
			String busiLicense = shop.getBusiLicense();
			String aliasName = new File(busiLicense).getPath().hashCode() + "_"
					+ System.currentTimeMillis() + ".png";
			fileEntities.add(new FileEntity(busiLicense, aliasName));
			params.put(COL_NAME_BUSI_LICENSE, aliasName);
		}
		if (requestPath == null) {
			throw new UnsupportedOperationException();
		}
		return new MultipartRequest(URI.create(Const.SERVER_APP_URL + requestPath),
				null, params, fileEntities);
	}
}
