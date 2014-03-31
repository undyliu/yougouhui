package com.seekon.yougouhui.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.json.JSONObject;


public class JSONUtils {
	
	private JSONUtils(){
		
	}
	
	public static String[] getKeys(JSONObject json){
		List<String> keys = new ArrayList<String>();
		Iterator<String> keyItera = json.keys();
		while(keyItera.hasNext()){
			keys.add(keyItera.next());
		}
		return keys.toArray(new String[keys.size()]);
	}
}
