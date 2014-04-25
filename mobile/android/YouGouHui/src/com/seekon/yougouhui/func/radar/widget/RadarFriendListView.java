package com.seekon.yougouhui.func.radar.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.contact.widget.FriendListAdapter;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class RadarFriendListView extends RadarResultListView<UserEntity> {

	public RadarFriendListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public RadarFriendListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public RadarFriendListView(Context context) {
		super(context);
	}

	@Override
	public EntityListAdapter<UserEntity> getEntityListAdapter() {
		return new FriendListAdapter(context, dataList);
	}

	@Override
	protected List<UserEntity> loadDataListFromRemote(int currentOffset,
			LocationEntity location) {
		return null;
	}

}
