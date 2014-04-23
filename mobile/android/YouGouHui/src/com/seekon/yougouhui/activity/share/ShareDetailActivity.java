package com.seekon.yougouhui.activity.share;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.share.CommentData;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.widget.ShareUtils;

/**
 * 分享详情
 * 
 * @author undyliu
 * 
 */
public class ShareDetailActivity extends Activity {

	private ShareEntity share = null;

	private ShareData shareData = null;

	private CommentData commentData = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.discover_friends_item);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		Intent intent = this.getIntent();
		String shareId = intent.getStringExtra(ShareConst.COL_NAME_SHARE_ID);

		shareData = new ShareData(this);
		commentData = new CommentData(this);

		loadShare(shareId);
		updateView();
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

	private void loadShare(String shareId) {
		share = shareData.getShareDataById(shareId);
		if (share == null) {
			return;
		}
		share.setImages(ShareUtils.getShareImagesFromLocal(this, shareId));
		share.setComments(commentData.getCommentData(shareId));
	}

	/**
	 * TODO:此方法从FriendShareActivity类中拷贝过来的，需进行重构
	 * 
	 * @param shareId
	 * @return
	 */

	private void updateView() {
		ShareUtils.updateUserShareDetailView(share, this,
				findViewById(R.id.share_detail));
	}
}
