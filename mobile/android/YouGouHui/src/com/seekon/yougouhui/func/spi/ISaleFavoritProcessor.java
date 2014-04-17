package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface ISaleFavoritProcessor {

	public RestMethodResult<JSONObjResource> addSaleFavorit(SaleEntity sale,
			String userId);

	public RestMethodResult<JSONArrayResource> getSaleFavoritesByUser(
			String userId);

	public RestMethodResult<JSONObjResource> deleteSaleFavorit(String saleId,
			String userId);
}
