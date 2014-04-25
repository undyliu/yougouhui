package com.seekon.yougouhui.activity.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.List;

import android.content.Intent;
import android.os.Bundle;

import com.seekon.yougouhui.activity.DateIndexedListActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.share.widget.MyShareListAdapter;
import com.seekon.yougouhui.func.share.widget.ShareUtils;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.func.widget.DateIndexedListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

/**
 * 个人的分享
 * 
 * @author undyliu
 * 
 */
public class MyShareActivity extends DateIndexedListActivity {

	public static final int SHARE_DETAIL_REQUEST_RESULT_CODE = 1;

	private String userId = null;

	private ShareData shareData = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		Intent intent = this.getIntent();
		userId = intent.getExtras().getString(COL_NAME_UUID);
		shareData = new ShareData(this);
		
		String title = intent.getExtras().getString(DataConst.COL_NAME_TITLE);
		if(title != null && title.trim().length() > 0){
			this.getActionBar().setTitle(title);
		}
		
		super.onCreate(savedInstanceState);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case SHARE_DETAIL_REQUEST_RESULT_CODE:
			if (resultCode == RESULT_OK && data != null) {
				int position = data.getIntExtra("position", -1);
				if (position == -1) {
					return;
				}

				ShareEntity share = (ShareEntity) data
						.getSerializableExtra(ShareConst.DATA_SHARE_KEY);
				List<FileEntity> images = share.getImages();
				for (FileEntity image : images) {
					FileHelper.deleteCacheFile(image);
				}

				DateIndexedEntity entity = dataList.get(position);
				entity.getSubItemList().remove(entity);

				listAdapter.notifyDataSetChanged();
			}
			break;
		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@Override
	public DateIndexedListAdapter getListAdapter() {
		return new MyShareListAdapter(dataList, this);
	}

	@Override
	protected List<DateIndexedEntity> getDataListFromLocal(String searchWord,
			String limitSql) {
		String where = null;
		String[] whereArgs = null;
		if (searchWord != null && searchWord.trim().length() > 0) {
			where = " content like ? ";
			whereArgs = new String[] { "%" + searchWord + "%" };
		}

		List<DateIndexedEntity> shareCountList = shareData
				.getShareCountByPublishDate(where, whereArgs, userId, limitSql);
		for (DateIndexedEntity shareCount : shareCountList) {
			String publishDate = DateUtils.getDateString_yyyyMMdd(shareCount
					.getDate());
			List<ShareEntity> shareList = shareData.getShareListByPublishDate(where,
					whereArgs, publishDate, userId);
			for (ShareEntity share : shareList) {
				share.setImages(ShareUtils.getShareImagesFromLocal(this,
						share.getUuid()));
			}
			shareCount.setSubItemList(shareList);
		}
		return shareCountList;
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return (RestMethodResult) ShareProcessor.getInstance(this).getUserShares(
				RunEnv.getInstance().getUser());
	}

	@Override
	protected String getUpdateTime() {
		return null;
	}
	
	@Override
	public void onRefresh() {
		this.onPostLoad();
	}
}
