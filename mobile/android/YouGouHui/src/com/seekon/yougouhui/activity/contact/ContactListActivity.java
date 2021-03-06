package com.seekon.yougouhui.activity.contact;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.PinyinComparator;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.contact.widget.ContactListAdapter;
import com.seekon.yougouhui.func.contact.widget.SideBar;
import com.seekon.yougouhui.func.contact.widget.SideBar.OnTouchingLetterChangedListener;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.PinyinUtils;
import com.seekon.yougouhui.widget.ClearEditText;

/**
 * 通讯录
 * 
 * @author undyliu
 * 
 */
public class ContactListActivity extends Activity {

	private final static int ADD_FRIEND_REQUEST_CODE = 1;
	private final static int OPEN_FRIEND_REQUEST_CODE = 2;

	protected ListView sortListView;
	protected SideBar sideBar;
	private TextView dialog;
	protected ContactListAdapter adapter;
	private ClearEditText mClearEditText;

	protected List<UserEntity> contactDateList;

	/**
	 * 根据拼音来排列ListView里面的数据类
	 */
	private PinyinComparator pinyinComparator;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.contact);
		initViews();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.contact_list, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_contact_add:
			addFriend();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	protected void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		pinyinComparator = new PinyinComparator();

		sideBar = (SideBar) findViewById(R.id.contact_sidebar);
		dialog = (TextView) findViewById(R.id.contact_letter_dialog);
		sideBar.setTextView(dialog);

		// 设置右侧触摸监听
		sideBar
				.setOnTouchingLetterChangedListener(new OnTouchingLetterChangedListener() {

					@Override
					public void onTouchingLetterChanged(String s) {

						int position = adapter.getPositionForSection(s.charAt(0));
						if (position != -1) {
							sortListView.setSelection(position);
						}

					}
				});

		sortListView = (ListView) findViewById(R.id.contact_list);
		sortListView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view, int position,
					long id) {
				UserEntity user = contactDateList.get(position);
				Intent intent = new Intent(ContactListActivity.this,
						FriendProfileActivity.class);
				intent.putExtra(UserConst.DATA_KEY_USER, user);
				startActivityForResult(intent, OPEN_FRIEND_REQUEST_CODE);
			}
		});

		contactDateList = getContactListData();

		// 根据a-z进行排序源数据
		Collections.sort(contactDateList, pinyinComparator);
		adapter = getContactListAdapter();
		sortListView.setAdapter(adapter);

		mClearEditText = (ClearEditText) findViewById(R.id.contact_filter_edit);

		// 根据输入框输入值的改变来过滤搜索
		mClearEditText.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int start, int before, int count) {
				// 当输入框里面的值为空，更新为原来的列表，否则为过滤数据列表
				filterData(s.toString());
			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {

			}

			@Override
			public void afterTextChanged(Editable s) {
			}
		});

		// updateSideBar();
		
		initReceptionistView();
	}

	private void initReceptionistView(){
		ImageView photoView = (ImageView) findViewById(R.id.contact_user_photo);
		photoView.setLayoutParams(new LinearLayout.LayoutParams(80, 80));
		photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		photoView.setImageResource(R.drawable.receptionist);
		
		TextView nameView = (TextView) findViewById(R.id.contact_user_name);
		nameView.setText(R.string.label_receptionist);
		
		View view = findViewById(R.id.receptionist_view);
		view.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				
			}
		});
	}
	
	// 根据联系人数据重新设置sidebar
//	private void updateSideBar() {
//		List<String> catalogKeys = new ArrayList<String>();
//		catalogKeys.addAll(adapter.getCatalogKeys());
//		Collections.sort(catalogKeys, new Comparator<String>() {
//			@Override
//			public int compare(String lhs, String rhs) {
//				return lhs.compareTo(rhs);
//			}
//
//		});
//		int catalogSize = catalogKeys.size();
//		int sideBarHeight = this.getResources().getDisplayMetrics().heightPixels;
//		if (sideBarHeight > catalogSize * 30) {
//			sideBar.setLayoutParams(new FrameLayout.LayoutParams(30,
//					catalogSize * 30, Gravity.RIGHT));
//		}
//		sideBar.setNavWords(catalogKeys.toArray(new String[catalogSize]));
//	}

	protected ContactListAdapter getContactListAdapter() {
		return new ContactListAdapter(this, contactDateList);
	}

	protected List<UserEntity> getContactListData() {
		return RunEnv.getInstance().getUser().getFriends();
	}

	/**
	 * 根据输入框中的值来过滤数据并更新ListView
	 * 
	 * @param filterStr
	 */
	private void filterData(String filterStr) {
		List<UserEntity> filterDateList = new ArrayList<UserEntity>();

		if (TextUtils.isEmpty(filterStr)) {
			filterDateList = contactDateList;
		} else {
			filterDateList.clear();
			for (UserEntity sortModel : contactDateList) {
				String name = sortModel.getName();
				if (name.indexOf(filterStr.toString()) != -1
						|| PinyinUtils.getPinYin(name).startsWith(filterStr.toString())) {
					filterDateList.add(sortModel);
				}
			}
		}

		// 根据a-z进行排序
		Collections.sort(filterDateList, pinyinComparator);
		adapter.updateData(filterDateList);
	}

	private void addFriend() {
		Intent intent = new Intent(this, AddFriendActivity.class);
		startActivityForResult(intent, ADD_FRIEND_REQUEST_CODE);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case OPEN_FRIEND_REQUEST_CODE:
		case ADD_FRIEND_REQUEST_CODE:
			if (resultCode == RESULT_OK) {
				contactDateList = getContactListData();
				Collections.sort(contactDateList, pinyinComparator);
				adapter.updateData(contactDateList);
				// updateSideBar();
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
