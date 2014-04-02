package com.seekon.yougouhui.service;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.rest.RestMethod;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.util.ContentUtils;
import com.seekon.yougouhui.util.ContentValuesUtils;
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

	protected RestMethodResult<Resource> execMethod(RestMethod method) {
		RestMethodResult<Resource> result = method.execute();
		try {
			if (result.getStatusCode() == 200) {
				updateContentProvider(result, this.colNames);
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return result;
	}

	protected RestMethodResult<Resource> execMethodWithCallback(
			RestMethod method, ProcessorCallback callback) {
		RestMethodResult<Resource> result = this.execMethod(method);
		callback.send(result.getStatusCode());
		return result;
	}

	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		if (result == null) {
			return;
		}
		try {
			Resource resource = result.getResource();
			if (resource != null) {
				if (resource instanceof JSONArrayResource) {
					JSONArrayResource jsonArrayResource = (JSONArrayResource) resource;
					int size = jsonArrayResource.length();
					if (size > 0) {
						for (int i = 0; i < size; i++) {
							JSONObject jsonObj = jsonArrayResource.getJSONObject(i);
							this.updateContentProvider(jsonObj, colNames, contentUri);
						}
					}
				} else if (resource instanceof JSONObjResource) {
					this.updateContentProvider((JSONObjResource) resource, colNames,
							contentUri);
				}
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}

	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		ContentValues values = ContentValuesUtils.fromJSONObject(jsonObj, colNames);

		ContentResolver resolver = mContext.getContentResolver();
		String id = values.getAsString(COL_NAME_UUID);
		int count = resolver.update(ContentUtils.withAppendedId(contentUri, id),
				values, null, null);
		if (count == 0) {
			resolver.insert(contentUri, values);
		}
	}

	protected void deleteContentProvider(JSONArray jsonArray, Uri contentUri)
			throws JSONException {
		if (jsonArray == null) {
			return;
		}
		int size = jsonArray.length();
		for (int i = 0; i < size; i++) {
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			this.deleteContentProvider(jsonObj, contentUri);
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
