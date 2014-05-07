package com.seekon.yougouhui.func.radar.widget;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.sale.GeoSaleEntity;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.LocationUtils;
import com.seekon.yougouhui.util.Logger;

public class RadarSaleListView extends RadarResultListView<GeoSaleEntity> {

	public RadarSaleListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public RadarSaleListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public RadarSaleListView(Context context) {
		super(context);
	}

	@Override
	public EntityListAdapter<GeoSaleEntity> getEntityListAdapter() {
		return new GeoSaleListAdapter(context, dataList);
	}

	@Override
	protected List<GeoSaleEntity> loadDataListFromRemote(int currentOffset,
			LocationEntity location, int distance) {
		RestMethodResult<JSONArrayResource> result = SaleProcessor.getInstance(
				context).getSalesByDistance(location, distance, currentOffset);
		if (result != null) {
			int status = result.getStatusCode();
			if (status == RestStatus.SC_OK) {
				List<GeoSaleEntity> data = new ArrayList<GeoSaleEntity>();
				JSONArrayResource resource = result.getResource();
				for (int i = 0; i < resource.length(); i++) {
					try {
						GeoSaleEntity entity = new GeoSaleEntity();
						JSONObject obj = resource.getJSONObject(i);

						entity.setUuid(obj.getString(DataConst.COL_NAME_UUID));
						entity.setTitle(obj.getString(DataConst.COL_NAME_TITLE));
						entity.setImg(obj.getString(DataConst.COL_NAME_IMG));
						entity.setContent(obj.getString(DataConst.COL_NAME_CONTENT));
						entity.setVisitCount(obj.getInt(SaleConst.COL_NAME_VISIT_COUNT));
						entity
								.setDiscussCount(obj.getInt(SaleConst.COL_NAME_DISCUSS_COUNT));
						entity.setStatus(obj.getString(DataConst.COL_NAME_STATUS));
						entity.setDistance(obj.getDouble(DataConst.NAME_DISTANCE));
						
						UserEntity publisher = new UserEntity();
						publisher.setUuid(obj.getString(SaleConst.COL_NAME_PUBLISHER));
						entity.setPublisher(publisher);

						ShopEntity shop = new ShopEntity();
						shop.setUuid(obj.getString(SaleConst.COL_NAME_SHOP_ID));
						shop.setName(obj.getString(SaleConst.COL_NAME_SHOP_NAME));
						shop.setLocation(LocationUtils.fromJSONObject(new JSONObject(obj
								.getString(SaleConst.COL_NAME_LOCATION))));
						entity.setShop(shop);

						data.add(entity);
					} catch (JSONException e) {
						Logger.warn(TAG, e.getMessage(), e);
						throw new RuntimeException(e);
					}
				}
				return data;
			}
		}
		return null;
	}

}
