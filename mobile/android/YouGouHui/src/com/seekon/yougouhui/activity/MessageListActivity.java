package com.seekon.yougouhui.activity;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.mess.MessageConst.COL_NAME_CHANNEL_ID;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.widget.ImageListRemoteAdapter;

/**
 * 活动消息列表
 * 
 * @author undyliu
 * 
 */
public class MessageListActivity extends RequestListActivity {

	private ContentValues channel = null;

	private List<Map<String, ?>> messages = new LinkedList<Map<String, ?>>();

	public MessageListActivity() {
		super(MessageServiceHelper.MESSAGE_REQUEST_RESULT);
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		channel = getIntent().getParcelableExtra(ChannelConst.CHANNEL_DATA_KEY);
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		ContentValues message = ContentValuesUtils.fromMap(messages.get(position), null);
		Intent messageIntent = new Intent(this, MessageActivity.class);
		messageIntent.putExtra(MessageConst.MESSAGE_DATA_KEY, message);
		startActivity(messageIntent);
	}
	
	@Override
	protected void initRequestId() {
		AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
			@Override
			protected Long doInBackground(Void... params) {
				requestId =  MessageServiceHelper.getInstance(MessageListActivity.this)
						.getMessages(channel.getAsString(COL_NAME_UUID), requestResultType);
				return requestId;
			}

		};
		task.execute((Void) null);
	}

	@Override
	protected List<Map<String, ?>> getListItemsFromLocal() {
		if (messages.size() == 0) {
			String channelId = channel.getAsString(COL_NAME_UUID);
			String selection = null;
			String[] selectionArgs = null;
			if (!"0".equals(channelId)) {// 全部
				selection = COL_NAME_CHANNEL_ID + "= ? ";
				selectionArgs = new String[] { channelId };
			}
			Cursor cursor = getContentResolver().query(
					MessageConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_IMG, COL_NAME_TITLE,
							COL_NAME_CONTENT }, selection, selectionArgs, null);
			while (cursor.moveToNext()) {
				Map values = new HashMap();
				values.put(COL_NAME_UUID, cursor.getInt(0));
				values.put(COL_NAME_IMG, cursor.getString(1));
				values.put(COL_NAME_TITLE, cursor.getString(2));
				values.put(COL_NAME_CONTENT, cursor.getString(3));
				messages.add(values);
			}
			cursor.close();
		}
		return messages;
	}
	
	@Override
	protected void updateListView(List<Map<String, ?>> data) {
		this.setListAdapter(new ImageListRemoteAdapter(this, messages,
				R.layout.message_list, new String[] { COL_NAME_TITLE },
				new int[] { R.id.title }));
	}
}
