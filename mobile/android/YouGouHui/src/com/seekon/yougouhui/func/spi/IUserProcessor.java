package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IUserProcessor {

	public RestMethodResult<JSONObjResource> registerUser(UserEntity user);

	public RestMethodResult<JSONObjResource> updateUserName(String name);

	public RestMethodResult<JSONObjResource> updateUserPwd(String pwd);

	public RestMethodResult<JSONObjResource> updateUserPhoto(FileEntity photoUri);
}
