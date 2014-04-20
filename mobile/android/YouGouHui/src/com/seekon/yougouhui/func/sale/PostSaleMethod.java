package com.seekon.yougouhui.func.sale;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.MultipartRequest;
import com.seekon.yougouhui.rest.MultipartRestMethod;
import com.seekon.yougouhui.rest.Request;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class PostSaleMethod extends MultipartRestMethod<JSONObjResource> {

	private static final URI ADD_SALE_URI = URI.create(Const.SERVER_APP_URL
			+ "/addSale");

	private SaleEntity sale;

	public PostSaleMethod(Context context, SaleEntity sale) {
		super(context);
		this.sale = sale;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(DataConst.COL_NAME_TITLE, sale.getTitle());
		params.put(DataConst.COL_NAME_CONTENT, sale.getContent());
		params.put(SaleConst.COL_NAME_SHOP_ID, sale.getShop().getUuid());
		params.put(SaleConst.COL_NAME_TRADE_ID, sale.getTradeId());
		params.put(SaleConst.COL_NAME_START_DATE,
				String.valueOf(sale.getStartDate()));
		params.put(SaleConst.COL_NAME_END_DATE, String.valueOf(sale.getEndDate()));
		params.put(SaleConst.COL_NAME_PUBLISHER, sale.getPublisher().getUuid());
	
		return new MultipartRequest(ADD_SALE_URI, null, params, sale.getImages());
	}

	@Override
	protected JSONObjResource parseResponseBody(String responseBody)
			throws Exception {
		JSONObjResource resource = new JSONObjResource(responseBody);
		resource.put(DataConst.COL_NAME_TITLE, sale.getTitle());
		resource.put(DataConst.COL_NAME_CONTENT, sale.getContent());
		resource.put(SaleConst.COL_NAME_SHOP_ID, sale.getShop().getUuid());
		resource.put(SaleConst.COL_NAME_TRADE_ID, sale.getTradeId());
		resource.put(SaleConst.COL_NAME_START_DATE,
				String.valueOf(sale.getStartDate()));
		resource
				.put(SaleConst.COL_NAME_END_DATE, String.valueOf(sale.getEndDate()));
		resource.put(SaleConst.COL_NAME_PUBLISHER, sale.getPublisher().getUuid());
		return resource;
	}

}
