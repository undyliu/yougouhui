package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_PHONE;
import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_ICON;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.SyncSupportProcessor;
import com.seekon.yougouhui.func.spi.ISaleDiscussProcessor;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;

public class SaleDiscussProcessor extends SyncSupportProcessor implements
		ISaleDiscussProcessor {

	private static ISaleDiscussProcessor instance = null;
	private static Object lock = new Object();

	public static ISaleDiscussProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ISaleDiscussProcessor) proxy.bind(new SaleDiscussProcessor(
						mContext));
			}
		}
		return instance;
	}

	private SaleDiscussProcessor(Context mContext) {
		super(mContext, SaleDiscussData.COL_NAMES, SaleDiscussConst.CONTENT_URI,
				SaleDiscussConst.TABLE_NAME);
	}

	/**
	 * 重载更新评论的方法，同时，更新发布者
	 */
	@Override
	protected void modifyContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.modifyContentProvider(jsonObj, colNames, contentUri);
		if (jsonObj.has(COL_NAME_PHONE)) {// 包含有手机号
			JSONObject user = JSONUtils.cloneJSONObject(jsonObj, new String[] {
					COL_NAME_PHONE, COL_NAME_USER_ICON });
			user.put(COL_NAME_UUID, jsonObj.getString(SaleConst.COL_NAME_PUBLISHER));
			user.put(COL_NAME_NAME, jsonObj.get(UserConst.NAME_USER_NAME));
			super.modifyContentProvider(user, new String[] { COL_NAME_UUID,
					COL_NAME_NAME, COL_NAME_PHONE, COL_NAME_USER_ICON },
					UserConst.CONTENT_URI);
		}
	}

	/**
	 * 重载同步时间，user_id为*
	 * 
	 */
	@Override
	protected void recordUpdateTime(String updateTime, JSONObjResource resource) {
		SyncData syncData = SyncData.getInstance(mContext);
		syncData.updateData(syncTableName, "*", updateTime);
	}

	public RestMethodResult<JSONObjResource> deleteDiscuss(String uuid) {
		return (RestMethodResult) this.execMethod(new DeleteDiscussMethod(mContext,
				uuid));
	}

	public RestMethodResult<JSONObjResource> postDiscuss(SaleDiscussEntity discuss) {
		return (RestMethodResult) this.execMethod(new PostDiscussMethod(mContext,
				discuss));
	}

	public RestMethodResult<JSONObjResource> getDiscusses(String saleId,
			String updateTime) {
		return (RestMethodResult) this.execMethod(new GetDiscussesMethod(mContext,
				saleId, updateTime));
	}
}
