package com.seekon.yougouhui.activity.user;

import static com.seekon.yougouhui.func.user.UserConst.COL_NAME_USER_NAME;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.EditText;

/**
 * 修改用户昵称
 * 
 * @author undyliu
 * 
 */
public class ChangeNameActivity extends Activity {

	private EditText nickNameView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.user_nickname);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		nickNameView = (EditText) findViewById(R.id.user_info);
		nickNameView.setText(RunEnv.getInstance().getUser()
				.getAsString(COL_NAME_USER_NAME));
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
			saveNickName(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void saveNickName(final MenuItem item) {
		nickNameView.setError(null);
		final String nickName = nickNameView.getText().toString();
		if (TextUtils.isEmpty(nickName)) {
			nickNameView.setError(getString(R.string.error_field_required));
			nickNameView.requestFocus();
			return;
		}

		ContentValues user = RunEnv.getInstance().getUser();
		if (nickName.equals(user.get(COL_NAME_USER_NAME))) {
			ViewUtils.showToast("昵称未做修改，不需要保存更新.");
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return UserProcessor.getInstance(ChangeNameActivity.this)
						.updateUserName(nickName);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				int status = result.getStatusCode();
				if (status == 200) {
					Intent intent = new Intent();
					setResult(RESULT_OK, intent);
					finish();
				} else {
					ViewUtils.showToast("修改失败.");
				}
				item.setEnabled(true);
				super.onPostExecute(result);
			}
			@Override
			protected void onCancelled() {
				showProgress(false);
				item.setEnabled(true);
				super.onCancelled();
			}
		};
		
		showProgress(true);
		item.setEnabled(false);
		task.execute((Void) null);
	}
	
	private void showProgress(final boolean show) {
		ViewUtils
				.showProgress(this, this.findViewById(R.id.user_info), show);
	}
}
