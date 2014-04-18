package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface ISaleDiscussProcessor {

	public RestMethodResult<JSONObjResource> deleteDiscuss(String uuid);

	public RestMethodResult<JSONObjResource> postDiscuss(SaleDiscussEntity discuss);

	public RestMethodResult<JSONArrayResource> getDiscusses(String saleId);
}
