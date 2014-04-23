package com.seekon.yougouhui.func.share;

import android.content.Context;

import com.seekon.yougouhui.func.spi.IShopReplyProcessor;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.service.ContentProcessor;
import com.seekon.yougouhui.service.ProcessorProxy;

public class ShopReplyProcessor extends ContentProcessor implements
		IShopReplyProcessor {

	private static IShopReplyProcessor instance = null;
	private static Object lock = new Object();

	public static IShopReplyProcessor getInstance(Context mContext) {
		synchronized (lock) {
			if (instance == null) {
				ProcessorProxy proxy = new ProcessorProxy();
				instance = (IShopReplyProcessor) proxy.bind(new ShopReplyProcessor(
						mContext));
			}
		}
		return instance;
	}

	private ShopReplyProcessor(Context mContext) {
		super(mContext, ShopReplyData.COL_NAMES, ShopReplyConst.CONTENT_URI);
	}

	@Override
	public RestMethodResult<JSONObjResource> saveShareReply(ShopReplyEntity reply) {
		return (RestMethodResult) this.execMethod(new PostShareReplyMethod(
				mContext, reply));
	}

}
