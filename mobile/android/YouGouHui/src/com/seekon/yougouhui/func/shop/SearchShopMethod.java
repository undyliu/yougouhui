package com.seekon.yougouhui.func.shop;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.rest.BaseRequest;
import com.seekon.yougouhui.rest.JSONArrayResourceMethod;
import com.seekon.yougouhui.rest.Method;
import com.seekon.yougouhui.rest.Request;

public class SearchShopMethod extends JSONArrayResourceMethod {
	private static final String SEARCH_SHOPS_URI = Const.SERVER_APP_URL
			+ "/searchShops";

	private String searchWord;

	public SearchShopMethod(Context context, String searchWord) {
		super(context);
		this.searchWord = searchWord;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(DataConst.NAME_SEARCH_WORD, searchWord);

		return new BaseRequest(Method.POST, URI.create(SEARCH_SHOPS_URI), null,
				params);
	}

}
