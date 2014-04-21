package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.sale.SaleDiscussConst.COL_NAME_SALE_ID;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.user.UserEntity;

public class SaleDiscussData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CONTENT, COL_NAME_SALE_ID, COL_NAME_PUBLISHER,
			COL_NAME_PUBLISH_TIME };

	public SaleDiscussData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + SaleDiscussConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + SaleDiscussConst.TABLE_NAME
				+ " (" + COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CONTENT
				+ " TEXT, " + COL_NAME_SALE_ID + " TEXT, " + COL_NAME_PUBLISHER
				+ " TEXT, " + COL_NAME_PUBLISH_TIME + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	public List<SaleDiscussEntity> getDiscussList(String saleId) {
		List<SaleDiscussEntity> result = new ArrayList<SaleDiscussEntity>();
		String sql = " select d.uuid, content, d.publish_time, publisher, u.name user_name, u.photo, sale_id "
				+ " from e_sale_discuss d"
				+ " join e_user u on d.publisher = u.uuid "
				+ " where d.sale_id = ? ";
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase()
					.rawQuery(sql, new String[] { saleId });
			while (cursor.moveToNext()) {
				int i = 0;
				SaleDiscussEntity discuss = new SaleDiscussEntity();
				discuss.setUuid(cursor.getString(i++));
				discuss.setContent(cursor.getString(i++));
				discuss.setPublishTime(cursor.getLong(i++));

				UserEntity user = new UserEntity(cursor.getString(i++), null,
						cursor.getString(i++), null, cursor.getString(i++), null);
				discuss.setPublisher(user);

				SaleEntity sale = new SaleEntity();
				sale.setUuid(cursor.getString(i++));
				discuss.setSale(sale);

				result.add(discuss);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return result;
	}
}
