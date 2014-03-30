package com.seekon.yougouhui.activity;

import com.seekon.yougouhui.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

/**
 * 与微博等进行集成登录
 * @author undyliu
 *
 */
public class SSOActivity extends Activity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.sso);
		init();
	}
	
	private void init(){
		Button loginOrRegister = (Button) findViewById(R.id.b_login_or_register);
		loginOrRegister.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(SSOActivity.this, LoginActivity.class);
				startActivity(intent);
			}
		});
	}
}
