package com.seekon.yougouhui.func.discover.share;

import android.content.Intent;

import com.seekon.yougouhui.service.AbstractService;
import com.seekon.yougouhui.service.ServiceConst;

public class ShareService extends AbstractService {

	public ShareService() {
		super("ShareService");
	}

	@Override
	protected void handlerIntent(Intent requestIntent) {
		String method = requestIntent.getStringExtra(ServiceConst.METHOD_EXTRA);
		String lastPublishTime = requestIntent
				.getStringExtra(ShareConst.LAST_PUBLISH_TIME);
		String minPublishTime = requestIntent
				.getStringExtra(ShareConst.MIN_PUBLISH_TIME);
		String lastCommentPublishTime = requestIntent
				.getStringExtra(ShareConst.LAST_COMMENT_PUB_TIME);
		String minCommentPublishTime = requestIntent
				.getStringExtra(ShareConst.MIN_COMMENT_PUB_TIME);

		if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
			ShareProcessor shareProcessor = ShareProcessor
					.getInstance(getApplicationContext());
			shareProcessor.getShares(makeProcessorCallback(), lastPublishTime,
					minPublishTime, lastCommentPublishTime, minCommentPublishTime);
		} else {
			mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
		}
	}

}
