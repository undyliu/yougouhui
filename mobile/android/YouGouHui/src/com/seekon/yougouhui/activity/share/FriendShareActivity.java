package com.seekon.yougouhui.activity.share;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.share.widget.ShareListAdapter;
import com.seekon.yougouhui.func.share.widget.ShareListView;

/**
 * 朋友圈 activity
 * 
 * @author undyliu
 * 
 */
public class FriendShareActivity extends Activity {

	private static final int SHARE_ACTIVITY_REQUEST_CODE = 100;

	private ShareListView shareListView = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.discover_friends_list);

		initViews();
		shareListView.loadData();
	}

	private void initViews() {
		shareListView = (ShareListView) findViewById(R.id.listview_main);
		shareListView.init();

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

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == SHARE_ACTIVITY_REQUEST_CODE && resultCode == RESULT_OK) {
			shareListView.loadData();
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void openShareActivity() {
		Intent share = new Intent(this, ShareActivity.class);
		startActivityForResult(share, SHARE_ACTIVITY_REQUEST_CODE);
	}

	public ShareListAdapter getShareListAdapter() {
		return (ShareListAdapter) shareListView.getEntityListAdapter();
	}
}
