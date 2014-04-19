package com.seekon.yougouhui.activity.profile.favorit;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_LAST_MODIFY_TIME;
import static com.seekon.yougouhui.func.profile.favorit.ShopFavoritConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.profile.favorit.ShopFavoritConst.COL_NAME_USER_ID;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;

import com.seekon.yougouhui.activity.profile.shop.ShopBaseInfoActivity;
import com.seekon.yougouhui.fragment.CatalogListFragement;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.favorit.FavoritEntity;
import com.seekon.yougouhui.func.profile.favorit.ShopFavoritConst;
import com.seekon.yougouhui.func.profile.favorit.ShopFavoritProcessor;
import com.seekon.yougouhui.func.profile.favorit.widget.FavoritListAdapter;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;

public class ShopFavoritFragment extends CatalogListFragement {

	private static final int OPEN_SHOP_REQUEST_CODE = 1;

	@Override
	public List<FavoritEntity> getCatalogListData() {
		List<FavoritEntity> result = getFavoritEntitiesFromLocal();
		if (result.isEmpty()) {
			loadDataFromRemote();
		}
		return result;
	}

	@Override
	public FavoritListAdapter getCatalogListAdapter() {
		return new FavoritListAdapter(activity, (List<FavoritEntity>) dataList);
	}

	private List<FavoritEntity> getFavoritEntitiesFromLocal() {
		List<FavoritEntity> result = new ArrayList<FavoritEntity>();

		String[] projection = new String[] { COL_NAME_UUID, COL_NAME_USER_ID,
				COL_NAME_SHOP_ID, COL_NAME_TITLE, COL_NAME_IMG };
		String selection = COL_NAME_USER_ID + "=?";
		String[] selectionArgs = new String[] { RunEnv.getInstance().getUser()
				.getUuid() };
		Cursor cursor = null;
		try {
			cursor = activity.getContentResolver().query(
					ShopFavoritConst.CONTENT_URI, projection, selection, selectionArgs,
					COL_NAME_LAST_MODIFY_TIME);
			while (cursor.moveToNext()) {
				int i = 0;
				FavoritEntity facorit = new FavoritEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++));
				result.add(facorit);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return result;
	}

	private void loadDataFromRemote() {

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>() {

					@Override
					public RestMethodResult<JSONArrayResource> doInBackground() {
						return ShopFavoritProcessor.getInstance(activity)
								.getShopFavoritesByUser(
										RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONArrayResource> result) {
						dataList = getFavoritEntitiesFromLocal();
						updateViews(dataList);
					}
				});
	}

	@Override
	public void doItemCheckAction(int position) {
		String shopId = ((FavoritEntity) dataList.get(position)).getCode();
		Intent intent = new Intent(activity, ShopBaseInfoActivity.class);
		intent.putExtra(ShopConst.COL_NAME_UUID, shopId);
		startActivityForResult(intent, OPEN_SHOP_REQUEST_CODE);
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case OPEN_SHOP_REQUEST_CODE:
			if (resultCode == Activity.RESULT_OK && data != null) {

			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
