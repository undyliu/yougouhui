package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_SHOP_NAME;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.JSONUtils;

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

		MultipartRequest request = new MultipartRequest(URI.create(POST_SHARE_URI),
				null, params, share.getImages());
		return request;
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = new JSONObjResource(responseBody);
		if (resource.has(DataConst.COL_NAME_UUID)) {
			JSONUtils.putJSONValue(resource, COL_NAME_CONTENT, share.getContent());
			JSONUtils.putJSONValue(resource, COL_NAME_PUBLISHER, share.getPublisher()
					.getUuid());
			JSONUtils.putJSONValue(resource, COL_NAME_SHOP_ID, share.getShopId());
			JSONUtils.putJSONValue(resource, COL_NAME_SHOP_NAME, share.getShopName());
			
			List<FileEntity> images = share.getImages();
			if (images.size() > 0) {
				String shareId = JSONUtils.getJSONStringValue(resource,
						DataConst.COL_NAME_UUID);
				JSONArray imgArray = resource.getJSONArray(ShareConst.DATA_IMAGE_KEY);
				for (int i = 0; i < imgArray.length(); i++) {
					JSONObject image = imgArray.getJSONObject(i);
					JSONUtils.putJSONValue(image, ShareConst.COL_NAME_SHARE_ID, shareId);
					JSONUtils.putJSONValue(image, DataConst.COL_NAME_ORD_INDEX, i);
				}
			}
		}
		return resource;
	}

}
