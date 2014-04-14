package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_ACTIVITY_ID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_DATE;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_SHOP_ID;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.util.DateUtils;

public class ShareData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CONTENT, COL_NAME_PUBLISH_TIME, COL_NAME_PUBLISHER,
			COL_NAME_ACTIVITY_ID, COL_NAME_PUBLISH_DATE, COL_NAME_SHOP_ID };

	public ShareData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + ShareConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + ShareConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CONTENT + " TEXT, "
				+ COL_NAME_PUBLISHER + " TEXT, " + COL_NAME_PUBLISH_TIME + " TEXT, "
				+ COL_NAME_PUBLISH_DATE + " TEXT, " + COL_NAME_SHOP_ID + " TEXT, "
				+ COL_NAME_ACTIVITY_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	private String getShareDataSqlPartWithFriendsCondition() {
		String sql = getShareDataSqlPart();
		sql += " where u.uuid = ? or u.uuid in (select f.friend_id from e_friend f where f.user_id = ?)";
		return sql;
	}

	private String getShareDataSqlPart() {
		return " select s.uuid, s.content, s.publish_time, s.publisher, u.name as publisher_name, u.photo publisher_photo "
				+ " from e_share s inner join e_user u on s.publisher = u.uuid ";
	}

	private ShareEntity assembleShareEntity(Cursor cursor) {
		int i = 0;
		ShareEntity share = new ShareEntity(cursor.getString(i++),
				cursor.getString(i++));
		share.setPublishTime(cursor.getLong(i++));
		UserEntity publisher = new UserEntity(cursor.getString(i++), null,
				cursor.getString(i++), null, cursor.getString(i++), null);
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
		String sql = getShareDataSqlPartWithFriendsCondition()
				+ " order by s.publish_time desc";
		if (limitSql != null) {
			sql += limitSql;
		}

		String userId = RunEnv.getInstance().getUser().getUuid();
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sql,
					new String[] { userId, userId });
			while (cursor.moveToNext()) {
				result.add(assembleShareEntity(cursor));
			}
		} finally {
			cursor.close();
		}
		return result;
	}

	public ShareEntity getShareDataById(String id) {
		ShareEntity share = null;
		String sql = getShareDataSqlPart() + " where s.uuid = ?";
		Cursor cursor = null;
		try {
			cursor = getReadableDatabase().rawQuery(sql, new String[] { id });
			if (cursor.moveToNext()) {
				share = assembleShareEntity(cursor);
			}
		} finally {
			cursor.close();
		}
		return share;
	}

	/**
	 * 按发布日期获取分享的条数
	 * 
	 * @param publisher
	 * @return
	 */
	public List<DateIndexedEntity> getShareCountByPublishDate(String where,
			String[] whereArgs, String publisher, String limitSql) {
		List<String> args = new ArrayList<String>();
		args.add(publisher);

		List<DateIndexedEntity> result = new ArrayList<DateIndexedEntity>();
		String sql = " select publish_date, count(1) from e_share where publisher = ? ";
		if (where != null && where.length() > 0) {
			sql += " and (" + where + ") ";
			args.addAll(Arrays.asList(whereArgs));
		}
		sql += " group by publish_date order by publish_date desc ";
		if (limitSql != null) {
			sql += limitSql;
		}

		Cursor cursor = null;
		try {
			cursor = getReadableDatabase().rawQuery(sql,
					args.toArray(new String[args.size()]));
			while (cursor.moveToNext()) {
				int i = 0;
				DateIndexedEntity entity = new DateIndexedEntity();
				entity.setDate(DateUtils.getDate_yyyyMMdd(cursor.getString(i++)));
				entity.setItemCount(cursor.getInt(i++));
				result.add(entity);
			}
		} finally {
			cursor.close();
		}
		return result;
	}

	/**
	 * 根据发布日期获取分享数据列表
	 * 
	 * @param publishData
	 * @param publisher
	 * @return
	 */
	public List<ShareEntity> getShareListByPublishDate(String where,
			String[] whereArgs, String publishData, String publisher) {
		List<String> args = new ArrayList<String>();
		args.add(publishData);
		args.add(publisher);

		List<ShareEntity> result = new ArrayList<ShareEntity>();
		String sql = " select uuid, content from e_share where publish_date = ? and publisher = ? ";
		if (where != null && where.length() > 0) {
			sql += " and (" + where + ") ";
			args.addAll(Arrays.asList(whereArgs));
		}
		sql += " order by publish_time desc ";

		Cursor cursor = null;
		try {
			cursor = getReadableDatabase().rawQuery(sql,
					args.toArray(new String[args.size()]));
			while (cursor.moveToNext()) {
				int i = 0;
				result
						.add(new ShareEntity(cursor.getString(i++), cursor.getString(i++)));
			}
		} finally {
			cursor.close();
		}
		return result;
	}
}
