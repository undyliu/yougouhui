package com.seekon.yougouhui.func.sale;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;

import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.favorit.SaleFavoritConst;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class SaleUtils {

	private static final String TAG = SaleUtils.class.getSimpleName();

	private SaleUtils() {

	}

	public static SaleEntity getSale(Context context, String uuid) {
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
					SaleImgConst.COL_NAME_SALE_ID + "=?",
					new String[] { sale.getUuid() }, DataConst.COL_NAME_ORD_INDEX);
			List<FileEntity> images = new ArrayList<FileEntity>();
			while (cursor.moveToNext()) {
				FileEntity file = new FileEntity(null, cursor.getString(0));
				images.add(file);
			}
			sale.setImages(images);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return sale;
	}

	public static boolean isSaleFavorited(Context context, String saleId,
			String userId) {
		String selection = SaleFavoritConst.COL_NAME_SALE_ID + "=? and "
				+ SaleFavoritConst.COL_NAME_USER_ID + "=?";
		String[] selectionArgs = new String[] { saleId, userId };
		Cursor cursor = null;
		try {
			cursor = context.getContentResolver().query(SaleFavoritConst.CONTENT_URI,
					new String[] { " count(1) " }, selection, selectionArgs, null);
			if (cursor.moveToNext()) {
				return cursor.getInt(0) > 0;
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return false;
	}

}
