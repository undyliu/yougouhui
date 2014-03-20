package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_PARENT_ID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;

@SuppressLint("ValidFragment")
public class SubChannelListFragment extends RequestListFragment {

	private ContentValues parentChannel = null;

	private List<Map<String, ?>> channels = new LinkedList<Map<String, ?>>();

	public SubChannelListFragment(ContentValues parentChannel) {
		super(MessageServiceHelper.SUBCHANNEL_REQUEST_RESULT);
		this.parentChannel = parentChannel;
	}

//	@Override
//	protected void onListItemClick(ListView l, View v, int position, long id) {
//		Logger.debug(TAG, (String) channels.get(position).get(COL_NAME_NAME));
//
//		Intent messageList = new Intent(attachedActivity, MessageListActivity.class);
//		messageList.putExtra(ChannelConst.CHANNEL_DATA_KEY,
//				ContentValuesUtils.fromMap(channels.get(position), null));
//		startActivity(messageList);
//	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		super.onCreateView(inflater, container, savedInstanceState);
		return inflater.inflate(R.layout.module_list, container, false);
	}
	
	@Override
	protected void initRequestId() {
		AsyncTask<Void, Void, Long> task = new AsyncTask<Void, Void, Long>() {
			@Override
			protected Long doInBackground(Void... params) {
				return MessageServiceHelper.getInstance(attachedActivity)
						.getChannels(parentChannel.getAsString(COL_NAME_UUID),
								MessageServiceHelper.SUBCHANNEL_REQUEST_RESULT);
			}

			@Override
			protected void onPostExecute(Long result) {
				requestId = result;
			}
		};
		task.execute((Void) null);
	}
	
	@Override
	protected List<Map<String, ?>> getListItemsFromLocal() {
		if (channels.size() == 0) {
			Cursor cursor = attachedActivity.getContentResolver().query(ChannelConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME },
					COL_NAME_PARENT_ID + "= ? ",
					new String[] { parentChannel.getAsString(COL_NAME_UUID) },
					COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				Map values = new HashMap();
				values.put(COL_NAME_UUID, cursor.getInt(0));
				values.put(COL_NAME_CODE, cursor.getString(1));
				values.put(COL_NAME_NAME, cursor.getString(2));
				channels.add(values);
			}
			cursor.close();
		}
		return channels;
	}
	
	@Override
	protected void updateListView(List<Map<String, ?>> data) {
		SimpleAdapter adapter = new SimpleAdapter(attachedActivity, channels,
				R.layout.sub_channel_list, new String[] { COL_NAME_NAME },
				new int[] { R.id.title });

		this.setListAdapter(adapter);
	}
}
