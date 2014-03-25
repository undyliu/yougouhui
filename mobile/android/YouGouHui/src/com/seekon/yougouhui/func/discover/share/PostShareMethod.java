package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import java.io.File;
import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.ContentValues;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.MultipartClient;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.RestMethod;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.Resource;

public class PostShareMethod implements RestMethod<Resource> {

	private static final String POST_SHARE_URI = Const.SERVER_APP_URL
			+ "/saveShare";

	private Map share;

	public PostShareMethod(Map share) {
		super();
		this.share = share;
	}

	@Override
	public RestMethodResult<Resource> execute() {
		if (share == null) {
			return null;
		}
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_CONTENT, (String)share.get(COL_NAME_CONTENT));

		List<File> files = (List<File>) share.get(ShareConst.DATA_IMAGE_KEY);
		MultipartRequest request = new MultipartRequest(URI.create(POST_SHARE_URI),
				null, params, files);

		MultipartClient client = new MultipartClient();
		client.execute(request);

		return null;
	}

}
