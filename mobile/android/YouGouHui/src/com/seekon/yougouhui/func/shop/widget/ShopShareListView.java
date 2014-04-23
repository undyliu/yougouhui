package com.seekon.yougouhui.func.shop.widget;

import java.util.List;

import android.content.Context;
import android.util.AttributeSet;

import com.seekon.yougouhui.func.share.CommentData;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareData;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.share.widget.ShareUtils;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.sync.SyncData;
import com.seekon.yougouhui.func.widget.PagedXListView;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ShopShareListView extends PagedXListView<ShareEntity>{
	
	private ShareData shareData;
	private CommentData commentData;
	private String shopId;
	
	public ShopShareListView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
	}

	public ShopShareListView(Context context, AttributeSet attrs) {
		super(context, attrs);
	}

	public ShopShareListView(Context context) {
		super(context);
	}

	public void init(){
		shareData = new ShareData(context);
		commentData = new CommentData(context);
		super.init(new ShopShareListAdapter(context, dataList));
	}
	
	public void loadData(String shopId){
		this.shopId = shopId;
		super.loadDataList();
	}
	
	@Override
	protected List<ShareEntity> getDataListFromLocal(String limitSql) {
		List<ShareEntity> result = shareData.getShopSharesData(shopId, limitSql);
		for(ShareEntity share : result){
			String shareId = share.getUuid();
			share.setImages(ShareUtils.getShareImagesFromLocal(context, shareId));
			share.setComments(commentData.getCommentData(shareId));
		}
		return result;
	}

	@Override
	protected RestMethodResult<JSONObjResource> getRemoteData(String updateTime) {
		return ShareProcessor.getInstance(context).getShopShares(shopId, updateTime);
	}

	@Override
	protected String getUpdateTime() {
		String result = SyncData.getInstance(context).getUpdateTime(
				ShareConst.NAME_SHOP_SHARE, shopId);
		if (result == null) {
			result = ShopUtils.getShopRegisterTime(context, shopId);
		}
		return result;
	}

}
