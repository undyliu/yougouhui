package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TYPE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.module.ModuleServiceHelper;
import com.seekon.yougouhui.util.RUtils;

@SuppressLint("ValidFragment")
public class ModuleListFragment extends RequestListFragment {

	private String type;

	protected List<Map<String, ?>> modules = new LinkedList<Map<String, ?>>();

	public ModuleListFragment(String requestResultType, String type) {
		super(requestResultType);
		this.type = type;
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		attachedActivity.getActionBar().setNavigationMode(
				ActionBar.NAVIGATION_MODE_STANDARD);
		return inflater.inflate(R.layout.module_list, container, false);
	}

	@Override
	protected void initRequestId() {
		AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
			@Override
			protected Long doInBackground(Void... params) {
				return ModuleServiceHelper.getInstance(attachedActivity).getModules(
						type, requestResultType);
			}

			@Override
			protected void onPostExecute(Long result) {
				requestId = result;
			}
		};
		task.execute((Void) null);
	}

	@Override
	protected List<Map<String, ?>> getListItemsFromLocal() {
		if (modules.size() == 0) {
			Cursor cursor = attachedActivity.getContentResolver().query(
					ModuleConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME },
					COL_NAME_TYPE + "= ? ", new String[] { type }, COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				Map values = new HashMap();
				String code = cursor.getString(1);
				int img = RUtils.getDrawableImg(code);
				if (img == -1) {
					img = R.drawable.default_module;
				}
				values.put(COL_NAME_UUID, cursor.getInt(0));
				values.put(COL_NAME_CODE, code);
				values.put(COL_NAME_NAME, cursor.getString(2));
				values.put(COL_NAME_IMG, img);
				modules.add(values);
			}
			cursor.close();
		}
		return modules;
	}

	@Override
	protected void updateListView(List<Map<String, ?>> data) {
		SimpleAdapter adapter = new SimpleAdapter(attachedActivity, modules,
				R.layout.module_item, new String[] { COL_NAME_IMG, COL_NAME_NAME },
				new int[] { R.id.img, R.id.title });

		this.setListAdapter(adapter);
	}

	protected String getModuleCode(int position) {
		Map module = modules.get(position);
		return (String) module.get(COL_NAME_CODE);
	}
}
