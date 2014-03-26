package com.seekon.yougouhui.rest.resource;

import java.util.Collection;

import org.json.JSONArray;
import org.json.JSONException;

public class JSONArrayResource extends JSONArray implements Resource {

	public JSONArrayResource() {
		super();
	}

	public JSONArrayResource(Collection copyFrom) {
		super(copyFrom);
	}

	public JSONArrayResource(String json) throws JSONException {
		super(json);
	}

}
