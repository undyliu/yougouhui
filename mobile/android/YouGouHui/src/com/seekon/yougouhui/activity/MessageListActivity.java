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
import android.content.Context;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.mess.ChannelConst;
import com.seekon.yougouhui.func.mess.MessageConst;
import com.seekon.yougouhui.func.mess.MessageServiceHelper;
import com.seekon.yougouhui.util.RemoteImageHelper;

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
	protected long initRequestId() {
		return MessageServiceHelper.getInstance(this).getMessages(
				channel.getAsString(COL_NAME_UUID), requestResultType);
	}

	@Override
	protected void updateListItems() {
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
			this.setListAdapter(new MyAdapter(this));
		}

	}

	class MyAdapter extends SimpleAdapter {

		public MyAdapter(Context context) {
			super(context, messages, R.layout.message_list,
					new String[] { COL_NAME_TITLE }, new int[] { R.id.title, });
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			View view = super.getView(position, convertView, parent);
			Map record = (Map) getItem(position);

			String recordImg = (String) record.get(COL_NAME_IMG);
			if (recordImg != null && recordImg.trim().length() > 0) {
				ImageView imageView = (ImageView) view.findViewById(R.id.img_id);

				String imgSrc = Const.SERVER_APP_URL + recordImg;
				RemoteImageHelper.loadImage(imageView, imgSrc, true);
			}
			return view;
		}
	}
}
