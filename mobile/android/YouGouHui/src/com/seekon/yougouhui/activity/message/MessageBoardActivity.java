package com.seekon.yougouhui.activity.message;

import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.message.MessageConst;
import com.seekon.yougouhui.func.message.MessageData;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.message.MessageProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 发消息主面板
 * 
 * @author undyliu
 * 
 */
public class MessageBoardActivity extends Activity {

	private UserEntity receiver;

	private View messBoardView;
	private TextView messageView;
	private Button sendButton;
	private List<MessageEntity> messageList;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		this.setContentView(R.layout.message_board);

		receiver = (UserEntity) this.getIntent().getSerializableExtra(
				MessageConst.COL_NAME_RECEIVER);
		initViews();
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		actionBar.setTitle(receiver.getName());

		messBoardView = findViewById(R.id.mess_board_main);
		messageView = (TextView) findViewById(R.id.share_comment);
		sendButton = (Button) findViewById(R.id.action_comment_send);
		sendButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				sendMessage();
			}
		});
		
		ViewUtils.hideInputMethodWindow(this);
		
		messageList = new MessageData(this).getMessageListByReceiver(receiver
				.getUuid());
	}

	private void sendMessage() {
		messageView.setError(null);
		final String content = messageView.getText().toString();
		if (TextUtils.isEmpty(content)) {
			messageView.setHint(R.string.error_field_required);
			messageView.requestFocus();
			return;
		}

		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return MessageProcessor.getInstance(MessageBoardActivity.this)
								.sendMessage(RunEnv.getInstance().getUser(), receiver, content);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						//TODO:
					}
				});
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
