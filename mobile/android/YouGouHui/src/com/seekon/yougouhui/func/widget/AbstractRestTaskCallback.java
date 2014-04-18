package com.seekon.yougouhui.func.widget;

import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.Resource;
import com.seekon.yougouhui.util.ViewUtils;

public abstract class AbstractRestTaskCallback<T extends Resource> implements
		TaskCallback<RestMethodResult<T>> {
	protected String failedShowMsg;

	public AbstractRestTaskCallback() {
		super();
	}

	public AbstractRestTaskCallback(String failedShowMsg) {
		super();
		this.failedShowMsg = failedShowMsg;
	}

	@Override
	public void onFailed(String errorMessage) {
		if (failedShowMsg != null && failedShowMsg.length() > 0) {
			ViewUtils.showToast(failedShowMsg + "原因:" + errorMessage);
		}
	}

	@Override
	public void onCancelled() {

	}
}
