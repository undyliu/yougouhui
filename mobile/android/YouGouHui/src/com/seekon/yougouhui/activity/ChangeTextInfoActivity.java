package com.seekon.yougouhui.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.EditText;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.util.ViewUtils;

public abstract class ChangeTextInfoActivity extends Activity {

	protected EditText textView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.change_text_info);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		textView = (EditText) findViewById(R.id.text_info);
		initViews();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		this.getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			saveTextInfo(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	protected void saveTextInfo(MenuItem item) {
		textView.setError(null);
		final String nickName = textView.getText().toString();
		if (TextUtils.isEmpty(nickName)) {
			textView.setError(getString(R.string.error_field_required));
			textView.requestFocus();
			return;
		}

		doSaveTextInfo(item);
	}

	protected void showProgress(final boolean show) {
		ViewUtils.showProgress(this, this.findViewById(R.id.text_info), show);
	}
	
	protected abstract void doSaveTextInfo(MenuItem item);

	protected abstract void initViews();
}
