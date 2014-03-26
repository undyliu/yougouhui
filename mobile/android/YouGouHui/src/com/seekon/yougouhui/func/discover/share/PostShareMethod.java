package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import java.io.File;
import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.YouGouHuiApp;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.TextResource;

public class PostShareMethod extends MultipartRestMethod<TextResource> {

	private static final String POST_SHARE_URI = Const.SERVER_APP_URL
			+ "/saveShare";

	private Map share;

	public PostShareMethod(Map share){
		this(share, YouGouHuiApp.getAppContext());
	}
	
	public PostShareMethod(Map share, Context context) {
		super(context);
		this.share = share;
	}

	@Override
	protected Request buildRequest() {
		if (share == null) {
			return null;
		}
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_CONTENT, (String) share.get(COL_NAME_CONTENT));

		List<String> files = (List<String>) share.get(ShareConst.DATA_IMAGE_KEY);
		MultipartRequest request = new MultipartRequest(URI.create(POST_SHARE_URI),
				null, params, files);
		return request;
	}

	@Override
	protected TextResource parseResponseBody(String responseBody)
			throws Exception {
		return new TextResource(responseBody);
	}

}
