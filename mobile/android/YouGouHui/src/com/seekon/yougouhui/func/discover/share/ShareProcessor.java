package com.seekon.yougouhui.func.discover.share;

import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;

public class ShareProcessor extends ContentProcessor {

	public ShareProcessor(Context mContext) {
		super(mContext, ShareData.COL_NAMES, ShareConst.CONTENT_URI);
	}

	/**
	 * 获取朋友分享信息
	 * 
	 * @param callback
	 */
	public void getShares(ProcessorCallback callback, String lastPublishTime) {
		GetSharesMethod method = new GetSharesMethod(mContext, lastPublishTime);
		this.execMethodWithCallback(method, callback);
	}

	/**
	 * 重载updateContentProvider方法增加对e_share_img和e_comment的操作
	 */
	@Override
	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.updateContentProvider(jsonObj, colNames, contentUri);

		// 更新分享的图片
		JSONArray images = null;
		try {
			images = jsonObj.getJSONArray(ShareConst.DATA_IMAGE_KEY);
		} catch (Exception e) {
		}
		if (images != null && images.length() > 0) {
			for (int i = 0; i < images.length(); i++) {
				JSONObject image = images.getJSONObject(i);
				updateContentProvider(image, ShareImgData.COL_NAMES,
						ShareImgConst.CONTENT_URI);
			}
		}

		// 更新分享的评论
		JSONArray comments = null;
		try {
			comments = jsonObj.getJSONArray(ShareConst.DATA_COMMENT_KEY);
		} catch (Exception e) {
		}
		if (comments != null && comments.length() > 0) {
			for (int i = 0; i < comments.length(); i++) {
				JSONObject comment = comments.getJSONObject(i);
				updateContentProvider(comment, CommentData.COL_NAMES,
						CommentConst.CONTENT_URI);
			}
		}
	}

	/**
	 * 保存发布分享的信息
	 */
	public RestMethodResult<JSONObjResource> postShare(Map share) {
		return new PostShareMethod(share, mContext).execute();
	}

	public RestMethodResult<JSONObjResource> postComment(
			Map<String, String> comment) {
		return new PostCommentMethod(mContext, comment).execute();
	}
	
	public RestMethodResult<JSONObjResource> deleteShare(String shareId){
		return new DeleteShareMethod(mContext, shareId).execute();
	}
	
	public RestMethodResult<JSONObjResource> deleteComment(String commentId){
		return new DeleteCommentMethod(mContext, commentId).execute();
	}
}
