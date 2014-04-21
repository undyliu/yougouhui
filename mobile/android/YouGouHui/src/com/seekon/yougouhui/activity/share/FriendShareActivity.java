package com.seekon.yougouhui.activity.share;

import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.os.Handler;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.CommentConst;
import com.seekon.yougouhui.func.share.CommentData;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.share.widget.ShareListAdapter;
import com.seekon.yougouhui.func.share.widget.ShareUtils;
import com.seekon.yougouhui.func.update.UpdateData;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.DateUtils;

/**
 * 朋友圈 activity
 * 
 * @author undyliu
 * 
 */
public class FriendShareActivity extends Activity implements IXListViewListener {

	private static final int SHARE_ACTIVITY_REQUEST_CODE = 100;

	private List<ShareEntity> shares = new ArrayList<ShareEntity>();

	private XListView shareListView = null;

	private ShareListAdapter listAdapter = null;

	private Handler mHandler;

	private UpdateData updateData = null;

	private ShareData shareData = null;

	private CommentData commentData = null;

	private int currentOffset = 0;// 分页用的当前的数据偏移

	private String lastPublishTime = null;// 数据中分享记录最新发布的时间

	private String lastUpdateTime = null;// 分享数据最新的更新时间，用于更新新增加的分享和评论数据

	private String minPublishTime = null;// 数据中分享记录最小的发布时间, 用于获取已经删除了的分享和评论数据

	private String lastCommentPublishTime = null;

	private String minCommentPublishTime = null;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.base_xlistview);

		initViews();

		if (shares.isEmpty()) {
			loadShareListData();
		}
	}

	private void initViews() {
		shareListView = (XListView) findViewById(R.id.listview_main);
		shareListView.setPullLoadEnable(true);
		shareListView.setXListViewListener(this);

		listAdapter = new ShareListAdapter(this, shares);
		shareListView.setAdapter(listAdapter);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		mHandler = new Handler();

		updateData = new UpdateData(this);
		shareData = new ShareData(this);
		commentData = new CommentData(this);

		lastPublishTime = this.getLastPublishTime();
		lastUpdateTime = updateData.getUpdateTime(ShareConst.TABLE_NAME);
		minPublishTime = this.getMinPublishTime();

		lastCommentPublishTime = this.getLastCommentPublishTime();
		minCommentPublishTime = this.getMinCommentPublishTime();
	}

	private void loadShareListData() {
		shares.addAll(getShareListFromLocal());
		if (shares.isEmpty()) {
			loadShareDataFromRemote();
		} else {
			this.updateListView();
		}
	}

	private void loadShareDataFromRemote() {
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return ShareProcessor.getInstance(FriendShareActivity.this)
								.getShares(lastPublishTime, minPublishTime,
										lastCommentPublishTime, minCommentPublishTime);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						updateListItemByRemoteCall();
					}
				});
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
			// TODO:增加刷新的进度显示
			this.onRefresh();
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void openShareActivity() {
		Intent share = new Intent(this, ShareActivity.class);
		startActivityForResult(share, SHARE_ACTIVITY_REQUEST_CODE);
	}

	private String getLastPublishTime() {
		String result = null;
		String col = " max(" + COL_NAME_PUBLISH_TIME + ")";
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(ShareConst.CONTENT_URI,
					new String[] { col }, null, null, null);
			if (cursor.moveToNext()) {
				result = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		if (result == null) {
			result = RunEnv.getInstance().getUser().getRegisterTime();// updateData.getUpdateTime(ShareConst.TABLE_NAME);
		}
		return result;
	}

	private String getMinPublishTime() {
		String result = null;
		String col = " min(" + COL_NAME_PUBLISH_TIME + ")";
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(ShareConst.CONTENT_URI,
					new String[] { col }, null, null, null);
			if (cursor.moveToNext()) {
				result = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		return result;
	}

	private String getMinCommentPublishTime() {
		String result = null;
		String col = " min(" + COL_NAME_PUBLISH_TIME + ")";
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(CommentConst.CONTENT_URI,
					new String[] { col }, null, null, null);
			if (cursor.moveToNext()) {
				result = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		return result;
	}

	private String getLastCommentPublishTime() {
		String result = null;
		String col = " max(" + COL_NAME_PUBLISH_TIME + ")";
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(CommentConst.CONTENT_URI,
					new String[] { col }, null, null, null);
			if (cursor.moveToNext()) {
				result = cursor.getString(0);
			}
		} finally {
			cursor.close();
		}
		if (result == null) {
			result = RunEnv.getInstance().getUser().getRegisterTime();// updateData.getUpdateTime(CommentConst.TABLE_NAME);
		}
		return result;
	}

	private List<ShareEntity> getShareListFromLocal() {
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		List<ShareEntity> result = shareData.getShareData(limitSql);
		for (ShareEntity share : result) {
			share
					.setImages(ShareUtils.getShareImagesFromLocal(this, share.getUuid()));
			share.setComments(getCommentsFromLocal(share.getUuid()));
		}
		currentOffset += result.size();
		return result;
	}

	private List<CommentEntity> getCommentsFromLocal(String shareId) {
		return commentData.getCommentData(shareId);
	}

	protected void updateListItemByRemoteCall() {
		lastUpdateTime = String.valueOf(System.currentTimeMillis());
		lastPublishTime = this.getLastPublishTime();
		if (lastPublishTime == null) {
			lastPublishTime = lastUpdateTime;
		}
		minPublishTime = this.getMinPublishTime();

		lastCommentPublishTime = this.getLastCommentPublishTime();
		minCommentPublishTime = this.getMinCommentPublishTime();

		updateData.updateData(ShareConst.TABLE_NAME, lastUpdateTime);
		updateData.updateData(CommentConst.TABLE_NAME, lastUpdateTime);

		this.currentOffset = 0;
		shares.clear();
		shares.addAll(this.getShareListFromLocal());

		updateListView();
	}

	protected void updateListView() {
		listAdapter.notifyDataSetChanged();
		onPostLoad();
	}

	private void onPostLoad() {
		shareListView.stopRefresh();
		shareListView.stopLoadMore();
		if (lastUpdateTime != null) {
			try {
				shareListView.setRefreshTime(DateUtils.formartTime(Long
						.valueOf(lastUpdateTime)));
			} catch (Exception e) {
			}
		}
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				loadShareDataFromRemote();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				shares.addAll(getShareListFromLocal());
				updateListView();
			}
		}, 2000);
	}

	public ShareListAdapter getShareListAdapter() {
		return this.listAdapter;
	}

	public List<ShareEntity> getShares() {
		return shares;
	}
}
