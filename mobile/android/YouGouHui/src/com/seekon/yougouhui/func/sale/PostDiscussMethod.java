package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.sale.SaleDiscussConst.COL_NAME_SALE_ID;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

public class PostDiscussMethod extends JSONObjResourceMethod {

	private static final URI ADD_SALE_DISCUSS_URI = URI
			.create(Const.SERVER_APP_URL + "/addSaleDiscuss");

	private SaleDiscussEntity discuss;

	public PostDiscussMethod(Context context, SaleDiscussEntity discuss) {
		super(context);
		this.discuss = discuss;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_SALE_ID, discuss.getSale().getUuid());
		params.put(COL_NAME_PUBLISHER, discuss.getPublisher().getUuid());
		params.put(COL_NAME_CONTENT, discuss.getContent());

		return new BaseRequest(Method.POST, ADD_SALE_DISCUSS_URI, null, params);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = super.parseResponseBody(responseBody);
		JSONUtils.putJSONValue(resource, COL_NAME_CONTENT, discuss.getContent());
		JSONUtils.putJSONValue(resource, COL_NAME_SALE_ID, discuss.getSale()
				.getUuid());
		JSONUtils.putJSONValue(resource, COL_NAME_PUBLISHER, discuss.getPublisher()
				.getUuid());
		
		discuss.setUuid(JSONUtils.getJSONStringValue(resource, DataConst.COL_NAME_UUID));
		
		return resource;
	}

}
