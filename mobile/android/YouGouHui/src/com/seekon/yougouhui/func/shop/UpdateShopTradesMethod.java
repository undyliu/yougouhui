package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONObjResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class UpdateShopTradesMethod extends JSONObjResourceMethod {

	private static final URI UPDATE_SHOP_TRADES_URI = URI
			.create(Const.SERVER_APP_URL + "/updateShopTrades");

	private String shopId;
	private List<TradeEntity> tradeList;

	public UpdateShopTradesMethod(Context context, String shopId,
			List<TradeEntity> tradeList) {
		super(context);
		this.shopId = shopId;
		this.tradeList = tradeList;
	}

	@Override
	protected Request buildRequest() {

		StringBuffer trades = new StringBuffer();
		for (TradeEntity trade : tradeList) {
			trades.append("|" + trade.getUuid());
		}

		Map<String, String> params = new HashMap<String, String>();
		params.put(ShopTradeConst.COL_NAME_SHOP_ID, shopId);
		params.put(ShopConst.NAME_REQUEST_PARAMETER_TRADES, trades.substring(1));

		return new BaseRequest(Method.PUT, UPDATE_SHOP_TRADES_URI, null, params);
	}

}
