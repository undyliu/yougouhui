package com.seekon.yougouhui.func.user;

import java.util.Map;

import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.spi.IUserProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.Logger;

public class UserProcessor extends ContentProcessor implements IUserProcessor {

	private static final String TAG = UserProcessor.class.getSimpleName();

	private static IUserProcessor instance = null;

	private static Object lock = new Object();

	public static IUserProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IUserProcessor) proxy.bind(new UserProcessor(mContext));
			}
		}
		return instance;
	}

	private UserProcessor(Context mContext) {
		super(mContext, UserData.COL_NAMES, UserConst.CONTENT_URI);
	}

	/**
	 * 注册新用户
	 * 
	 * @param user
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public RestMethodResult<JSONObjResource> registerUser(Map<String, String> user) {
		return (RestMethodResult) this.execMethod(new RegisterUserMethod(mContext,
				user));
	}

	/**
	 * 修改用户昵称
	 * 
	 * @param name
	 * @return
	 */
	public RestMethodResult<JSONObjResource> updateUserName(String name) {
		RestMethodResult<JSONObjResource> result = new PutUserNameMethod(mContext,
				name).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			updateLocalDatabase(DataConst.COL_NAME_NAME, name);
		}
		return result;
	}

	/**
	 * 修改用户密码
	 * 
	 * @param pwd
	 * @return
	 */
	public RestMethodResult<JSONObjResource> updateUserPwd(String pwd) {
		RestMethodResult<JSONObjResource> result = new PutUserPwdMethod(mContext,
				pwd).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			updateLocalDatabase(UserConst.COL_NAME_PWD, pwd);
		}
		return result;
	}

	/**
	 * 保存用户的头像
	 * 
	 * @param photoUri
	 * @return
	 */
	public RestMethodResult<JSONObjResource> updateUserPhoto(FileEntity photoUri) {
		RestMethodResult<JSONObjResource> result = new PostUserPhotoMethod(
				mContext, photoUri).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			updateLocalDatabase(UserConst.COL_NAME_USER_ICON, photoUri.getAliasName());
		}
		return result;
	}

	private void updateLocalDatabase(String fieldName, String value) {
		try {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put(DataConst.COL_NAME_UUID, RunEnv.getInstance().getUser().getUuid());
			jsonObj.put(fieldName, value);
			this.updateContentProvider(jsonObj, new String[] { fieldName },
					contentUri);

		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage(), e);
			throw new RuntimeException(e);
		}
	}
}
