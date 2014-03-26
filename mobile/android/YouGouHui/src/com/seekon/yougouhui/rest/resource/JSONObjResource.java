package com.seekon.yougouhui.rest.resource;

import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

public class JSONObjResource extends JSONObject implements Resource {

	public JSONObjResource() {
		super();
	}

	public JSONObjResource(Map copyFrom) {
		super(copyFrom);
	}

	public JSONObjResource(String json) throws JSONException {
		super(json);
	}

}
