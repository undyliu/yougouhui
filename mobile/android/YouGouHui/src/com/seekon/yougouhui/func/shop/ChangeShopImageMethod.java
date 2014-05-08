package com.seekon.yougouhui.func.shop;

import static com.seekon.yougouhui.func.DataConst.NAME_FIELD;
import static com.seekon.yougouhui.func.DataConst.NAME_VALUE;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ChangeShopImageMethod extends MultipartRestMethod<JSONObjResource>{
	
	private static final URI UPDATE_SHOP_IMAGE_URI = URI.create(Const.SERVER_APP_URL
			+ "/updateShop");
	
	private ShopEntity shop;
	private FileEntity imageFile;
	private String fieldName;
	
	public ChangeShopImageMethod(Context context, ShopEntity shop,
			FileEntity imageFile, String fieldName) {
		super(context);
		this.shop = shop;
		this.imageFile = imageFile;
		this.fieldName = fieldName;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		List<FileEntity> fileEntities = new ArrayList<FileEntity>();
		
		params.put(NAME_FIELD, fieldName);
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shop.getUuid());
		if(ShopConst.COL_NAME_SHOP_IMAGE.equals(fieldName)){
			params.put(NAME_VALUE, shop.getShopImage());
		}else if(ShopConst.COL_NAME_BUSI_LICENSE.equals(fieldName)){
			params.put(NAME_VALUE, shop.getBusiLicense());
		}else{
			throw new UnsupportedOperationException();
		}
		
		fileEntities.add(imageFile);
		
		return new MultipartRequest(UPDATE_SHOP_IMAGE_URI, null, params, fileEntities);
	}
	
	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(ShopUtils.toJson(shop).toString());
	}
}
