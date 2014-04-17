package com.seekon.yougouhui.func.sale;

import android.content.Intent;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.spi.IChannelProcessor;
import com.seekon.yougouhui.func.spi.ISaleProcessor;
import com.seekon.yougouhui.service.AbstractService;
import com.seekon.yougouhui.service.ServiceConst;

public class SaleService extends AbstractService {

	public static final int RESOURCE_TYPE_CHANNEL = 1;

	public static final int RESOURCE_TYPE_SALE = 2;

	public SaleService() {
		super("SaleService");
	}

	@Override
	protected void handlerIntent(Intent requestIntent) {
		String method = requestIntent.getStringExtra(ServiceConst.METHOD_EXTRA);
		int resourceType = requestIntent.getIntExtra(
				ServiceConst.RESOURCE_TYPE_EXTRA, -1);

		switch (resourceType) {
		case RESOURCE_TYPE_CHANNEL:
			if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
				String parentId = requestIntent
						.getStringExtra(DataConst.COL_NAME_PARENT_ID);
				IChannelProcessor processor = ChannelProcessor
						.getInstance(getApplicationContext());
				processor.getChannels(makeProcessorCallback(), parentId);
			} else {
				mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			}
			break;
		case RESOURCE_TYPE_SALE:
			if (method.equalsIgnoreCase(ServiceConst.METHOD_GET)) {
				String channelId = requestIntent
						.getStringExtra(SaleConst.COL_NAME_CHANNEL_ID);
				ISaleProcessor processor = SaleProcessor
						.getInstance(getApplicationContext());
				processor.getSalesByChannel(makeProcessorCallback(), channelId);
			} else {
				mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			}
			break;
		default:
			mCallback.send(ServiceConst.REQUEST_INVALID, getOriginalIntentBundle());
			break;
		}
	}

}
