package com.seekon.yougouhui.func.setting;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_VALUE;
import static com.seekon.yougouhui.func.setting.SettingConst.COL_NAME_USER_ID;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_DISTANCE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_FRIEND;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SALE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SHOP;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.database.Cursor;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class SettingUtils {
	
	private final static String TAG = SettingUtils.class.getSimpleName();
	
	private SettingUtils(){
		
	}
	
	public static JSONObject parseSettingValue(SettingEntity settings){
		if(settings == null){
			return null;
		}
		
		String value = settings.getValue();
		if(value == null || value.trim().length() == 0){
			return null;
		}
		
		try {
			return new JSONObject(value);
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage(), e);
		}
		return null;
	}
	
	public static SettingEntity getRadarSettingsWithDefaultValue(Context context){
		SettingEntity settings = null;
		String[] projection = new String[] { COL_NAME_UUID, COL_NAME_VALUE };
		String selection = COL_NAME_CODE + "=? and " + COL_NAME_USER_ID + "=?";
		String[] selectionArgs = new String[] { SettingConst.SETTING_CODE_RADAR,
				RunEnv.getInstance().getUser().getUuid() };
		Cursor cursor = null;
		try {
			cursor = context.getContentResolver().query(SettingConst.CONTENT_URI,
					projection, selection, selectionArgs, null);
			cursor.moveToNext();
			settings = new SettingEntity(cursor.getString(0),
					SettingConst.SETTING_CODE_RADAR, null, null);
			settings.setValue(cursor.getString(1));
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}

		String value = settings.getValue();
		if (value == null || value.trim().length() == 0) {
			settings.setValue(getDefaultRadarValue().toString());
		}
		return settings;
	}
	
	public static JSONObject getDefaultRadarValue() {
		JSONObject obj = new JSONObject();
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_DISTANCE,
				SettingConst.RADAR_DEFAULT_DISTANCE);
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_SALE, true);
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_SHOP, true);
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_FRIEND, true);
		return obj;
	}
}
