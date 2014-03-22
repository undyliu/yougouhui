package com.seekon.yougouhui.activity.discover;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.R;

/**
 * 朋友圈 activity
 * 
 * @author undyliu
 * 
 */
public class FriendShareActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.discover_friends);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.discover_friends, menu);
		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_discover_friends_share:
			this.openShareActivity();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void openShareActivity(){
		Intent share = new Intent(this, ShareActivity.class);
		startActivity(share);
	}
}
