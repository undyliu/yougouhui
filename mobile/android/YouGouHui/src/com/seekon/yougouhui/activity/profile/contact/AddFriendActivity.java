package com.seekon.yougouhui.activity.profile.contact;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.contact.SearchUserMethod;
import com.seekon.yougouhui.func.profile.contact.widget.SearchFriendResultListAdapter;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.user.UserUtils;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 添加新朋友
 * 
 * @author undyliu
 * 
 */
public class AddFriendActivity extends Activity {

	public static final int OPEN_FRIEND_REQUEST_CODE = 1;

	private static final String TAG = AddFriendActivity.class.getSimpleName();

	private TextView searchWordView = null;
	private Button searchButton = null;
	private ListView searchResultView = null;
	private View addFriendChooseView = null;
	private List<UserEntity> searchResultList = new ArrayList<UserEntity>();
	private BaseAdapter searchResultAdapter = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.contact_add_friend);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			back();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void back() {
		Intent intent = new Intent();
		this.setResult(RESULT_OK, intent);
		this.finish();
	}

	private void initViews() {
		searchWordView = (TextView) findViewById(R.id.search_word);

		searchButton = (Button) findViewById(R.id.b_search);
		searchButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				searchUsers();
			}
		});

		searchResultView = (ListView) findViewById(R.id.friend_search_result_view);
		addFriendChooseView = findViewById(R.id.add_friend_choose_view);
	}

	private void searchUsers() {
		searchWordView.setError(null);
		final String searchWord = searchWordView.getText().toString();
		if (TextUtils.isEmpty(searchWord)) {
			// searchWordView.setError(getString(R.string.error_field_required));
			searchWordView.requestFocus();
			updateSearchResultView(new JSONArrayResource());
			return;
		}

		UserEntity currentUser = RunEnv.getInstance().getUser();
		if (searchWord.equals(currentUser.getPhone())
				|| searchWord.equals(currentUser.getName())) {
			searchWordView
					.setError(getString(R.string.error_no_need_add_self_to_friend));
			searchWordView.requestFocus();
			updateSearchResultView(new JSONArrayResource());
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>>() {

			@Override
			protected RestMethodResult<JSONArrayResource> doInBackground(
					Void... params) {
				SearchUserMethod method = new SearchUserMethod(AddFriendActivity.this,
						searchWord);
				return method.execute();
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
				showProgress(false);
				searchButton.setEnabled(true);
				int status = result.getStatusCode();
				if (status == 200) {
					updateSearchResultView(result.getResource());
				} else {
					ViewUtils.showToast("获取数据失败.");
				}
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				searchButton.setEnabled(true);
				super.onCancelled();
			}
		};

		searchButton.setEnabled(false);
		showProgress(true);
		task.execute((Void) null);
	}

	private void showProgress(final boolean show) {
		ViewUtils.showProgress(this, this.findViewById(R.id.main_view), show);
	}

	private void updateSearchResultView(JSONArrayResource resource) {
		searchResultList.clear();
		UserEntity currentUser = RunEnv.getInstance().getUser();
		for (int i = 0; i < resource.length(); i++) {
			try {
				JSONObject jsonObj = resource.getJSONObject(i);
				UserEntity user = UserUtils.createFromJSONObject(jsonObj);
				if (!currentUser.equals(user)) {
					searchResultList.add(user);
				}
			} catch (JSONException e) {
				Logger.warn(TAG, e.getMessage());
			}
		}
		if (searchResultList.isEmpty()) {
			searchWordView.requestFocus();
			ViewUtils.showToast("没有符合条件的数据.");
			addFriendChooseView.setVisibility(View.VISIBLE);
		} else {
			addFriendChooseView.setVisibility(View.GONE);
			searchResultView.setVisibility(View.VISIBLE);
		}

		if (searchResultAdapter == null) {
			searchResultAdapter = new SearchFriendResultListAdapter(this,
					searchResultList);
			searchResultView.setAdapter(searchResultAdapter);
		} else {
			searchResultAdapter.notifyDataSetChanged();
		}
		// searchResultView.requestFocus();
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case OPEN_FRIEND_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				searchResultAdapter.notifyDataSetChanged();
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
