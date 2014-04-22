package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface ISaleProcessor {

	public RestMethodResult<JSONObjResource> getSalesByChannel(String channelId, String updateTime);

	public RestMethodResult<JSONArrayResource> getSalesByShop(String shopId);

	public RestMethodResult<JSONObjResource> publishSale(SaleEntity sale);

	public RestMethodResult<JSONObjResource> getSale(String saleId);
	
	public RestMethodResult<JSONObjResource> cancelSale(SaleEntity sale);
}
