package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_SHARE_ID;

import java.io.File;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.SyncSupportProcessor;
import com.seekon.yougouhui.func.spi.IShareProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ProcessorProxy;

public class ShareProcessor extends SyncSupportProcessor implements
		IShareProcessor {

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
		super(mContext, ShareData.COL_NAMES, ShareConst.CONTENT_URI, ShareConst.TABLE_NAME);
	}

	/**
	 * 获取朋友分享信息
	 * 
	 * @param callback
	 */
	public RestMethodResult<JSONObjResource> getShares(String updateTime) {
		return (RestMethodResult) this.execMethod(new GetSharesMethod(mContext,
				updateTime));
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
			this.updateContentProvider(images, ShareImgData.COL_NAMES,
					ShareImgConst.CONTENT_URI);
		} catch (Exception e) {
		}

		// 更新分享的评论
		try {
			JSONArray comments = jsonObj.getJSONArray(ShareConst.DATA_COMMENT_KEY);
			updateContentProvider(comments, CommentData.COL_NAMES,
					CommentConst.CONTENT_URI);
		} catch (Exception e) {
		}
	}

	/**
	 * 重载删除操作，当删除share的时候，同时将image和comment删除掉
	 */
	@Override
	protected void deleteContentProvider(JSONObject jsonObj, Uri contentUri)
			throws JSONException {
		super.deleteContentProvider(jsonObj, contentUri);
		// TODO:需进行判断是否在删除share
		deleteShareImages(jsonObj);
		deleteComments(jsonObj);
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

	/**
	 * 保存发布分享的信息
	 */
	public RestMethodResult<JSONObjResource> postShare(ShareEntity share) {
		return (RestMethodResult)this.execMethod(new PostShareMethod(share, mContext));
	}

	public RestMethodResult<JSONObjResource> deleteShare(String shareId) {
		return (RestMethodResult) this.execMethod(new DeleteShareMethod(mContext,
				shareId));
	}

}
