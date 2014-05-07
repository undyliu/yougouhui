package com.seekon.yougouhui.func.sale;

import org.json.JSONObject;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.LocationUtils;

public class GetSalesByDistanceMethod extends JSONArrayResourceMethod {

	private static final String GET_SALES_BY_DISTANCE_URI = Const.SERVER_APP_URL
			+ "/getSalesByDistance";

	private int distance;
	private LocationEntity location;
	private int offset;

	public GetSalesByDistanceMethod(Context context, int distance,
			LocationEntity location, int offset) {
		super(context);
		this.distance = distance;
		this.location = location;
		this.offset = offset;
	}

	@Override
	protected Request buildRequest() {
		JSONObject jsonLoc = LocationUtils.toJSONObject(location);
		StringBuffer uri = new StringBuffer();
		uri.append(GET_SALES_BY_DISTANCE_URI);
		uri.append("/"
				+ JSONUtils.getJSONStringValue(jsonLoc, LocationUtils.key_latitude));
		uri.append("/"
				+ JSONUtils.getJSONStringValue(jsonLoc, LocationUtils.key_lontitude));
		uri.append("/" + distance);
		uri.append("/" + offset);

		return new BaseRequest(Method.GET, uri.toString(), null, null);
	}

}
