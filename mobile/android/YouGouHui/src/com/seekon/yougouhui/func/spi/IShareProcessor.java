package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShareProcessor {

	public RestMethodResult<JSONObjResource> getShares(String updateTime);

	public RestMethodResult<JSONObjResource> postShare(ShareEntity share);

	public RestMethodResult<JSONObjResource> deleteShare(String shareId);

}
