package com.seekon.yougouhui.func.radar.widget;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.shop.GeoShopEntity;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.Logger;

public class RadarShopListView extends RadarResultListView<GeoShopEntity> {

	public RadarShopListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public RadarShopListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public RadarShopListView(Context context) {
		super(context);
	}

	@Override
	public EntityListAdapter<GeoShopEntity> getEntityListAdapter() {
		return new GeoShopListAdapter(context, dataList);
	}

	@Override
	protected List<GeoShopEntity> loadDataListFromRemote(int currentOffset,
			final LocationEntity location, final int distance) {

		RestMethodResult<JSONArrayResource> result = ShopProcessor.getInstance(
				context).getShopeByDistance(location, distance, currentOffset);
		if (result != null) {
			int status = result.getStatusCode();
			if (status == RestStatus.SC_OK) {
				List<GeoShopEntity> data = new ArrayList<GeoShopEntity>();
				JSONArrayResource resource = result.getResource();
				if (resource != null) {
					for (int i = 0; i < resource.length(); i++) {
						try {
							GeoShopEntity entity = new GeoShopEntity();

							JSONObject obj = resource.getJSONObject(i);
							entity.setUuid(obj.getString(DataConst.COL_NAME_UUID));
							entity.setName(obj.getString(DataConst.COL_NAME_NAME));
							entity.setBarcode(obj.getString(ShopConst.COL_NAME_BARCODE));
							entity.setOwner(obj.getString(ShopConst.COL_NAME_OWNER));
							entity.setShopImage(obj.getString(ShopConst.COL_NAME_SHOP_IMAGE));
							entity.setDistance(obj.getDouble(DataConst.NAME_DISTANCE));

							data.add(entity);
						} catch (JSONException e) {
							Logger.warn(TAG, e.getMessage(), e);
							throw new RuntimeException(e);
						}
					}
				}
				return data;
			}
		}
		return null;
	}
}
