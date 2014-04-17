package com.seekon.yougouhui.func.spi;

import java.util.List;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShopEmpProcessor {

	public RestMethodResult<JSONArrayResource> getShopEmps(String shopId);

	public RestMethodResult<JSONObjResource> addShopEmps(String shopId,
			List<UserEntity> empList);

	public RestMethodResult<JSONObjResource> deleteShopEmps(String shopId,
			List<UserEntity> empList);

	public RestMethodResult<JSONObjResource> setShopEmpPwd(String shopId,
			String userId, String pwd);
}
