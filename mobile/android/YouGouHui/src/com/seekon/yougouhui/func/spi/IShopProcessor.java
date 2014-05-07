package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.shop.ShopEntity;
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

	public RestMethodResult<JSONObjResource> changeShopImage(ShopEntity shop,
			FileEntity image, String fieldName);

	public RestMethodResult<JSONObjResource> createShopBarcode(ShopEntity shop);

	public RestMethodResult<JSONArrayResource> searchShops(String searchWord);

	public RestMethodResult<JSONArrayResource> getShopeByDistance(
			LocationEntity location, int distance, int offset);

	public RestMethodResult<JSONObjResource> checkShopEmp(String shopId,
			String empId);
}
