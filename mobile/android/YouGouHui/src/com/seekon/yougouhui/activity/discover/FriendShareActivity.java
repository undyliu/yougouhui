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
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.RequestListActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.CommentConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareImgConst;
import com.seekon.yougouhui.func.discover.share.ShareServiceHelper;
import com.seekon.yougouhui.widget.ShareListAdapter;

/**
 * 朋友圈 activity
 * 
 * @author undyliu
 * 
 */
public class FriendShareActivity extends RequestListActivity {

	private static final int SHARE_ACTIVITY_REQUEST_CODE = 100;

	private List<Map<String, ?>> shares = new ArrayList<Map<String, ?>>();

	private ListView shareListView = null;

	public FriendShareActivity() {
		super(ShareServiceHelper.SHARE_GET_REQUEST_RESULT);
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.discover_friends);

		shareListView = (ListView) findViewById(R.id.freind_share_list);

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
			String content = data.getExtras().getString(COL_NAME_CONTENT);
			List<String> imageNames = data.getExtras().getStringArrayList(
					ShareConst.DATA_IMAGE_KEY);
			ContentValues user = RunEnv.getInstance().getUser();

			Map values = new HashMap();

			values.put(COL_NAME_CONTENT, content);
			values.put(COL_NAME_PHONE, user.get(COL_NAME_PHONE));

			values.put(ShareConst.DATA_IMAGE_KEY, imageNames);
			values.put(ShareConst.DATA_COMMENT_KEY, new ArrayList());

			shares.add(0, values);

			SimpleAdapter adapter = (SimpleAdapter) shareListView.getAdapter();
			if (adapter != null) {
				adapter.notifyDataSetChanged();
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void openShareActivity() {
		Intent share = new Intent(this, ShareActivity.class);
		startActivityForResult(share, SHARE_ACTIVITY_REQUEST_CODE);
	}

	@Override
	protected void initRequestId() {
		AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
			@Override
			protected Long doInBackground(Void... params) {
				requestId = ShareServiceHelper.getInstance(FriendShareActivity.this)
						.getShares(requestResultType);
				return requestId;
			}

		};
		task.execute((Void) null);
	}

	@Override
	protected List<Map<String, ?>> getListItemsFromLocal() {
		ContentValues user = RunEnv.getInstance().getUser();
		if (shares.isEmpty()) {
			String selection = null;
			String[] selectionArgs = null;
			Cursor cursor = getContentResolver().query(ShareConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CONTENT }, selection,
					selectionArgs, COL_NAME_PUBLISH_TIME + " desc ");
			while (cursor.moveToNext()) {
				String uuid = cursor.getString(0);

				Map values = new HashMap();
				values.put(COL_NAME_UUID, uuid);
				values.put(COL_NAME_CONTENT, cursor.getString(1));
				values.put(COL_NAME_PHONE, user.get(COL_NAME_PHONE));

				values.put(ShareConst.DATA_IMAGE_KEY, getShareImagesFromLocal(uuid));
				values.put(ShareConst.DATA_COMMENT_KEY, getCommentsFromLocal(uuid));

				shares.add(values);
			}
			cursor.close();
		}
		return shares;
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
	protected void updateListView(List<Map<String, ?>> data) {
		shareListView.setAdapter(new ShareListAdapter(this, shareListView, data,
				R.layout.discover_friends_item, new String[] { COL_NAME_PHONE,
						COL_NAME_CONTENT },
				new int[] { R.id.user_name, R.id.share_content }));
	}

}
