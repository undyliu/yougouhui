package com.seekon.yougouhui.activity.profile;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.NAME_COUNT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_DATE;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.MenuItem;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareData;
import com.seekon.yougouhui.func.profile.widget.MyShareListAdapter;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.util.DateUtils;

/**
 * 我的分享
 * 
 * @author undyliu
 * 
 */
public class MyShareActivity extends Activity implements IXListViewListener {

	public static final int SHARE_DETAIL_REQUEST_RESULT_CODE = 1;
	
	private String userId = null;

	private ShareData shareData = null;

	private List<Map<String, ?>> shareList = new ArrayList<Map<String, ?>>();

	private int currentOffset = 0;// 分页用的当前的数据偏移

	private XListView shareListView = null;

	private MyShareListAdapter listAdapter = null;

	private Handler mHandler;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.my_share);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		Intent intent = this.getIntent();
		userId = intent.getExtras().getString(COL_NAME_UUID);
		
		mHandler = new Handler();
		
		shareData = new ShareData(this);
		this.initShareListData();

		shareListView = (XListView) findViewById(R.id.my_share_list);
		shareListView.setPullLoadEnable(true);
		shareListView.setXListViewListener(this);
		
		listAdapter = new MyShareListAdapter(this, shareList,
				R.layout.my_share_item, new String[] {}, new int[] {
						});
		shareListView.setAdapter(listAdapter);
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

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case SHARE_DETAIL_REQUEST_RESULT_CODE:
			if(resultCode == RESULT_OK){
				
			}
			break;
		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
	
	private void initShareListData() {
		String limitSql = " limit " + Const.PAGE_SIZE + " offset " + currentOffset;
		List<Map<String, ?>> shareCountList = shareData.getShareCountByPublishDate(
				userId, limitSql);
		for (Map shareCount : shareCountList) {
			String publishDate = (String) shareCount.get(COL_NAME_PUBLISH_DATE);
			shareCount.put(ShareConst.DATA_SHARE_KEY,
					shareData.getShareListByPublishDate(publishDate, userId));
		}
		shareList.addAll(shareCountList);
	}

	protected void updateListView() {
		listAdapter.notifyDataSetChanged();
		onPostLoad();
	}

	private void onPostLoad() {
		shareListView.stopRefresh();
		shareListView.stopLoadMore();
//		if (lastUpdateTime != null) {
//			try {
//				shareListView.setRefreshTime(DateUtils.formartTime(Long
//						.valueOf(lastUpdateTime)));
//			} catch (Exception e) {
//			}
//		}
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				//initRequestId();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				//shares.addAll(getBackShareListFromLocal());
				updateListView();
			}
		}, 2000);
	}
}
