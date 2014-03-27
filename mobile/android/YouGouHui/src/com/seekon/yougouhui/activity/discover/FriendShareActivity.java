package com.seekon.yougouhui.activity.discover;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;
import static com.seekon.yougouhui.func.discover.share.ShareImgConst.COL_NAME_SHARE_ID;
import static com.seekon.yougouhui.func.login.UserHelper.COL_NAME_PHONE;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.ActionBar;
import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.RequestListActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareImgConst;
import com.seekon.yougouhui.func.discover.share.ShareServiceHelper;
import com.seekon.yougouhui.func.update.UpdateData;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.widget.ShareListAdapter;

/**
 * 朋友圈 activity
 * 
 * @author undyliu
 * 
 */
public class FriendShareActivity extends RequestListActivity implements
		IXListViewListener {

	private static final int SHARE_ACTIVITY_REQUEST_CODE = 100;

	private List<Map<String, ?>> shares = new ArrayList<Map<String, ?>>();

	private XListView shareListView = null;

	private ShareListAdapter listAdapter = null;

	private Handler mHandler;

	private UpdateData updateData = null;

	private int currentOffset = 0;// 分页用的当前的数据偏移

	private String lastPublishTime = null;// 数据中分享记录最新发布的时间

	private String lastUpdateTime = null;

	public FriendShareActivity() {
		super(ShareServiceHelper.SHARE_GET_REQUEST_RESULT);
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.discover_friends);

		shareListView = (XListView) findViewById(R.id.freind_share_list);
		shareListView.setPullLoadEnable(true);
		shareListView.setXListViewListener(this);

		listAdapter = new ShareListAdapter(this, shareListView, shares,
				R.layout.discover_friends_item, new String[] { COL_NAME_PHONE,
						COL_NAME_CONTENT },
				new int[] { R.id.user_name, R.id.share_content });
		shareListView.setAdapter(listAdapter);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		mHandler = new Handler();

		updateData = new UpdateData(this);

		lastPublishTime = this.getLastPublishTime();

		shares.addAll(this.getBackShareListFromLocal());
		updateListView();
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
			this.onRefresh();
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void openShareActivity() {
		Intent share = new Intent(this, ShareActivity.class);
		startActivityForResult(share, SHARE_ACTIVITY_REQUEST_CODE);
	}

	@Override
	protected void initRequestId() {
		requestId = ShareServiceHelper.getInstance(FriendShareActivity.this)
				.getShares(lastPublishTime, requestResultType);
	}

	private String getLastPublishTime() {
		String result = null;
		String col = " max(" + COL_NAME_PUBLISH_TIME + ")";
		Cursor cursor = getContentResolver().query(ShareConst.CONTENT_URI,
				new String[] { col }, null, null, null);
		if (cursor.moveToNext()) {
			result =  cursor.getString(0);
		} 
		cursor.close();
		
		if(result == null){
			result =  updateData.getUpdateTime(ShareConst.TABLE_NAME);
		}
		return result;
	}

	/**
	 * 获取最新的更新数据
	 */
	private List<Map<String, ?>> getHeadShareListFromLocal() {
		List<Map<String, ?>> result = null;
		if (lastPublishTime == null) {// 没有记录
			result = getBackShareListFromLocal();
			lastPublishTime = this.getLastPublishTime();
		} else {
			String selection = COL_NAME_PUBLISH_TIME + " > ? ";
			String[] selectionArgs = new String[] { lastPublishTime + "" };
			String limitSql = "";
			result = this.getShareListFromLocal(selection, selectionArgs, limitSql);
			lastPublishTime = this.getLastPublishTime();
		}
		return result;
	}

	/**
	 * 根据偏移获取偏移位置之后的数据
	 */
	private List<Map<String, ?>> getBackShareListFromLocal() {
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		return getShareListFromLocal(null, null, limitSql);
	}

	public List<Map<String, ?>> getShareListFromLocal(String selection,
			String[] selectionArgs, String limitSql) {
		List<Map<String, ?>> result = new ArrayList<Map<String, ?>>();
		ContentValues user = RunEnv.getInstance().getUser();
		Cursor cursor = getContentResolver()
				.query(
						ShareConst.CONTENT_URI,
						new String[] { COL_NAME_UUID, COL_NAME_CONTENT,
								COL_NAME_PUBLISH_TIME }, selection, selectionArgs,
						COL_NAME_PUBLISH_TIME + " desc " + limitSql);
		while (cursor.moveToNext()) {
			String uuid = cursor.getString(0);

			Map values = new HashMap();
			values.put(COL_NAME_UUID, uuid);
			values.put(COL_NAME_CONTENT, cursor.getString(1));
			values.put(COL_NAME_PUBLISH_TIME, cursor.getString(2));
			values.put(COL_NAME_PHONE, user.get(COL_NAME_PHONE));

			values.put(ShareConst.DATA_IMAGE_KEY, getShareImagesFromLocal(uuid));
			values.put(ShareConst.DATA_COMMENT_KEY, getCommentsFromLocal(uuid));

			currentOffset++;

			result.add(values);
		}
		cursor.close();
		return result;
	}

	private List<String> getShareImagesFromLocal(String shareId) {
		List<String> imageUrls = new ArrayList<String>();
		Cursor cursor = getContentResolver().query(ShareImgConst.CONTENT_URI,
				new String[] { COL_NAME_IMG }, COL_NAME_SHARE_ID + "=?",
				new String[] { shareId }, COL_NAME_ORD_INDEX);
		while (cursor.moveToNext()) {
			String image = cursor.getString(0);
			if (image == null || image.trim().length() == 0) {
				continue;
			}
			imageUrls.add(image);
		}
		cursor.close();
		return imageUrls;
	}

	private List<Map<String, ?>> getCommentsFromLocal(String shareId) {
		List<Map<String, ?>> commentList = new ArrayList<Map<String, ?>>();
		Cursor cursor = getContentResolver().query(CommentConst.CONTENT_URI,
				new String[] { COL_NAME_CONTENT, COL_NAME_PUBLISHER },
				COL_NAME_SHARE_ID + "=?", new String[] { shareId },
				COL_NAME_PUBLISH_TIME);
		while (cursor.moveToNext()) {
			Map<String, String> row = new HashMap<String, String>();
			row.put(COL_NAME_CONTENT, cursor.getString(1) + ":" + cursor.getString(0));
			row.put(COL_NAME_PUBLISHER, cursor.getString(1));
			commentList.add(row);
		}
		cursor.close();
		return commentList;
	}

	@Override
	protected void updateListItemByRemoteCall() {
		lastUpdateTime = String.valueOf(System.currentTimeMillis());
		if (lastPublishTime == null) {
			lastPublishTime = lastUpdateTime;
		}
		updateData.updateData(ShareConst.TABLE_NAME, lastUpdateTime);

		shares.addAll(0, this.getHeadShareListFromLocal());
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
				initRequestId();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				shares.addAll(getBackShareListFromLocal());
				updateListView();
			}
		}, 2000);
	}

}
