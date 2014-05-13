package com.seekon.yougouhui.activity.message;

import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.message.MessageConst;
import com.seekon.yougouhui.func.message.MessageData;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.message.MessageProcessor;
import com.seekon.yougouhui.func.message.widget.MessageListAdapter;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class MyMessageActivity extends Activity {

	private MessageListAdapter listAdapter;

	private List<MessageEntity> messageList;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.base_listview);

		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		ListView listView = (ListView) findViewById(android.R.id.list);
		messageList = this.getMessageList();
		listAdapter = new MessageListAdapter(this, messageList);
		listView.setAdapter(listAdapter);
		listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int position,
					long arg3) {
				MessageEntity message = messageList.get(position);
			}
		});
		loadMessageFromRemote();
	}

	private List<MessageEntity> getMessageList() {
		return new MessageData(this).getMaxMessageListByReceiver(RunEnv
				.getInstance().getUser());
	}

	private void loadMessageFromRemote() {
		final String updateTime = getUpdateTime();
		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return MessageProcessor.getInstance(MyMessageActivity.this)
								.getMessages(RunEnv.getInstance().getUser(), updateTime);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						messageList.clear();
						messageList.addAll(getMessageList());
						listAdapter.updateData(messageList);
					}
				});
	}

	protected String getUpdateTime() {
		String result = SyncData.getInstance(this).getUpdateTime(
				MessageConst.TABLE_NAME, RunEnv.getInstance().getUser().getUuid());
		if (result == null) {
			result = RunEnv.getInstance().getUser().getRegisterTime();
		}
		return result;
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
}
