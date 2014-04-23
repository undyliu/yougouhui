package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShareProcessor {

	public RestMethodResult<JSONObjResource> getFriendShares(String updateTime);

	public RestMethodResult<JSONObjResource> postShare(ShareEntity share);

	public RestMethodResult<JSONObjResource> deleteShare(String shareId);

	public RestMethodResult<JSONArrayResource> getUserShares(UserEntity publisher);

	public RestMethodResult<JSONObjResource> getShopShares(String shopId,
			String updateTime);
}
