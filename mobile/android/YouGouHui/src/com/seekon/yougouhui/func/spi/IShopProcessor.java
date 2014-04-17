package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShopProcessor {

	public RestMethodResult<JSONObjResource> loginShop(String userId, String pwd);

	public RestMethodResult<JSONObjResource> registerShop(ShopEntity shop);

	public RestMethodResult<JSONObjResource> getShop(String shopId);

	public RestMethodResult<JSONObjResource> changeShop(ShopEntity shop,
			String fieldName);

	public RestMethodResult<JSONObjResource> changeShopEmpPwd(String shopId,
			String userId, String oldPwd, String pwd);

	public RestMethodResult<JSONObjResource> createShopBarcode(ShopEntity shop);
	
	public RestMethodResult<JSONArrayResource> searchShops(String searchWord);
}
