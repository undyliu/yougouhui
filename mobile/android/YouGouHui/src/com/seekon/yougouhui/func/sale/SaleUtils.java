package com.seekon.yougouhui.func.sale;

import java.util.ArrayList;
import java.util.List;

import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.util.ViewUtils;

import android.content.Context;
import android.database.Cursor;

public class SaleUtils {
	private SaleUtils(){
		
	}
	
	public static SaleEntity getSale(Context context, String uuid){
		SaleEntity sale = null;
		SaleData saleData = new SaleData(context);
		sale = saleData.getSale(uuid);
		if (sale == null) {
			ViewUtils.showToast("获取活动数据失败.");
			return sale;
		}

		Cursor cursor = null;
		try {
			cursor = context.getContentResolver().query(SaleImgConst.CONTENT_URI,
					new String[] { DataConst.COL_NAME_IMG },
					SaleImgConst.COL_NAME_SALE_ID + "=?", new String[] { sale.getUuid() },
					DataConst.COL_NAME_ORD_INDEX);
			List<String> images = new ArrayList<String>();
			while(cursor.moveToNext()){
				images.add(cursor.getString(0));
			}
			sale.setImages(images);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return sale;
	}
}
