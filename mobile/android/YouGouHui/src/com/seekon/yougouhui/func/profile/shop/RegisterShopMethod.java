package com.seekon.yougouhui.func.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_OWNER;

import java.io.File;
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
import com.seekon.yougouhui.util.JSONUtils;

public class RegisterShopMethod extends MultipartRestMethod<JSONObjResource> {

	private static final URI REGISER_SHOP_URI = URI.create(Const.SERVER_APP_URL
			+ "/registerShop");

	private ShopEntity shop;

	public RegisterShopMethod(Context context, ShopEntity shop) {
		super(context);
		this.shop = shop;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_NAME, shop.getName());
		params.put(COL_NAME_DESC, shop.getDesc());
		params.put(COL_NAME_ADDRESS, shop.getAddress());
		params.put(COL_NAME_OWNER, shop.getOwner());
		params.put(COL_NAME_PWD, shop.getEmployees().get(0).getPwd());
		
		StringBuffer trades = new StringBuffer();
		List<TradeEntity> tradeList = shop.getTrades();
		for (TradeEntity trade : tradeList) {
			trades.append("|" + trade.getUuid());
		}
		if (trades.length() > 0) {
			params.put(ShopConst.NAME_REQUEST_PARAMETER_TRADES, trades.substring(1));
		} else {
			params.put(ShopConst.NAME_REQUEST_PARAMETER_TRADES, trades.toString());
		}

		List<FileEntity> fileEntities = new ArrayList<FileEntity>();

		String shopImage = shop.getShopImage();
		String aliasName = new File(shopImage).getPath().hashCode() + "_"
				+ System.currentTimeMillis() + ".png";
		fileEntities.add(new FileEntity(shopImage, aliasName));
		params.put(COL_NAME_SHOP_IMAGE, aliasName);
		shop.setShopImage(aliasName);
		
		String busiLicense = shop.getBusiLicense();
		aliasName = new File(busiLicense).getPath().hashCode() + "_"
				+ System.currentTimeMillis() + ".png";
		fileEntities.add(new FileEntity(busiLicense, aliasName));
		params.put(COL_NAME_BUSI_LICENSE, aliasName);
		shop.setBusiLicense(aliasName);
		
		return new MultipartRequest(REGISER_SHOP_URI, null, params, fileEntities);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource jsonObj = new JSONObjResource(responseBody);
		JSONUtils.putJSONValue(jsonObj, COL_NAME_SHOP_IMAGE, shop.getShopImage());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_BUSI_LICENSE,
				shop.getBusiLicense());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_ADDRESS, shop.getAddress());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_DESC, shop.getName());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_DESC, shop.getDesc());
		JSONUtils.putJSONValue(jsonObj, COL_NAME_OWNER, shop.getOwner());
		return jsonObj;
	}

}
