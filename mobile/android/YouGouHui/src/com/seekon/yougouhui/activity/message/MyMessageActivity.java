package com.seekon.yougouhui.activity.message;

import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.ListView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.message.MessageData;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.message.widget.MessageListAdapter;

public class MyMessageActivity extends Activity {

	private MessageListAdapter listAdapter;

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
		listAdapter = new MessageListAdapter(this, getMessageList());
		listView.setAdapter(listAdapter);
	}

	private List<MessageEntity> getMessageList() {
		return new MessageData(this).getMaxMessageListByReceiver(RunEnv.getInstance()
				.getUser().getUuid());
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
