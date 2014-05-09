package com.seekon.yougouhui.func.module;

import java.util.ArrayList;
import java.util.List;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public class ModuleConst implements DataConst {

	public static final String TABLE_NAME = "e_module";

	public static final String AUTHORITY = "com.seekon.yougouhui.modules";

	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY
			+ "/" + TABLE_NAME);

	public static final String CODE_FRIENDS = "friends";
	public static final String CODE_RADAR = "radar";

	public static final String CODE_SETTING = "settings";
	public static final String CODE_MY_SHARE = "my_share";
	public static final String CODE_MY_SHOP = "my_shop";
	public static final String CODE_CONTACT_LIST = "contact_list";
	public static final String CODE_MY_FAVORIT = "my_favorite";
	public static final String CODE_MY_GRADE = "my_grade";
	public static final String CODE_MY_MESSAGE = "my_message";
	
	public static List<String> anonymousAccessModelList = new ArrayList<String>();

	static {
		anonymousAccessModelList.add(ModuleConst.CODE_FRIENDS);
		anonymousAccessModelList.add(ModuleConst.CODE_RADAR);
		anonymousAccessModelList.add(ModuleConst.CODE_SETTING);
		//anonymousAccessModelList.add(ModuleConst.CODE_MY_SHOP);
	}
}
