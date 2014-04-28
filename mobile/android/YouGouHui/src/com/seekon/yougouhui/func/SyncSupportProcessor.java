package com.seekon.yougouhui.func;

import org.json.JSONArray;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.sync.SyncConst;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

/**
 * 支持与远程数据库进行同步的processor
 * 
 * @author undyliu
 * 
 */
public abstract class SyncSupportProcessor extends ContentProcessor {

	protected String syncTableName;

	public SyncSupportProcessor(Context mContext, String[] colNames,
			Uri contentUri, String syncTableName) {
		super(mContext, colNames, contentUri);
		this.syncTableName = syncTableName;
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result) {
		if (result.getResource() instanceof JSONObjResource) {
			JSONObjResource resource = (JSONObjResource) result.getResource();
			String updateTime = JSONUtils.getJSONStringValue(resource,
					SyncConst.COL_NAME_UPDATE_TIME);
			if (updateTime == null) {
				super.updateContentProvider(result);
			} else {
				try {
					Object data = resource.get(DataConst.NAME_DATA);
					if (data instanceof JSONArray) {
						this.updateContentProvider((JSONArray) data, colNames, contentUri);
					} else if (data instanceof JSONObject) {
						this.updateContentProvider((JSONObject) data, colNames, contentUri);
					} else {
						throw new RuntimeException("远程调用返回值data不符合要求.");
					}

					recordUpdateTime(updateTime, resource);
				} catch (Exception e) {
					Logger.warn(TAG, e.getMessage(), e);
					throw new RuntimeException(e);
				}
			}
		} else {
			super.updateContentProvider(result);
		}
	}

	protected abstract void recordUpdateTime(String updateTime,
			JSONObjResource resource);
}
