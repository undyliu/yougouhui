package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

/**
 * 修改用户头像
 * @author undyliu
 *
 */
public class PostUserPhotoMethod extends MultipartRestMethod<JSONObjResource>{

	private static final URI SAVE_USER_PHOTO_URI = URI.create(Const.SERVER_APP_URL
			+ "/saveUserPhoto");
	
	private String photoUri;
	
	public PostUserPhotoMethod(Context context, String photoUri) {
		super(context);
		this.photoUri = photoUri;
	}

	@Override
	protected Request buildRequest() {
		ContentValues user = RunEnv.getInstance().getUser();
		List<FileEntity> files = new ArrayList<FileEntity>();
		String photoName = "";
		
		if(photoUri != null && photoUri.length() > 0){
			photoName = user.getAsString(COL_NAME_PHONE) + "_" + System.currentTimeMillis() + ".png";
			files.add(new FileEntity(photoUri, photoName));
		}
		
		Map<String, String> params = new HashMap<String, String>();
		params.put(COL_NAME_UUID, user.getAsString(COL_NAME_UUID));
		params.put(COL_NAME_USER_ICON, photoName);
		
		return new MultipartRequest(SAVE_USER_PHOTO_URI, null, params, files);
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		return new JSONObjResource(responseBody);
	}

}
