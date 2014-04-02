package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.DataConst.NAME_COUNT;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_ACTIVITY_ID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_DATE;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.func.AbstractDBHelper;
import com.seekon.yougouhui.func.user.UserEntity;

public class ShareData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CONTENT, COL_NAME_PUBLISH_TIME, COL_NAME_PUBLISHER,
			COL_NAME_ACTIVITY_ID, COL_NAME_PUBLISH_DATE };

	public ShareData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + ShareConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShareConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CONTENT + " TEXT, "
				+ COL_NAME_PUBLISHER + " TEXT, " + COL_NAME_PUBLISH_TIME + " TEXT, "
				+ COL_NAME_PUBLISH_DATE + " TEXT, " + COL_NAME_ACTIVITY_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	private String getShareDataSqlPart() {
		return " select s.uuid, s.content, s.publish_time, s.publisher, u.name as publisher_name, u.photo publisher_photo "
				+ " from e_share s left join e_user u on s.publisher = u.uuid ";
	}

	private ShareEntity assembleShareEntity(Cursor cursor) {
		int i = 0;
		ShareEntity share = new ShareEntity(cursor.getString(i++),
				cursor.getString(i++));
		share.setPublishTime(cursor.getLong(i++));
		UserEntity publisher = new UserEntity(cursor.getString(i++), null,
				cursor.getString(i++), null, cursor.getString(i++));
		share.setPublisher(publisher);
		return share;
	}

	/**
	 * 获取分享数据，包含用户名和用户头像
	 * 
	 * @param limitSql
	 * @return
	 */
	public List<ShareEntity> getShareData(String limitSql) {
		List<ShareEntity> result = new ArrayList<ShareEntity>();
		String sql = getShareDataSqlPart() + " order by s.publish_time desc";
		if (limitSql != null) {
			sql += limitSql;
		}
		Cursor cursor = this.getReadableDatabase().rawQuery(sql, null);
		while (cursor.moveToNext()) {
			result.add(assembleShareEntity(cursor));
		}
		cursor.close();
		return result;
	}

	public ShareEntity getShareDataById(String id) {
		ShareEntity share = null;
		String sql = getShareDataSqlPart() + " where s.uuid = ?";
		Cursor cursor = getReadableDatabase().rawQuery(sql, new String[] { id });
		if (cursor.moveToNext()) {
			share = assembleShareEntity(cursor);
		}
		cursor.close();
		return share;
	}

	/**
	 * 按发布日期获取分享的条数
	 * 
	 * @param publisher
	 * @return
	 */
	public List<Map<String, ?>> getShareCountByPublishDate(String where,
			String[] whereArgs, String publisher, String limitSql) {
		List<String> args = new ArrayList<String>();
		args.add(publisher);

		List<Map<String, ?>> result = new ArrayList<Map<String, ?>>();
		String sql = " select publish_date, count(1) from e_share where publisher = ? ";
		if (where != null && where.length() > 0) {
			sql += " and (" + where + ") ";
			args.addAll(Arrays.asList(whereArgs));
		}
		sql += " group by publish_date order by publish_date desc ";
		if (limitSql != null) {
			sql += limitSql;
		}

		Cursor cursor = getReadableDatabase().rawQuery(sql,
				args.toArray(new String[args.size()]));
		while (cursor.moveToNext()) {
			int i = 0;
			Map row = new HashMap();
			row.put(COL_NAME_PUBLISH_DATE, cursor.getString(i++));
			row.put(NAME_COUNT, cursor.getInt(i++));
			result.add(row);
		}
		cursor.close();
		return result;
	}

	/**
	 * 根据发布日期获取分享数据列表
	 * 
	 * @param publishData
	 * @param publisher
	 * @return
	 */
	public List<Map<String, ?>> getShareListByPublishDate(String where,
			String[] whereArgs, String publishData, String publisher) {
		List<String> args = new ArrayList<String>();
		args.add(publishData);
		args.add(publisher);

		List<Map<String, ?>> result = new ArrayList<Map<String, ?>>();
		String sql = " select uuid, content from e_share where publish_date = ? and publisher = ? ";
		if (where != null && where.length() > 0) {
			sql += " and (" + where + ") ";
			args.addAll(Arrays.asList(whereArgs));
		}
		sql += " order by publish_date desc ";

		Cursor cursor = getReadableDatabase().rawQuery(sql,
				args.toArray(new String[args.size()]));
		while (cursor.moveToNext()) {
			int i = 0;
			Map row = new HashMap();
			row.put(COL_NAME_UUID, cursor.getString(i++));
			row.put(COL_NAME_CONTENT, cursor.getString(i++));
			result.add(row);
		}
		cursor.close();
		return result;
	}
}
