package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.share.ShopReplyEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShopReplyProcessor {

	public RestMethodResult<JSONObjResource> saveShareReply(ShopReplyEntity reply);
}
