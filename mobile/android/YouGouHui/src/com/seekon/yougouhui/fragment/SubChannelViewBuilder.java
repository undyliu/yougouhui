package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.SimpleAdapter;
import android.widget.Spinner;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.fragment.listener.TabSpinnerItemSelectedListener;
import com.seekon.yougouhui.func.sale.ChannelEntity;

public class SubChannelViewBuilder {

	static final String TAG = SubChannelViewBuilder.class.getSimpleName();

	private Context context = null;

	private Spinner mActionbarSpinner = null;

	private TabSpinnerItemSelectedListener itemSelectedListener = new TabSpinnerItemSelectedListener();

	public SubChannelViewBuilder(Context context) {
		super();
		this.context = context;
	}

	public void setViewPager(ViewPager viewPager) {
		if (mActionbarSpinner != null) {
			itemSelectedListener.setViewPager(viewPager);
			mActionbarSpinner.setOnItemSelectedListener(itemSelectedListener);
		}
	}

	public View getSpinnerView(List<ChannelEntity> data) {
		View actionbarLayout = LayoutInflater.from(context).inflate(
				R.layout.subchannel_spinner, null);
		mActionbarSpinner = (Spinner) actionbarLayout
				.findViewById(R.id.action_bar_spinner);

		List mapData = new ArrayList();
		Map otherMap = new HashMap();
		otherMap.put(COL_NAME_NAME, "其他");
		mapData.add(otherMap);

		for (ChannelEntity values : data) {
			Map row = new HashMap();
			row.put(COL_NAME_NAME, values.getName());
			mapData.add(row);
		}
		mActionbarSpinner.setAdapter(new SimpleAdapter(context, mapData,
				android.R.layout.simple_spinner_dropdown_item,
				new String[] { COL_NAME_NAME }, new int[] { android.R.id.text1 }));
		return actionbarLayout;
	}

	public Spinner getSpinner() {
		return mActionbarSpinner;
	}
}
