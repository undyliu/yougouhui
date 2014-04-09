package com.seekon.yougouhui.activity.profile.shop;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.contact.ContactListActivity;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEmpProcessor;
import com.seekon.yougouhui.func.profile.shop.widget.ShopEmpListAdapter;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.ViewUtils;

public class EmpSettingActivity extends Activity{
	
	private static final int ADD_EMP_REQUEST_CODE = 1;
	
	private String shopId;
	
	private ShopEmpListAdapter shopEmpListAdapter;
	
	private List<UserEntity> empList = new ArrayList<UserEntity>();
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.shop_emp_setting);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		shopId = this.getIntent().getStringExtra(ShopConst.COL_NAME_UUID);
		
		shopEmpListAdapter = new ShopEmpListAdapter(empList, this);
		ListView empListView = (ListView) findViewById(R.id.shop_emp_list);
		empListView.setAdapter(shopEmpListAdapter);
		empListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				
			}
		});
		
		loadShopEmpsData();
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_emp_setting, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;
		case R.id.menu_add_emp:
			addEmp();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
	
	private void addEmp(){
		Intent intent = new Intent(this, ContactListActivity.class);
		intent.putExtra(ShareConst.COL_NAME_UUID, shopId);
		startActivityForResult(intent, ADD_EMP_REQUEST_CODE);
	}
	
	private void loadShopEmpsData(){
		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>>(){

			@Override
			protected RestMethodResult<JSONArrayResource> doInBackground(
					Void... params) {
				return ShopEmpProcessor.getInstance(EmpSettingActivity.this).getShopEmps(shopId);
			}
			
			@Override
			protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
				int status = result.getStatusCode();
				if(status == 200){
					shopEmpListAdapter.updateEmpList(empList);
				}else{
					ViewUtils.showToast("获取商铺职员信息失败.");
				}
			}
			
		};
		
		task.execute((Void)null);
	}
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case ADD_EMP_REQUEST_CODE:
			if(resultCode == RESULT_OK && data != null){
				
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
