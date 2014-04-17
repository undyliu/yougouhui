package com.seekon.yougouhui.func.profile.favorit;

import static com.seekon.yougouhui.func.profile.favorit.ShopFavoritConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.profile.favorit.ShopFavoritConst.COL_NAME_USER_ID;
import android.content.Context;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.spi.IShopFavoritProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;

public class ShopFavoritProcessor extends ContentProcessor implements IShopFavoritProcessor{

	private static IShopFavoritProcessor instance = null;
	private static Object lock = new Object();

	public static IShopFavoritProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IShopFavoritProcessor) proxy.bind(new ShopFavoritProcessor(mContext));
			}
		}
		return instance;
	}

	private ShopFavoritProcessor(Context mContext) {
		super(mContext, ShopFavoritData.COL_NAMES, ShopFavoritConst.CONTENT_URI);
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
					String where = COL_NAME_SHOP_ID + "=? and " + COL_NAME_USER_ID + "=?";
					String[] selectionArgs = new String[] {
							JSONUtils.getJSONStringValue(resource, COL_NAME_SHOP_ID),
							JSONUtils.getJSONStringValue(resource, COL_NAME_USER_ID) };
					mContext.getContentResolver()
							.delete(contentUri, where, selectionArgs);
				}
				return;
			}
		}
		super.updateContentProvider(result, colNames);

	}

	public RestMethodResult<JSONObjResource> addShopFavorit(ShopEntity shop,
			String userId) {
		return (RestMethodResult) this.execMethod(new PostShopFavoritMethod(
				mContext, shop, userId));
	}

	public RestMethodResult<JSONArrayResource> getShopFavoritesByUser(
			String userId) {
		return (RestMethodResult) this.execMethod(new GetShopFavoritesMethod(
				mContext, userId));
	}

	public RestMethodResult<JSONObjResource> deleteShopFavorit(String shopId,
			String userId) {
		return (RestMethodResult) this.execMethod(new DeleteShopFavoritMethod(
				mContext, shopId, userId));
	}
}
