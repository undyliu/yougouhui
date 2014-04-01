package com.seekon.yougouhui.activity.user;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import com.seekon.yougouhui.R;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

/**
 * 朋友概况信息
 * @author undyliu
 *
 */
public class FriendProfileActivity extends Activity{
	
	private String userId = null;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.friend_profile);
		
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
		
		Intent intent = this.getIntent();
		userId = intent.getStringExtra(COL_NAME_UUID);
		
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
}
