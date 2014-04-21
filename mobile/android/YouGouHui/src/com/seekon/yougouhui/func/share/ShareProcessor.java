package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_SHARE_ID;

import java.io.File;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.spi.IShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorCallback;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;
import com.seekon.yougouhui.util.Logger;

public class ShareProcessor extends ContentProcessor implements IShareProcessor {

	private static IShareProcessor instance = null;
	private static Object lock = new Object();

	public static IShareProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IShareProcessor) proxy.bind(new ShareProcessor(mContext));
			}
		}
		return instance;
	}

	private ShareProcessor(Context mContext) {
		super(mContext, ShareData.COL_NAMES, ShareConst.CONTENT_URI);
	}

	/**
	 * 获取朋友分享信息
	 * 
	 * @param callback
	 */
	public RestMethodResult<JSONArrayResource> getShares(String lastPublishTime,
			String minPublishTime, String lastCommentPublishTime,
			String minCommentPublishTime) {
		GetSharesMethod method = new GetSharesMethod(mContext, lastPublishTime,
				minPublishTime, lastCommentPublishTime, minCommentPublishTime);
		return (RestMethodResult)this.execMethod(method);
	}

	@Override
	protected void updateContentProvider(RestMethodResult<Resource> result,
			String[] colNames) {
		if (result == null) {
			return;
		}
		try {
			Resource resource = result.getResource();
			if (resource != null && resource instanceof JSONObjResource) {
				JSONObjResource jsonObjRes = (JSONObjResource) resource;

				try {
					JSONArray shares = jsonObjRes.getJSONArray("newest-shares");
					updateShares(shares);
				} catch (Exception e) {
				}

				try {
					JSONArray comments = jsonObjRes.getJSONArray("newest-comments");
					updateComments(comments);
				} catch (Exception e) {
				}

				try {
					JSONArray shares = jsonObjRes.getJSONArray("deleted-shares");
					deleteShares(shares);
				} catch (Exception e) {
				}

				try {
					JSONArray comments = jsonObjRes.getJSONArray("deleted-comments");
					deleteComments(comments);
				} catch (Exception e) {
				}
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		}
	}

	private void updateShares(JSONArray shares) throws JSONException {
		int size = shares.length();
		if (size > 0) {
			for (int i = 0; i < size; i++) {
				JSONObject jsonObj = shares.getJSONObject(i);
				this.updateContentProvider(jsonObj, colNames, contentUri);
			}
		}
	}

	/**
	 * 重载updateContentProvider方法增加对e_share_img和e_comment的操作
	 */
	@Override
	protected void updateContentProvider(JSONObject jsonObj, String[] colNames,
			Uri contentUri) throws JSONException {
		super.updateContentProvider(jsonObj, colNames, contentUri);

		// 更新分享的图片
		try {
			JSONArray images = jsonObj.getJSONArray(ShareConst.DATA_IMAGE_KEY);
			updateShareImages(images);
		} catch (Exception e) {
		}

		// 更新分享的评论
		try {
			JSONArray comments = jsonObj.getJSONArray(ShareConst.DATA_COMMENT_KEY);
			updateComments(comments);
		} catch (Exception e) {
		}
	}

	private void updateShareImages(JSONArray images) throws JSONException {
		if (images != null && images.length() > 0) {
			for (int i = 0; i < images.length(); i++) {
				JSONObject image = images.getJSONObject(i);
				updateContentProvider(image, ShareImgData.COL_NAMES,
						ShareImgConst.CONTENT_URI);
			}
		}
	}

	private void updateComments(JSONArray comments) throws JSONException {
		if (comments != null && comments.length() > 0) {
			for (int i = 0; i < comments.length(); i++) {
				JSONObject comment = comments.getJSONObject(i);
				updateContentProvider(comment, CommentData.COL_NAMES,
						CommentConst.CONTENT_URI);
			}
		}
	}

	private void deleteShares(JSONArray shares) throws JSONException {
		if (shares == null) {
			return;
		}
		int size = shares.length();
		for (int i = 0; i < size; i++) {
			JSONObject jsonObj = shares.getJSONObject(i);
			this.deleteContentProvider(jsonObj, ShareConst.CONTENT_URI);

			deleteShareImages(jsonObj);
			deleteComments(jsonObj);
		}
	}

	private void deleteShareImages(JSONObject share) throws JSONException {
		String[] args = new String[] { share.getString(COL_NAME_UUID) };
		String where = COL_NAME_SHARE_ID + "=?";
		ContentResolver resolver = mContext.getContentResolver();
		Cursor cursor = null;
		try {
			cursor = resolver.query(ShareImgConst.CONTENT_URI,
					new String[] { COL_NAME_IMG }, where, args, null);
			while (cursor.moveToNext()) {
				String image = cursor.getString(0);
				File file = FileHelper.getFileFromCache(image);
				file.delete();
			}
		} finally {
			cursor.close();
		}
		resolver.delete(ShareImgConst.CONTENT_URI, where, args);
	}

	private void deleteComments(JSONObject share) throws JSONException {
		String[] args = new String[] { share.getString(COL_NAME_UUID) };
		String where = COL_NAME_SHARE_ID + "=?";
		ContentResolver resolver = mContext.getContentResolver();
		resolver.delete(CommentConst.CONTENT_URI, where, args);
	}

	private void deleteComments(JSONArray comments) throws JSONException {
		this.deleteContentProvider(comments, CommentConst.CONTENT_URI);
	}

	/**
	 * 保存发布分享的信息
	 */
	public RestMethodResult<JSONObjResource> postShare(ShareEntity share) {
		return new PostShareMethod(share, mContext).execute();
	}

	public RestMethodResult<JSONObjResource> postComment(
			Map<String, String> comment) {
		RestMethodResult<JSONObjResource> result = new PostCommentMethod(mContext,
				comment).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			JSONObjResource resource = result.getResource();
			JSONUtils.putJSONValue(resource, COL_NAME_SHARE_ID,
					comment.get(COL_NAME_SHARE_ID));
			JSONUtils.putJSONValue(resource, COL_NAME_CONTENT,
					comment.get(COL_NAME_CONTENT));
			JSONUtils.putJSONValue(resource, COL_NAME_PUBLISHER,
					comment.get(COL_NAME_PUBLISHER));

			try {
				updateContentProvider(resource, CommentData.COL_NAMES,
						CommentConst.CONTENT_URI);
			} catch (JSONException e) {
				throw new RuntimeException(e);
			}
		}
		return result;
	}

	public RestMethodResult<JSONObjResource> deleteShare(String shareId) {
		RestMethodResult<JSONObjResource> resource = new DeleteShareMethod(
				mContext, shareId).execute();

		String selection = COL_NAME_UUID + "=?";
		String[] selectionArgs = new String[] { shareId };

		ContentResolver resolver = mContext.getContentResolver();
		resolver.delete(ShareConst.CONTENT_URI, selection, selectionArgs);

		selection = COL_NAME_SHARE_ID + "=?";
		resolver.delete(ShareImgConst.CONTENT_URI, selection, selectionArgs);
		resolver.delete(CommentConst.CONTENT_URI, selection, selectionArgs);

		return resource;
	}

	public RestMethodResult<JSONObjResource> deleteComment(String commentId) {
		return new DeleteCommentMethod(mContext, commentId).execute();
	}
}
