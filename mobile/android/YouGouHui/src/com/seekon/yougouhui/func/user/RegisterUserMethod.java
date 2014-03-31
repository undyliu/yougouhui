package com.seekon.yougouhui.func.user;

import java.net.URI;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.util.JsonReader;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 会员注册
 * 
 * @author undyliu
 * 
 */
public class RegisterUserMethod extends MultipartRestMethod<JSONObjResource> {

	private static final URI REGISER_USER_URI = URI.create(Const.SERVER_APP_URL
			+ "/registerUser");

	private Map<String, String> user;

	public RegisterUserMethod(Context context, Map<String, String> user) {
		super(context);
		this.user = user;
	}

	@Override
	protected Request buildRequest() {
		String phone = user.get(UserConst.COL_NAME_PHONE);
		String fileUri = (String) user.get(UserConst.COL_NAME_USER_ICON);

		List<FileEntity> fileEntities = new ArrayList<FileEntity>();
		if (fileUri != null && fileUri.length() > 0) {
			String fileName = phone + "_" + System.currentTimeMillis() + ".png";
			fileEntities.add(new FileEntity(fileUri, fileName));
			user.put(UserConst.COL_NAME_USER_ICON, fileName);
		}

		return new MultipartRequest(REGISER_USER_URI, null, user, fileEntities);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource result = new JSONObjResource(responseBody);
		Iterator<String> keys = user.keySet().iterator();
		while (keys.hasNext()) {
			String key = keys.next();
			result.put(key, user.get(key));
		}
		return result;
	}

}
