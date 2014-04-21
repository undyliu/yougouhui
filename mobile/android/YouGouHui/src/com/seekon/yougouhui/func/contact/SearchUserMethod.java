package com.seekon.yougouhui.func.contact;

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

/**
 * 搜索用户
 * 
 * @author undyliu
 * 
 */
public class SearchUserMethod extends JSONArrayResourceMethod {
	private static final String GET_USERS_URI = Const.SERVER_APP_URL
			+ "/searchUsers";

	private String searchWord;

	public SearchUserMethod(Context context, String searchWord) {
		super(context);
		this.searchWord = searchWord;
	}

	@Override
	protected Request buildRequest() {
		Map<String, String> params = new HashMap<String, String>();
		params.put(DataConst.NAME_SEARCH_WORD, searchWord);

		return new BaseRequest(Method.POST, URI.create(GET_USERS_URI), null, params);
	}

}
