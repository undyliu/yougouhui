package com.seekon.yougouhui.activity.profile.shop;

import java.util.List;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.widget.ShopChooseAdapter;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

public class ShopMainActivity extends Activity{

	private List<ShopEntity> shopList = null;
	
	private ShopEntity currentShop = null;
	
	private TextView statusView;
	
	private ImageView baseInfoImageView;
	private ImageView empSettingImageView;
	private ImageView saleImageView;
	private ImageView shareImageView;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.shop_main);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		Intent intent = this.getIntent();
		shopList = (List<ShopEntity>) intent.getExtras().get(ShopConst.NAME_SHOP_LIST);
		
		initViews();
	}
	
	private void initViews(){
		Spinner spinner = (Spinner) findViewById(R.id.shop_choose);
		spinner.setAdapter(new ShopChooseAdapter(this, shopList));
		spinner.setOnItemSelectedListener(new ShopItemSelectedListener());
		
		statusView = (TextView) findViewById(R.id.shop_status);
		
		baseInfoImageView = (ImageView) findViewById(R.id.img_shop_base_info);
		baseInfoImageView.setOnClickListener(new View.OnClickListener() {		
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ShopMainActivity.this, BaseInfoActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, currentShop.getUuid());
				startActivity(intent);
			}
		});
		
		empSettingImageView = (ImageView) findViewById(R.id.img_shop_emp_setting);
		empSettingImageView.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ShopMainActivity.this, EmpSettingActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, currentShop.getUuid());
				startActivity(intent);
			}
		});
		
		saleImageView = (ImageView) findViewById(R.id.img_shop_sale_info);
		saleImageView.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ShopMainActivity.this, SaleInfoActivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, currentShop.getUuid());
				startActivity(intent);
			}
		});
		
		shareImageView = (ImageView) findViewById(R.id.img_shop_share_interact);
		shareImageView.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ShopMainActivity.this, ShareInteractAcitivity.class);
				intent.putExtra(DataConst.COL_NAME_UUID, currentShop.getUuid());
				startActivity(intent);
			}
		});
	}
	
	private void updateViews(){
		empSettingImageView.setEnabled(true);
		saleImageView.setEnabled(true);
		shareImageView.setEnabled(true);
		
		String status = currentShop.getStatus();
		if(status.equals("0")){
			statusView.setText(R.string.label_shop_status_registered);
			empSettingImageView.setEnabled(false);
			saleImageView.setEnabled(false);
			shareImageView.setEnabled(false);
		}else if(status.equals("1")){
			statusView.setText(R.string.label_shop_status_audited);
		}else if(status.equals("2")){
			statusView.setText(R.string.label_shop_status_canceled);
		}
		
		String owner = currentShop.getOwner();
		if(!owner.equals(RunEnv.getInstance().getUser().getUuid())){
			empSettingImageView.setEnabled(false);
		}
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			logout();
			break;

		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
	
	private void logout(){
		this.finish();
	}
	
	class ShopItemSelectedListener implements OnItemSelectedListener{

		@Override
		public void onItemSelected(AdapterView<?> arg0, View arg1, int position,
				long arg3) {
			currentShop = shopList.get(position);
			updateViews();
		}

		@Override
		public void onNothingSelected(AdapterView<?> arg0) {
			
		}
		
	}
}
