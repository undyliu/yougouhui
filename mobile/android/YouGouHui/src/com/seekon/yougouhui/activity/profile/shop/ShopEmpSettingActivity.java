package com.seekon.yougouhui.activity.profile.shop;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.contact.ContactListWithCheckedActivity;
import com.seekon.yougouhui.func.profile.contact.FriendConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEmpProcessor;
import com.seekon.yougouhui.func.profile.shop.widget.ShopEmpListAdapter;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class ShopEmpSettingActivity extends Activity implements
		OnCheckedChangeListener {

	private static final String TAG = ShopEmpSettingActivity.class
			.getSimpleName();

	private static final int ADD_EMP_REQUEST_CODE = 1;

	private static final int SET_EMP_PWD_REQUEST_CODE = 2;

	private String shopId;

	private String ownerId;

	private ShopEmpListAdapter shopEmpListAdapter;

	private List<UserEntity> empList = new ArrayList<UserEntity>();

	private List<UserEntity> checkedEmpList = new ArrayList<UserEntity>();

	private AlertDialog.Builder setPwdConfirm = null;

	private Menu menu;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_emp_setting);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		shopId = this.getIntent().getStringExtra(ShopConst.COL_NAME_UUID);
		ownerId = this.getIntent().getStringExtra(ShopConst.COL_NAME_OWNER);

		initViews();
		loadShopEmpsData();
	}

	private void initViews() {
		ListView empListView = (ListView) findViewById(R.id.shop_emp_list);
		empListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				final UserEntity emp = empList.get(position);
				if (emp.getUuid().equals(ownerId)) {
					ViewUtils.showToast("店主的密码请到商铺基本信息中去修改.");
					return;
				}
				String pwd = emp.getPwd();
				if (pwd != null && pwd.length() > 0) {
					setPwdConfirm
							.setPositiveButton("是", new DialogInterface.OnClickListener() {
								@Override
								public void onClick(DialogInterface dialog, int which) {
									startSetEmpPwdActivity(emp);
								}
							}).setNegativeButton("否", new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface dialog, int which) {
									dialog.cancel();
								}
							}).show();
				} else {
					startSetEmpPwdActivity(emp);
				}
			}
		});

		setPwdConfirm = new AlertDialog.Builder(this);
		setPwdConfirm.setTitle("设置密码确认");
		setPwdConfirm.setMessage("此职员已经设置了密码，是否重新设置？");

		shopEmpListAdapter = new ShopEmpListAdapter(empList, this, this, ownerId);
		empListView.setAdapter(shopEmpListAdapter);
	}

	private void startSetEmpPwdActivity(UserEntity emp) {
		Intent intent = new Intent(ShopEmpSettingActivity.this,
				SetEmpPwdActivity.class);
		intent.putExtra(UserConst.DATA_KEY_USER, emp);
		intent.putExtra(ShopConst.COL_NAME_UUID, shopId);
		startActivityForResult(intent, SET_EMP_PWD_REQUEST_CODE);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_emp_setting, menu);
		this.menu = menu;
		menu.findItem(R.id.menu_shop_del_emp).setEnabled(false);

		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;
		case R.id.menu_shop_add_emp:
			addEmps();
			break;
		case R.id.menu_shop_del_emp:
			deleteEmps();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void addEmps() {
		Intent intent = new Intent(this, ContactListWithCheckedActivity.class);
		intent.putExtra(FriendConst.DATA_SELECTED_USER_LIST_KEY,
				(ArrayList<UserEntity>) empList);
		startActivityForResult(intent, ADD_EMP_REQUEST_CODE);
	}

	private void deleteEmps() {
		final MenuItem addEmp = menu.findItem(R.id.menu_shop_add_emp);
		final MenuItem delEmp = menu.findItem(R.id.menu_shop_del_emp);
		if (checkedEmpList.isEmpty()) {
			ViewUtils.showToast("请选择人员.");
		}

		addEmp.setEnabled(false);
		delEmp.setEnabled(false);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"删除职员失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopEmpProcessor.getInstance(ShopEmpSettingActivity.this)
								.deleteShopEmps(shopId, checkedEmpList);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						empList.removeAll(checkedEmpList);
						shopEmpListAdapter.updateEmpList(empList);
						onCancelled();
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						onCancelled();
					}

					@Override
					public void onCancelled() {
						addEmp.setEnabled(true);
						delEmp.setEnabled(true);
						super.onCancelled();
					}
				});
	}

	private void loadShopEmpsData() {

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>(
						"获取商铺职员信息失败.") {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return ShopEmpProcessor.getInstance(ShopEmpSettingActivity.this)
								.getShopEmps(shopId);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						try {
							empList.clear();
							JSONArrayResource resource = result.getResource();
							for (int i = 0; i < resource.length(); i++) {
								empList.add(UserUtils.createFromJSONObject(resource
										.getJSONObject(i)));
							}
							shopEmpListAdapter.updateEmpList(empList);
						} catch (Exception e) {
							Logger.warn(TAG, e.getMessage());
							ViewUtils.showToast(failedShowMsg
									+ "原因:"
									+ ShopEmpSettingActivity.this
											.getString(R.string.runtime_error));
						}
					}
				});
	}

	private void addEmpsResult(final List<UserEntity> selectedUserList) {
		final MenuItem addEmp = menu.findItem(R.id.menu_shop_add_emp);
		final MenuItem delEmp = menu.findItem(R.id.menu_shop_del_emp);

		addEmp.setEnabled(false);
		delEmp.setEnabled(false);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"添加职员失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopEmpProcessor.getInstance(ShopEmpSettingActivity.this)
								.addShopEmps(shopId, selectedUserList);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						empList.addAll(selectedUserList);
						shopEmpListAdapter.updateEmpList(empList);
						onCancelled();
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						onCancelled();
					}

					@Override
					public void onCancelled() {
						addEmp.setEnabled(true);
						delEmp.setEnabled(true);
						super.onCancelled();
					}
				});
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case ADD_EMP_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				List<UserEntity> selectedUserList = (List<UserEntity>) data
						.getSerializableExtra(FriendConst.DATA_SELECTED_USER_LIST_KEY);
				if (selectedUserList.size() > 0) {
					addEmpsResult(selectedUserList);
				}
			}
			break;
		case SET_EMP_PWD_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				UserEntity emp = (UserEntity) data
						.getSerializableExtra(UserConst.DATA_KEY_USER);
				for (UserEntity user : empList) {
					if (user.equals(emp)) {
						user.setPwd(emp.getPwd());
						break;
					}
				}
				shopEmpListAdapter.updateEmpList(empList);
			}
			break;
		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
		int id = buttonView.getId();
		if (isChecked) {
			checkedEmpList.add(empList.get(id));
		} else {
			checkedEmpList.remove(empList.get(id));
		}

		MenuItem item = menu.findItem(R.id.menu_shop_del_emp);
		if (checkedEmpList.isEmpty()) {
			item.setEnabled(false);
		} else {
			item.setEnabled(true);
		}
	}

}
