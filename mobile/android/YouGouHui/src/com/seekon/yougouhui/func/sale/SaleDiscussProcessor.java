package com.seekon.yougouhui.func.sale;

import org.json.JSONException;

import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.spi.ISaleDiscussProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class SaleDiscussProcessor extends ContentProcessor implements
		ISaleDiscussProcessor {

	private static final String TAG = SaleDiscussProcessor.class.getSimpleName();

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
		super(mContext, SaleDiscussData.COL_NAMES, SaleDiscussConst.CONTENT_URI);
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		super.updateContentProvider(result, colNames);
		if (result.getResource() instanceof JSONObjResource) {
			JSONObjResource resource = (JSONObjResource) result.getResource();
			if (resource.has(DataConst.COL_NAME_IS_DELETED)) {
				String isDeleted = JSONUtils.getJSONStringValue(resource,
						DataConst.COL_NAME_IS_DELETED);
				if (isDeleted != null && "1".equals(isDeleted)) {
					try {
						super.deleteContentProvider(resource, contentUri);
					} catch (JSONException e) {
						Logger.warn(TAG, e.getMessage());
					}
				}
			}
		}
	}

	public RestMethodResult<JSONObjResource> deleteDiscuss(String uuid) {
		return (RestMethodResult) this.execMethod(new DeleteDiscussMethod(mContext,
				uuid));
	}

	public RestMethodResult<JSONObjResource> postDiscuss(SaleDiscussEntity discuss) {
		return (RestMethodResult) this.execMethod(new PostDiscussMethod(mContext,
				discuss));
	}

	public RestMethodResult<JSONArrayResource> getDiscusses(String saleId) {
		return (RestMethodResult) this.execMethod(new GetDiscussesMethod(mContext,
				saleId));
	}
}
