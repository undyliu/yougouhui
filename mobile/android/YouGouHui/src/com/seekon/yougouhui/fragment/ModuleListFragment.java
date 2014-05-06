package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TYPE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.LinkedList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.MainActivity;
import com.seekon.yougouhui.activity.user.RegisterActivity;
import com.seekon.yougouhui.func.module.ModuleConst;
import com.seekon.yougouhui.func.module.ModuleEntity;
import com.seekon.yougouhui.func.module.ModuleProcessor;
import com.seekon.yougouhui.func.module.widget.ModuleListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.RUtils;

public abstract class ModuleListFragment extends ListFragment {

	protected String type;

	protected Activity attachedActivity;

	protected List<ModuleEntity> modules = new LinkedList<ModuleEntity>();

	protected ModuleListAdapter moduleListAdapter;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		attachedActivity = this.getActivity();

		moduleListAdapter = new ModuleListAdapter(attachedActivity, modules);
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		attachedActivity.getActionBar().setNavigationMode(
				ActionBar.NAVIGATION_MODE_STANDARD);

		View view = inflater.inflate(R.layout.base_listview, container, false);
		updateViews();

		return view;
	}

	protected void updateViews() {
		this.setListAdapter(moduleListAdapter);
		if (modules.isEmpty()) {
			loadModuleList();
		}
	}

	private void loadModuleList() {
		loadModuleListFromLocal();
		if (modules.isEmpty()) {
			loadModuleListFromRemote();
		} else {
			moduleListAdapter.updateData(modules);
		}
	}

	private void loadModuleListFromLocal() {
		if (modules.size() == 0) {
			Cursor cursor = null;
			try {
				cursor = attachedActivity.getContentResolver().query(
						ModuleConst.CONTENT_URI,
						new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME },
						COL_NAME_TYPE + "= ? ", new String[] { type }, COL_NAME_ORD_INDEX);
				while (cursor.moveToNext()) {

					String code = cursor.getString(1);
					int img = RUtils.getDrawableImg(code);
					if (img == -1) {
						img = R.drawable.default_module;
					}

					modules.add(new ModuleEntity(cursor.getString(0), code, cursor
							.getString(2), img));
				}
			} finally {
				cursor.close();
			}
		}
	}

	private void loadModuleListFromRemote() {
		RestUtils.executeAsyncRestTask(attachedActivity,
				new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return ModuleProcessor.getInstance(attachedActivity).getModules(
								type);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						loadModuleListFromLocal();
						moduleListAdapter.updateData(modules);
					}
				});
	}

	protected String getModuleCode(int position) {
		ModuleEntity module = modules.get(position);
		return module.getCode();
	}

	protected void showRegisterUserConfirm(String message){
		AlertDialog.Builder registerConfirm = new AlertDialog.Builder(
				attachedActivity);
		registerConfirm.setTitle("会员注册提示");
		registerConfirm.setMessage(message);
		registerConfirm
				.setPositiveButton("是", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						Intent intent = new Intent(attachedActivity,
								RegisterActivity.class);
						attachedActivity.startActivityForResult(intent,
								MainActivity.REGISTER_USER_REQUEST_CODE);
					}
				}).setNegativeButton("否", new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						dialog.cancel();
					}
				}).show();
	}
}
