package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorCallback;

public interface ISaleProcessor {

	public void getSalesByChannel(ProcessorCallback callback, String channelId);
	
	public RestMethodResult<JSONArrayResource> getSalesByShop(String shopId);
	
	public RestMethodResult<JSONObjResource> publishSale(SaleEntity sale);
	
	public RestMethodResult<JSONObjResource> getSale(String saleId);
}
