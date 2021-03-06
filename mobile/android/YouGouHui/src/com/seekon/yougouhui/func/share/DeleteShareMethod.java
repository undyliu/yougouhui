package com.seekon.yougouhui.func.share;

import java.net.URI;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

/**
 * 删除分享信息
 * 
 * @author undyliu
 * 
 */
public class DeleteShareMethod extends JSONObjResourceMethod {

	private static final String DELETE_SHARE_URI = Const.SERVER_APP_URL
			+ "/deleteShare";

	private String shareId;

	public DeleteShareMethod(Context context, String shareId) {
		super(context);
		this.shareId = shareId;
	}

	@Override
	protected Request buildRequest() {
		URI uri = URI.create(DELETE_SHARE_URI + "/" + shareId);
		return new BaseRequest(Method.DELETE, uri, null, null);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, DataConst.COL_NAME_IS_DELETED, 1);
		return resource;
	}
}
