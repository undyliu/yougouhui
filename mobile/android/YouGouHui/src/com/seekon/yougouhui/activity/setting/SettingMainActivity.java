package com.seekon.yougouhui.activity.setting;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_VALUE;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.app.ListActivity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.setting.SettingConst;
import com.seekon.yougouhui.func.setting.SettingEntity;
import com.seekon.yougouhui.func.setting.SettingProcessor;
import com.seekon.yougouhui.func.setting.widget.SettingListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

/**
 * 系统设置：设置登录配置信息
 * 
 * @author undyliu
 * 
 */
public class SettingMainActivity extends ListActivity {

	private List<SettingEntity> settingList = new ArrayList<SettingEntity>();

	private SettingListAdapter settingListAdapter;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.base_listview);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		settingListAdapter = new SettingListAdapter(this, settingList);
		this.setListAdapter(settingListAdapter);

		loadSettingList();
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void loadSettingList() {
		loadSettingListFromLocal();
		if (settingList.isEmpty()) {
			loadSettingListFromRemote();
		} else {
			settingListAdapter.updateData(settingList);
		}
	}

	private void loadSettingListFromLocal() {
		String[] projection = new String[] { COL_NAME_UUID, COL_NAME_CODE,
				COL_NAME_NAME, COL_NAME_IMG, COL_NAME_VALUE };
		Cursor cursor = null;
		try {
			cursor = this.getContentResolver().query(SettingConst.CONTENT_URI,
					projection, null, null, COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				int i = 0;
				SettingEntity settings = new SettingEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++), cursor.getString(i++));
				settings.setValue(cursor.getString(i++));
				settingList.add(settings);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
	}

	private void loadSettingListFromRemote() {
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return SettingProcessor.getInstance(SettingMainActivity.this)
								.getSettings();
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						loadSettingListFromLocal();
						settingListAdapter.updateData(settingList);
					}
				});
	}
	
	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		Class<? extends Activity> clazz = null;
		String code = settingList.get(position).getCode();
		if(code.equals(SettingConst.SETTING_CODE_LOGIN)){
			clazz = LoginSettingActivity.class;
		}else if(code.equals(SettingConst.SETTING_CODE_RADAR)){
			clazz = RadarSettingActivity.class;
		}else if(code.equals(SettingConst.SETTING_CODE_CACHE)){
			clazz = CacheSettingActivity.class;
		}
		
		if(clazz != null){
			Intent intent = new Intent(this, clazz);
			startActivity(intent);
		}
	}
}
