package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IFriendProcessor {

	public RestMethodResult<JSONObjResource> addFriend(UserEntity user);

	public RestMethodResult<JSONObjResource> deleteFriend(UserEntity user);

	public RestMethodResult<JSONArrayResource> getFriends(UserEntity user);

	public RestMethodResult<JSONArrayResource> searchFriends(String searchWord);
}
