package com.seekon.yougouhui.activity.profile.contact;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.contact.FriendConst;
import com.seekon.yougouhui.func.profile.contact.widget.ContactListAdapter;
import com.seekon.yougouhui.func.profile.contact.widget.ContactListWithCheckedAdapter;
import com.seekon.yougouhui.func.user.UserEntity;

public class ContactListWithCheckedActivity extends ContactListActivity
		implements OnCheckedChangeListener {

	private List<UserEntity> selectedUserList;

	private ArrayList<UserEntity> checkedUserList = new ArrayList<UserEntity>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		selectedUserList = (List<UserEntity>) this.getIntent()
				.getSerializableExtra(FriendConst.DATA_SELECTED_USER_LIST_KEY);
		if (selectedUserList == null) {
			selectedUserList = new ArrayList<UserEntity>();
		}

		super.onCreate(savedInstanceState);
	}

	@Override
	protected List<UserEntity> getContactListData() {
		List<UserEntity> list = new ArrayList<UserEntity>(
				super.getContactListData());
		list.removeAll(selectedUserList);
		return list;
	}

	@Override
	protected ContactListAdapter getContactListAdapter() {
		return new ContactListWithCheckedAdapter(this, contactDateList, this);
	}

	@Override
	protected void initViews() {
		super.initViews();
		this.sideBar.setVisibility(View.GONE);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		boolean result = super.onCreateOptionsMenu(menu);
		//menu.findItem(R.id.menu_contact_add).setVisible(false);
		menu.findItem(R.id.menu_contact_confirm).setVisible(true);
		return result;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_contact_confirm:
			contactCheckedConfirm();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void contactCheckedConfirm() {
		Intent intent = new Intent();
		intent.putExtra(FriendConst.DATA_SELECTED_USER_LIST_KEY, checkedUserList);
		this.setResult(RESULT_OK, intent);
		this.finish();
	}

	@Override
	public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
		int id = buttonView.getId();
		if (isChecked) {
			UserEntity emp = this.contactDateList.get(id);
			emp.setPwd(null);
			checkedUserList.add(emp);
		} else {
			checkedUserList.remove(this.contactDateList.get(id));
		}
	}
}
