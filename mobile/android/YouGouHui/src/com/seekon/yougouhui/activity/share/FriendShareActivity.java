package com.seekon.yougouhui.activity.share;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.Menu;
import android.view.MenuItem;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.CommentData;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.share.widget.ShareListAdapter;
import com.seekon.yougouhui.func.share.widget.ShareUtils;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
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

	private SyncData updateData = null;

	private ShareData shareData = null;

	private CommentData commentData = null;

	private int currentOffset = 0;// 分页用的当前的数据偏移

	private String updateTime = null;// 数据中分享记录最新发布的时间

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

		updateData = new SyncData(this);
		shareData = new ShareData(this);
		commentData = new CommentData(this);

		updateTime = this.getUpdateTime();
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
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShareProcessor.getInstance(FriendShareActivity.this)
								.getShares(updateTime);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						currentOffset = 0;
						shares.clear();
						shares.addAll(getShareListFromLocal());

						updateListView();
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

	/**
	 * 获取分享数据的最近更新时间，若为null，则默认为用户的注册时间
	 * 
	 * @return
	 */
	private String getUpdateTime() {
		String result = updateData.getUpdateTime(ShareConst.TABLE_NAME);
		if (result == null) {
			result = RunEnv.getInstance().getUser().getRegisterTime();
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

	protected void updateListView() {
		listAdapter.notifyDataSetChanged();
		onPostLoad();
	}

	private void onPostLoad() {
		shareListView.stopRefresh();
		shareListView.stopLoadMore();
		if (updateTime != null) {
			try {
				shareListView.setRefreshTime(DateUtils.formartTime(Long
						.valueOf(updateTime)));
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
