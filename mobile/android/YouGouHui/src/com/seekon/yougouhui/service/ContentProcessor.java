package com.seekon.yougouhui.service;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

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

	protected void execMethodWithCallback(RestMethod method,
			ProcessorCallback callback) {
		RestMethodResult<Resource> result = method.execute();

		try {
			updateContentProvider(result);
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}

		callback.send(result.getStatusCode());
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
}
