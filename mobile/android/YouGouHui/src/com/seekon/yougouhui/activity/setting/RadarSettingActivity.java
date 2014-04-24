package com.seekon.yougouhui.activity.setting;

import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_DISTANCE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_FRIEND;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SALE;
import static com.seekon.yougouhui.func.setting.SettingConst.RADAR_VAL_FIELD_SHOP;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.CheckBox;
import android.widget.NumberPicker;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.setting.SettingData;
import com.seekon.yougouhui.func.setting.SettingEntity;
import com.seekon.yougouhui.func.setting.SettingUtils;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class RadarSettingActivity extends Activity {

	private static final String TAG = RadarSettingActivity.class.getSimpleName();

	private NumberPicker numberPicker;
	private CheckBox saleCheck;
	private CheckBox shopCheck;
	private CheckBox friendCheck;

	private SettingEntity settings;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.setting_radar);

		initViews();
		loadData();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		numberPicker = (NumberPicker) findViewById(R.id.numberPicker);
		numberPicker.setMaxValue(10000);
		numberPicker.setMinValue(1);
		numberPicker.setWrapSelectorWheel(false);

		saleCheck = (CheckBox) findViewById(R.id.c_radar_sale);
		shopCheck = (CheckBox) findViewById(R.id.c_radar_shop);
		friendCheck = (CheckBox) findViewById(R.id.c_radar_friend);

	}

	private void loadData() {
		settings = SettingUtils.getRadarSettingsWithDefaultValue(this);
		updateViews();
	}

	private void updateViews() {
		if (settings == null) {
			return;
		}

		JSONObject value = SettingUtils.parseSettingValue(settings);
		if (value == null) {
			value = SettingUtils.getDefaultRadarValue();
		}

		try {
			numberPicker.setValue(value.getInt(RADAR_VAL_FIELD_DISTANCE));
			saleCheck.setChecked(value.getBoolean(RADAR_VAL_FIELD_SALE));
			shopCheck.setChecked(value.getBoolean(RADAR_VAL_FIELD_SHOP));
			friendCheck.setChecked(value.getBoolean(RADAR_VAL_FIELD_FRIEND));
		} catch (JSONException e) {
			Logger.warn(TAG, e.getMessage(), e);
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			saveSetting(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void saveSetting(final MenuItem item) {
		if (!saleCheck.isChecked() && !shopCheck.isChecked()
				&& !friendCheck.isChecked()) {
			ViewUtils.showToast("请至少选择一个扫描对象.");
			return;
		}

		numberPicker.clearFocus();
		JSONObject obj = new JSONObject();
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_DISTANCE,
				numberPicker.getValue());
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_SALE, saleCheck.isChecked());
		JSONUtils.putJSONValue(obj, RADAR_VAL_FIELD_SHOP, shopCheck.isChecked());
		JSONUtils
				.putJSONValue(obj, RADAR_VAL_FIELD_FRIEND, friendCheck.isChecked());

		settings.setValue(obj.toString());

		item.setEnabled(false);
		AsyncTask<Void, Void, Integer> task = new AsyncTask<Void, Void, Integer>() {

			@Override
			protected Integer doInBackground(Void... params) {
				return new SettingData(RadarSettingActivity.this).saveSettingValue(
						settings.getUuid(), settings.getValue());
			}

			@Override
			protected void onPostExecute(Integer result) {
				item.setEnabled(true);
				if (result > 0) {
					ViewUtils.showToast("设置成功.");
				}
			}

			@Override
			protected void onCancelled() {
				item.setEnabled(true);
			}
		};

		task.execute((Void) null);
	}

}
