package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_SHOP_ID;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class PostShareMethod extends MultipartRestMethod<JSONObjResource> {

	private static final String POST_SHARE_URI = Const.SERVER_APP_URL
			+ "/saveShare";

	private ShareEntity share;

	public PostShareMethod(ShareEntity share, Context context) {
		super(context);
		this.share = share;
	}

	@Override
	protected Request buildRequest() {
		if (share == null) {
			return null;
		}
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_CONTENT, share.getContent());
		params.put(COL_NAME_PUBLISHER, share.getPublisher().getUuid());
		params.put(COL_NAME_SHOP_ID, share.getShopId());

		// List<String> files = (List<String>) share.get(ShareConst.DATA_IMAGE_KEY);
		// List<FileEntity> fileEntities = new ArrayList<FileEntity>();
		// if (files != null && !files.isEmpty()) {
		// for (String fileUri : files) {
		// String aliasName = new File(fileUri).getPath().hashCode() + "_"
		// + System.currentTimeMillis() + ".png";
		// fileEntities.add(new FileEntity(fileUri, aliasName));
		// }
		// }
		MultipartRequest request = new MultipartRequest(URI.create(POST_SHARE_URI),
				null, params, share.getImages());
		return request;
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}

}
