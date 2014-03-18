package com.seekon.yougouhui.activity;

import com.seekon.yougouhui.func.mess.MessageConst;

import android.app.Activity;
import android.content.ContentValues;
import android.os.Bundle;

/**
 * 活动详细
 * 
 * @author undyliu
 * 
 */
public class MessageActivity extends Activity {

	private ContentValues message = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		message = (ContentValues) this.getIntent().getExtras()
				.get(MessageConst.MESSAGE_DATA_KEY);
	}

}
