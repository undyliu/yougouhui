package com.seekon.yougouhui.func.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.Map;

import org.json.JSONException;

import android.content.Context;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.spi.IUserProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
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

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		String[] newColNames = null;
		UserEntity user = RunEnv.getInstance().getUser();
		if (user != null) {
			String uuid = user.getUuid();
			if (uuid != null && uuid.length() > 0) {
				Resource resource = result.getResource();
				if (resource instanceof JSONObjResource) {
					JSONObjResource jsonRes = (JSONObjResource) resource;
					try {
						if (uuid.equals(jsonRes.getString(COL_NAME_UUID))) {
							newColNames = JSONUtils.getKeys(jsonRes);
							user = UserUtils.updateUserEntity(user, jsonRes);
							RunEnv.getInstance().setUser(user);// 更新系统环境中的user对象
						}
					} catch (JSONException e) {
						Logger.warn(TAG, e.getMessage());
					}
				}
			}
		}
		if (newColNames == null || newColNames.length == 0) {
			newColNames = colNames;
		}
		super.updateContentProvider(result, newColNames);
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
		return (RestMethodResult) this.execMethod(new PutUserNameMethod(mContext,
				name));
	}

	/**
	 * 修改用户密码
	 * 
	 * @param pwd
	 * @return
	 */
	public RestMethodResult<JSONObjResource> updateUserPwd(String pwd) {
		return (RestMethodResult) this.execMethod(new PutUserPwdMethod(mContext,
				pwd));
	}

	/**
	 * 保存用户的头像
	 * 
	 * @param photoUri
	 * @return
	 */
	public RestMethodResult<JSONObjResource> updateUserPhoto(String photoUri) {
		return (RestMethodResult) this.execMethod(new PostUserPhotoMethod(mContext,
				photoUri));
	}
}
