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
		String lastPublishTime = requestIntent.getStringExtra(ShareConst.COL_NAME_PUBLISH_TIME);
		
		if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
			ShareProcessor shareProcessor = new ShareProcessor(
					getApplicationContext());
			shareProcessor.getShares(makeProcessorCallback(), lastPublishTime);
		} else {
			mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
		}
	}

}
