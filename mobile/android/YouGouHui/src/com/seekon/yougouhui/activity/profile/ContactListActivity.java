package com.seekon.yougouhui.activity.profile;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.profile.contact.ContactEntity;
import com.seekon.yougouhui.func.profile.contact.PinyinComparator;
import com.seekon.yougouhui.func.profile.contact.widget.ContactListAdapter;
import com.seekon.yougouhui.func.profile.contact.widget.SideBar;
import com.seekon.yougouhui.func.profile.contact.widget.SideBar.OnTouchingLetterChangedListener;
import com.seekon.yougouhui.util.PinyinUtils;
import com.seekon.yougouhui.widget.ClearEditText;

/**
 * 通讯录
 * 
 * @author undyliu
 * 
 */
public class ContactListActivity extends Activity {

	private ListView sortListView;
	private SideBar sideBar;
	private TextView dialog;
	private ContactListAdapter adapter;
	private ClearEditText mClearEditText;

	private List<ContactEntity> contactDateList;

	/**
	 * 根据拼音来排列ListView里面的数据类
	 */
	private PinyinComparator pinyinComparator;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.contact_list);
		initViews();
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
	
	private void initViews() {
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
						// 该字母首次出现的位置
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
				// 这里要利用adapter.getItem(position)来获取当前position所对应的对象
				Toast.makeText(getApplication(),
						((ContactEntity) adapter.getItem(position)).getName(),
						Toast.LENGTH_SHORT).show();
			}
		});

		contactDateList = getContactListData();

		// 根据a-z进行排序源数据
		Collections.sort(contactDateList, pinyinComparator);
		adapter = new ContactListAdapter(this, contactDateList);
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
	}

	private List getContactListData() {
		List result = new ArrayList();
		return result;
	}

	/**
	 * 根据输入框中的值来过滤数据并更新ListView
	 * 
	 * @param filterStr
	 */
	private void filterData(String filterStr) {
		List<ContactEntity> filterDateList = new ArrayList<ContactEntity>();

		if (TextUtils.isEmpty(filterStr)) {
			filterDateList = contactDateList;
		} else {
			filterDateList.clear();
			for (ContactEntity sortModel : contactDateList) {
				String name = sortModel.getName();
				if (name.indexOf(filterStr.toString()) != -1
						|| PinyinUtils.getPinYin(name).startsWith(filterStr.toString())) {
					filterDateList.add(sortModel);
				}
			}
		}

		// 根据a-z进行排序
		Collections.sort(filterDateList, pinyinComparator);
		adapter.updateListView(filterDateList);
	}

}
