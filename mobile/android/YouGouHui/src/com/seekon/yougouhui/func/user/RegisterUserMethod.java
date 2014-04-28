package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TYPE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PWD;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import android.content.Context;

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

	private UserEntity user;

	private Map<String, String> params = new HashMap<String, String>();

	public RegisterUserMethod(Context context, UserEntity user) {
		super(context);
		this.user = user;
	}

	@Override
	protected Request buildRequest() {
		params.put(COL_NAME_PHONE, user.getPhone());
		params.put(COL_NAME_NAME, user.getName());
		params.put(COL_NAME_PWD, user.getPwd());
		params.put(COL_NAME_TYPE, user.getType());
		
		String phone = user.getPhone();
		String fileUri = user.getPhoto();

		List<FileEntity> fileEntities = new ArrayList<FileEntity>();
		if (fileUri != null && fileUri.length() > 0) {
			String fileName = phone + "_" + System.currentTimeMillis() + ".png";
			fileEntities.add(new FileEntity(fileUri, fileName));
			params.put(UserConst.COL_NAME_USER_ICON, fileName);
		}

		return new MultipartRequest(REGISER_USER_URI, null, params, fileEntities);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource result = new JSONObjResource(responseBody);
		Iterator<String> keys = params.keySet().iterator();
		while (keys.hasNext()) {
			String key = keys.next();
			result.put(key, params.get(key));
		}
		return result;
	}

}
