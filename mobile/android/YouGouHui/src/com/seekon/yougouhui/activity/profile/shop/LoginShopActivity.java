package com.seekon.yougouhui.activity.profile.shop;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;

import com.seekon.yougouhui.R;

/**
 * 登录商铺
 * 
 * @author undyliu
 * 
 */
public class LoginShopActivity extends Activity {

	private static final int REGISTER_REQUEST_CODE = 1;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_login);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		initViews();
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
	
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case REGISTER_REQUEST_CODE:
			if(resultCode == RESULT_OK && data != null){
				
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	private void initViews(){
		Button bRegister = (Button) findViewById(R.id.b_register);
		bRegister.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(LoginShopActivity.this, RegisterShopActivity.class);
				startActivityForResult(intent, REGISTER_REQUEST_CODE);
			}
		});
	}

}
