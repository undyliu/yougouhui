package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShopFavoritProcessor {

	public RestMethodResult<JSONObjResource> addShopFavorit(ShopEntity shop,
			String userId);

	public RestMethodResult<JSONArrayResource> getShopFavoritesByUser(
			String userId);

	public RestMethodResult<JSONObjResource> deleteShopFavorit(String shopId,
			String userId);
}
