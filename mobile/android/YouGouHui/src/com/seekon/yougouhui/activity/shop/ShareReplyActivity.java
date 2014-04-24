package com.seekon.yougouhui.activity.shop;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.widget.ShareUtils;

public class ShareReplyActivity extends Activity {
	private View mainView;
	private ShareEntity share;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.discover_friends_item);
		share = (ShareEntity) this.getIntent().getSerializableExtra(
				ShareConst.DATA_SHARE_KEY);

		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		mainView = findViewById(R.id.share_detail);
		ShareUtils.updateShopShareReplyView(share, this, mainView);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			back();
			break;

		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	public void updateView(ShareEntity share) {
		this.share = share;
		ShareUtils.updateShopShareReplyView(share, this, mainView);
	}
	
	private void back(){
		Intent intent = new Intent();
		intent.putExtra(ShareConst.DATA_SHARE_KEY, share);
		setResult(RESULT_OK, intent);
		finish();
	}
}
