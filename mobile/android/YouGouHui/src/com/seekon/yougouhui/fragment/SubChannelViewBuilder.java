package com.seekon.yougouhui.fragment;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.Spinner;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.util.ContentValuesUtils;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.widget.ImageListRemoteAdapter;

public class SubChannelViewBuilder {

	static final String TAG = SubChannelViewBuilder.class.getSimpleName();

	private Context context = null;

	private ViewPager viewPager = null;
	
	public SubChannelViewBuilder(Context context) {
		super();
		this.context = context;
	}

	public void setViewPager(ViewPager viewPager) {
		this.viewPager = viewPager;
	}


	public View getSpinnerView(List<ContentValues> data) {
		View actionbarLayout = LayoutInflater.from(context).inflate(
				R.layout.subchannel_spinner, null);
		Spinner mActionbarSpinner = (Spinner) actionbarLayout
				.findViewById(R.id.action_bar_spinner);
		mActionbarSpinner
				.setOnItemSelectedListener(new SpinnerItemSelectedListener());

		List mapData = new ArrayList();
		for (ContentValues values : data) {
			mapData.add(ContentValuesUtils.toMap(values, null));
		}
		mActionbarSpinner.setAdapter(new ImageListRemoteAdapter(context, mapData,
				android.R.layout.simple_spinner_dropdown_item, new String[] { COL_NAME_NAME },
				new int[] { android.R.id.text1 }));

		return actionbarLayout;
	}

	class SpinnerItemSelectedListener implements OnItemSelectedListener {

		@Override
		public void onItemSelected(AdapterView<?> arg0, View view, int position,
				long arg3) {
			String str = arg0.getItemAtPosition(position).toString();
			Logger.debug(SubChannelViewBuilder.TAG, "你点击的是:" + str);
			if(viewPager != null){
				viewPager.setCurrentItem(position + ChannelFragment.TAB_SHOW_COUNT);
			}
		}

		@Override
		public void onNothingSelected(AdapterView<?> arg0) {
		}
	}
}

