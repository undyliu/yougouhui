package com.seekon.yougouhui.service;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.RestMethod;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.util.ContentUtils;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ContentProcessor {

	protected static final String TAG = ContentProcessor.class.getSimpleName();

	protected Context mContext;

	protected String[] colNames;

	protected Uri contentUri;

	public ContentProcessor(Context mContext, String[] colNames, Uri contentUri) {
		super();
		this.mContext = mContext.getApplicationContext();
		this.colNames = colNames;
		this.contentUri = contentUri;
	}

	public String[] getColNames() {
		return colNames;
	}

	public Uri getContentUri() {
		return contentUri;
	}

	protected RestMethodResult<Resource> execMethod(RestMethod method) {
		RestMethodResult<Resource> result = method.execute();
		try {
			if (result.getStatusCode() == 200) {
				updateContentProvider(result);
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return result;
	}

	protected RestMethodResult<Resource> execMethodWithCallback(
			RestMethod method, ProcessorCallback callback) {
		RestMethodResult<Resource> result = this.execMethod(method);
		if (callback != null) {
			callback.send(result.getStatusCode());
		}
		return result;
	}

	protected void updateContentProvider(RestMethodResult<Resource> result) {
		if (result == null) {
			return;
		}
		try {
			Resource resource = result.getResource();
			if (resource != null) {
				if (resource instanceof JSONArrayResource) {
					JSONArrayResource jsonArrayResource = (JSONArrayResource) resource;
					this.updateContentProvider(jsonArrayResource, colNames, contentUri);
				} else if (resource instanceof JSONObjResource) {
					this.updateContentProvider((JSONObjResource) resource, colNames,
							contentUri);
				}
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}

	protected void updateContentProvider(JSONArray jsonArray, String[] colNames,
			Uri contentUri) throws JSONException {
		int size = jsonArray.length();
		if (size > 0) {
			for (int i = 0; i < size; i++) {
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				this.updateContentProvider(jsonObj, colNames, contentUri);
			}
		}
	}

	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		String isDel = JSONUtils.getJSONStringValue(jsonObj,
				DataConst.COL_NAME_IS_DELETED);
		if (isDel != null && "1".equals(isDel)) {
			this.deleteContentProvider(jsonObj, contentUri);
		} else {
			this.modifyContentProvider(jsonObj, colNames, contentUri);
		}
	}

	protected void modifyContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		ContentValues values = ContentValuesUtils.fromJSONObject(jsonObj, colNames);
		ContentResolver resolver = mContext.getContentResolver();
		String id = values.getAsString(COL_NAME_UUID);
		if(id == null){
			id = jsonObj.getString(COL_NAME_UUID);
		}
		int count = resolver.update(ContentUtils.withAppendedId(contentUri, id),
				values, null, null);
		if (count == 0) {
			resolver.insert(contentUri, values);
		}
	}

	protected void deleteContentProvider(JSONObject jsonObj, Uri contentUri)
			throws JSONException {
		if (jsonObj == null) {
			return;
		}
		ContentResolver resolver = mContext.getContentResolver();
		String id = jsonObj.getString(COL_NAME_UUID);
		String where = COL_NAME_UUID + "=?";
		resolver.delete(contentUri, where, new String[] { id });
	}
}
