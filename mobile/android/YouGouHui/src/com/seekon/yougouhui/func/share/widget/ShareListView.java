package com.seekon.yougouhui.func.share.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.CommentData;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.PagedXListView;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ShareListView extends PagedXListView<ShareEntity> {

	private ShareData shareData = null;

	private CommentData commentData = null;

	public ShareListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public ShareListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public ShareListView(Context context) {
		super(context);
	}

	public void init() {
		shareData = new ShareData(context);
		commentData = new CommentData(context);

		super.init(new ShareListAdapter(context, dataList));
	}

	public void loadData() {
		super.loadDataList();
	}

	private List<CommentEntity> getCommentsFromLocal(String shareId) {
		return commentData.getCommentData(shareId);
	}

	@Override
	protected List<ShareEntity> getDataListFromLocal(String limitSql) {
		List<ShareEntity> result = shareData.getFriendSharesData(limitSql);
		for (ShareEntity share : result) {
			share.setImages(ShareUtils.getShareImagesFromLocal(context,
					share.getUuid()));
			share.setComments(getCommentsFromLocal(share.getUuid()));
		}
		return result;
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return ShareProcessor.getInstance(context).getFriendShares(updateTime);
	}

	@Override
	protected String getUpdateTime() {
		String result = SyncData.getInstance(context).getUpdateTime(
				ShareConst.TABLE_NAME, RunEnv.getInstance().getUser().getUuid());
		if (result == null) {
			result = RunEnv.getInstance().getUser().getRegisterTime();
		}
		return result;
	}

}
