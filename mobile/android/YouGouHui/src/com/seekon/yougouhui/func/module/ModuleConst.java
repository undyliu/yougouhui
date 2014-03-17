package com.seekon.yougouhui.func.module;

import android.net.Uri;

import com.seekon.yougouhui.func.DataConst;

public interface ModuleConst extends DataConst{

	public static final String TABLE_NAME = "e_module";
	
	public static final String AUTHORITY = "com.seekon.yougouhui.modules";
	
	public static final Uri CONTENT_URI = Uri.parse("content://" + AUTHORITY + "/" + TABLE_NAME);

}
