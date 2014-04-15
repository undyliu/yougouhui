package com.seekon.yougouhui.activity.profile.favorit;

import java.util.ArrayList;
import java.util.List;

import com.seekon.yougouhui.fragment.CatalogListFragement;
import com.seekon.yougouhui.func.profile.favorit.FavoritEntity;
import com.seekon.yougouhui.func.profile.favorit.widget.FavoritListAdapter;

public class SaleFavoritFragment extends CatalogListFragement{

	@Override
	public List<FavoritEntity> getCatalogListData() {
		return new ArrayList<FavoritEntity>();
	}

	@Override
	public FavoritListAdapter getCatalogListAdapter() {
		return new FavoritListAdapter(activity, (List<FavoritEntity>)dataList);
	}

	
}
