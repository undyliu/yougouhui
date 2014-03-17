package com.seekon.yougouhui.func.module;

import android.content.UriMatcher;
import android.database.sqlite.SQLiteDatabase;
import android.net.Uri;

import com.seekon.yougouhui.func.SQLiteContentProvider;

public class ModuleProvider extends SQLiteContentProvider{

	private static final int MODULES = 1;
	
	private static final int MODULE_ID = 2;

	private static final String CONTENT_ITEM_TYPE = "vnd.android.cursor.item/vnd.seekon.module";

	private static final String CONTENT_TYPE = "vnd.android.cursor.dir/vnd.seekon.module";
	
	private ModuleData modules;
	
	private UriMatcher uriMatcher;
	
	public ModuleProvider() {
		super(ModuleConst.TABLE_NAME);
	}

	@Override
	public boolean onCreate() {
		uriMatcher = new UriMatcher(UriMatcher.NO_MATCH);
		uriMatcher.addURI(ModuleConst.AUTHORITY, ModuleConst.TABLE_NAME, MODULES);
		uriMatcher.addURI(ModuleConst.AUTHORITY, ModuleConst.TABLE_NAME + "/#", MODULE_ID);
		
		modules = new ModuleData(getContext());
		modules.onCreate(modules.getWritableDatabase());//TODO:
		return true;
	}
	
	@Override
	protected SQLiteDatabase getWritableDatabase() {
		return modules.getWritableDatabase();
	}

	@Override
	protected SQLiteDatabase getReadableDatabase() {
		return modules.getReadableDatabase();
	}

	@Override
	protected boolean validateUri(Uri uri, Action action) {
		if(action == Action.UPDATE || action == Action.QUERY || action == Action.DELETE){
			return uriMatcher.match(uri) == MODULE_ID;
		}else if(action == Action.INSERT){
			return uriMatcher.match(uri) == MODULES;
		}
		return false;
	}

	@Override
	public String getType(Uri uri) {
		switch (uriMatcher.match(uri)) {
		case MODULES:
			return CONTENT_TYPE;
		case MODULE_ID:
			return CONTENT_ITEM_TYPE;
		default:
			throw new IllegalArgumentException("Unknown URI " + uri);
		}
	}

}
