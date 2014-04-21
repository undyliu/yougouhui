package com.seekon.yougouhui.func.favorit;

import static com.seekon.yougouhui.func.favorit.SaleFavoritConst.COL_NAME_SALE_ID;
import static com.seekon.yougouhui.func.favorit.SaleFavoritConst.COL_NAME_USER_ID;
import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.spi.ISaleFavoritProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;

public class SaleFavoritProcessor extends ContentProcessor implements
		ISaleFavoritProcessor {

	private static ISaleFavoritProcessor instance = null;
	private static Object lock = new Object();

	public static ISaleFavoritProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ISaleFavoritProcessor) proxy.bind(new SaleFavoritProcessor(
						mContext));
			}
		}
		return instance;
	}

	private SaleFavoritProcessor(Context mContext) {
		super(mContext, SaleFavoritData.COL_NAMES, SaleFavoritConst.CONTENT_URI);
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		if (result.getResource() instanceof JSONObjResource) {
			JSONObjResource resource = (JSONObjResource) result.getResource();
			if (resource.has(DataConst.COL_NAME_IS_DELETED)) {
				String deleted = JSONUtils.getJSONStringValue(resource,
						DataConst.COL_NAME_IS_DELETED);
				if (deleted != null && deleted.equals("1")) {
					String where = COL_NAME_SALE_ID + "=? and " + COL_NAME_USER_ID + "=?";
					String[] selectionArgs = new String[] {
							JSONUtils.getJSONStringValue(resource, COL_NAME_SALE_ID),
							JSONUtils.getJSONStringValue(resource, COL_NAME_USER_ID) };
					mContext.getContentResolver()
							.delete(contentUri, where, selectionArgs);
				}
				return;
			}
		}
		super.updateContentProvider(result, colNames);

	}

	public RestMethodResult<JSONObjResource> addSaleFavorit(SaleEntity sale,
			String userId) {
		return (RestMethodResult) this.execMethod(new PostSaleFavoritMethod(
				mContext, sale, userId));
	}

	public RestMethodResult<JSONArrayResource> getSaleFavoritesByUser(
			String userId) {
		return (RestMethodResult) this.execMethod(new GetSaleFavoritesMethod(
				mContext, userId));
	}

	public RestMethodResult<JSONObjResource> deleteSaleFavorit(String saleId,
			String userId) {
		return (RestMethodResult) this.execMethod(new DeleteSaleFavoritMethod(
				mContext, saleId, userId));
	}
}
