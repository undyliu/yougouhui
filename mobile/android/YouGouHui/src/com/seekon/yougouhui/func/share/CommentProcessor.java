package com.seekon.yougouhui.func.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_SHARE_ID;

import java.util.Map;

import org.json.JSONException;

import android.content.ContentResolver;
import android.content.Context;
import android.net.Uri;

import com.seekon.yougouhui.func.spi.ICommentProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;
import com.seekon.yougouhui.util.JSONUtils;

public class CommentProcessor extends ContentProcessor implements ICommentProcessor{

	private static ICommentProcessor instance;
	
	private static final Object lock = new Object();
	
	public static ICommentProcessor getInstance(Context mContext){
		synchronized (lock) {
			if(instance == null){
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (ICommentProcessor) proxy.bind(new CommentProcessor(mContext));
			}
		}
		return instance;
	}
	
	private CommentProcessor(Context mContext) {
		super(mContext, CommentData.COL_NAMES, CommentConst.CONTENT_URI);
	}

	public RestMethodResult<JSONObjResource> deleteComment(String commentId) {
		RestMethodResult<JSONObjResource> result = new DeleteCommentMethod(
				mContext, commentId).execute();
		if (result.getStatusCode() == RestStatus.SC_OK) {
			ContentResolver resolver = mContext.getContentResolver();
			resolver.delete(CommentConst.CONTENT_URI, COL_NAME_UUID + "=?",
					new String[] { commentId });
		}
		return result;
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
}
