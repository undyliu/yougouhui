package com.seekon.yougouhui.func.profile.favorit.widget;

import java.util.List;

import android.content.Context;

import com.seekon.yougouhui.func.profile.favorit.FavoritEntity;
import com.seekon.yougouhui.func.widget.CatalogListAdapter;

public class FavoritListAdapter extends CatalogListAdapter{

	public FavoritListAdapter(Context mContext,
			List<FavoritEntity> contactList) {
		super(mContext, contactList);
	}

}
