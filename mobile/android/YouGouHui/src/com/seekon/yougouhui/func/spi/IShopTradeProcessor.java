package com.seekon.yougouhui.func.spi;

import java.util.List;

import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public interface IShopTradeProcessor {

	public RestMethodResult<JSONObjResource> saveShopTrades(String shopId,
			List<TradeEntity> trades);
}
