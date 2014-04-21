package com.seekon.yougouhui.fragment;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.PinyinComparator;
import com.seekon.yougouhui.func.PinyinEntity;
import com.seekon.yougouhui.func.contact.widget.SideBar;
import com.seekon.yougouhui.func.contact.widget.SideBar.OnTouchingLetterChangedListener;
import com.seekon.yougouhui.func.favorit.FavoritEntity;
import com.seekon.yougouhui.func.favorit.widget.FavoritListAdapter;
import com.seekon.yougouhui.util.PinyinUtils;
import com.seekon.yougouhui.widget.ClearEditText;

public abstract class CatalogListFragement extends Fragment {

	protected View mainView;

	protected ListView sortListView;
	protected SideBar sideBar;
	private TextView dialog;
	protected FavoritListAdapter adapter;
	private ClearEditText mClearEditText;
	protected Activity activity;

	private PinyinComparator pinyinComparator;
	protected List<? extends PinyinEntity> dataList;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		mainView = inflater.inflate(R.layout.catalog_list, container, false);
		initViews();

		return mainView;
	}

	protected void initViews() {
		activity = this.getActivity();

		pinyinComparator = new PinyinComparator();

		sideBar = (SideBar) mainView.findViewById(R.id.contact_sidebar);
		dialog = (TextView) mainView.findViewById(R.id.contact_letter_dialog);
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

		sortListView = (ListView) mainView.findViewById(R.id.contact_list);
		sortListView.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view, int position,
					long id) {
				doItemCheckAction(position);
			}
		});

		dataList = getCatalogListData();

		// 根据a-z进行排序源数据
		Collections.sort(dataList, pinyinComparator);
		adapter = getCatalogListAdapter();
		sortListView.setAdapter(adapter);

		mClearEditText = (ClearEditText) mainView
				.findViewById(R.id.contact_filter_edit);

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

	public abstract List<FavoritEntity> getCatalogListData();

	public abstract FavoritListAdapter getCatalogListAdapter();

	public abstract void doItemCheckAction(int position);

	protected void updateViews(List catalogDataList) {
		Collections.sort(catalogDataList, pinyinComparator);
		adapter.updateListView(catalogDataList);
	}

	private void filterData(String filterStr) {
		List filterDateList = new ArrayList();

		if (TextUtils.isEmpty(filterStr)) {
			filterDateList = dataList;
		} else {
			filterDateList.clear();
			for (PinyinEntity sortModel : dataList) {
				String name = sortModel.getName();
				if (name.indexOf(filterStr.toString()) != -1
						|| PinyinUtils.getPinYin(name).startsWith(filterStr.toString())) {
					filterDateList.add(sortModel);
				}
			}
		}

		updateViews(filterDateList);

	}
}
