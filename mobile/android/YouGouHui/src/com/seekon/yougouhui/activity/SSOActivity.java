package com.seekon.yougouhui.activity;

import java.util.UUID;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.DeviceUtils;

/**
 * 与微博等进行集成登录
 * 
 * @author undyliu
 * 
 */
public class SSOActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.sso);
		init();
	}

	private void init() {
		Button loginOrRegister = (Button) findViewById(R.id.b_login_or_register);
		loginOrRegister.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(SSOActivity.this, LoginActivity.class);
				startActivity(intent);
			}
		});

		Button loginAnonymous = (Button) findViewById(R.id.b_login_anonymous);
		loginAnonymous.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				String phone = DeviceUtils.getTelephoneNumber();

				UserEntity user = new UserEntity();
				user.setUuid(UUID.randomUUID().toString());
				user.setPhone(phone);
				user.setName("匿名" + phone);
				user.setRegisterTime(String.valueOf(System.currentTimeMillis()));
				
				RunEnv.getInstance().setUser(user);
				
				Intent intent = new Intent(SSOActivity.this, MainActivity.class);
				startActivity(intent);
			}
		});
	}
}
