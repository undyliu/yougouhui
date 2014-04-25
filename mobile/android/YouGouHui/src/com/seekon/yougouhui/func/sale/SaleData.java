package com.seekon.yougouhui.func.sale;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_LOCATION;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_TITLE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_CHANNEL_ID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_DISCUSS_COUNT;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_END_DATE;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_PUBLISH_DATE;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_PUBLISH_TIME;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_ID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_SHOP_NAME;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_START_DATE;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_STATUS;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_TRADE_ID;
import static com.seekon.yougouhui.func.sale.SaleConst.COL_NAME_VISIT_COUNT;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.JSONObject;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.DateIndexedEntity;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.LocationUtils;
import com.seekon.yougouhui.util.Logger;

public class SaleData extends AbstractDBHelper {

	private final static String TAG = SaleData.class.getSimpleName();

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_TITLE, COL_NAME_CONTENT, COL_NAME_IMG, COL_NAME_SHOP_ID,
			COL_NAME_SHOP_NAME, COL_NAME_START_DATE, COL_NAME_END_DATE,
			COL_NAME_PUBLISHER, COL_NAME_PUBLISH_TIME, COL_NAME_PUBLISH_DATE,
			COL_NAME_TRADE_ID, COL_NAME_STATUS, COL_NAME_DISCUSS_COUNT,
			COL_NAME_VISIT_COUNT, COL_NAME_CHANNEL_ID, COL_NAME_LOCATION };

	public SaleData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + SaleConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + SaleConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_TITLE + " TEXT, "
				+ COL_NAME_CONTENT + " TEXT, " + COL_NAME_IMG + " TEXT, "
				+ COL_NAME_SHOP_ID + " TEXT, " + COL_NAME_SHOP_NAME + " TEXT, "
				+ COL_NAME_START_DATE + " TEXT, " + COL_NAME_END_DATE + " TEXT, "
				+ COL_NAME_PUBLISH_TIME + " TEXT, " + COL_NAME_PUBLISHER + " TEXT, "
				+ COL_NAME_TRADE_ID + " TEXT, " + COL_NAME_PUBLISH_DATE + " TEXT, "
				+ COL_NAME_STATUS + " TEXT, " + COL_NAME_CHANNEL_ID + " TEXT, "
				+ COL_NAME_LOCATION + " TEXT, " + COL_NAME_DISCUSS_COUNT + " INTEGER, "
				+ COL_NAME_VISIT_COUNT + " INTEGER)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		db.execSQL(" drop table if EXISTS " + SaleConst.TABLE_NAME);
		onCreate(db);
	}

	/**
	 * 按发布日期获取活动的条数
	 * 
	 * @param publisher
	 * @return
	 */
	public List<DateIndexedEntity> getSaleCountByPublishDate(String where,
			String[] whereArgs, String limitSql) {
		List<String> args = new ArrayList<String>();

		List<DateIndexedEntity> result = new ArrayList<DateIndexedEntity>();
		String sql = " select publish_date, count(1) from e_sale where 1=1 ";
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
	 * 根据发布日期获取活动数据列表
	 * 
	 * @param publishDate
	 * @param publisher
	 * @return
	 */
	public List<SaleEntity> getSaleListByPublishDate(String where,
			String[] whereArgs, String publishDate) {
		List<String> args = new ArrayList<String>();
		args.add(publishDate);

		List<SaleEntity> result = new ArrayList<SaleEntity>();
		String sql = " select s.uuid, title, img, content, visit_count, discuss_count, status, publisher, u.name as user_name"
				+ ",  shop_id, shop_name, location "
				+ " from e_sale s join e_user u on s.publisher = u.uuid "
				+ " where publish_date = ?  ";
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
				SaleEntity sale = new SaleEntity();
				sale.setUuid(cursor.getString(i++));
				sale.setTitle(cursor.getString(i++));
				sale.setImg(cursor.getString(i++));
				sale.setContent(cursor.getString(i++));
				sale.setVisitCount(cursor.getInt(i++));
				sale.setDiscussCount(cursor.getInt(i++));
				sale.setStatus(cursor.getString(i++));

				UserEntity publisher = new UserEntity();
				publisher.setUuid(cursor.getString(i++));
				publisher.setName(cursor.getString(i++));
				sale.setPublisher(publisher);

				ShopEntity shop = new ShopEntity();
				shop.setUuid(cursor.getString(i++));
				shop.setName(cursor.getString(i++));
				try {
					shop.setLocation(LocationUtils.fromJSONObject(new JSONObject(cursor
							.getString(i++))));
				} catch (Exception e) {
					Logger.warn(TAG, e.getMessage(), e);
				}

				sale.setShop(shop);

				result.add(sale);
			}
		} finally {
			cursor.close();
		}
		return result;
	}

	public SaleEntity getSale(String uuid) {
		SaleEntity sale = null;
		String sql = " select sa.uuid, title, content, start_date, end_date, trade_id, visit_count, discuss_count, sa.status, sa.img, publish_time "
				+ ", shop_id, shop_name, location"
				+ " from e_sale sa where sa.uuid = ? ";
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sql, new String[] { uuid });
			if (cursor.moveToNext()) {
				int i = 0;
				sale = new SaleEntity();
				sale.setUuid(cursor.getString(i++));
				sale.setTitle(cursor.getString(i++));
				sale.setContent(cursor.getString(i++));
				sale.setStartDate(cursor.getLong(i++));
				sale.setEndDate(cursor.getLong(i++));
				sale.setTradeId(cursor.getString(i++));
				sale.setVisitCount(cursor.getInt(i++));
				sale.setDiscussCount(cursor.getInt(i++));
				sale.setStatus(cursor.getString(i++));
				sale.setImg(cursor.getString(i++));
				sale.setPublishTime(cursor.getLong(i++));

				ShopEntity shop = new ShopEntity();
				shop.setUuid(cursor.getString(i++));
				shop.setName(cursor.getString(i++));
				try {
					shop.setLocation(LocationUtils.fromJSONObject(new JSONObject(cursor
							.getString(i++))));
				} catch (Exception e) {
					Logger.warn(TAG, e.getMessage(), e);
				}
				sale.setShop(shop);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return sale;
	}

	public List<SaleEntity> getSaleListByChannel(String channelId, String limitSql) {
		List<SaleEntity> result = new ArrayList<SaleEntity>();
		String selection = null;
		String[] selectionArgs = null;
		if (channelId != null) {// 全部
			selection = COL_NAME_CHANNEL_ID + "= ? ";
			selectionArgs = new String[] { channelId };
		}
		String sql = " select sa.uuid, title, content, start_date, end_date, trade_id, visit_count, discuss_count, sa.status, sa.img "
				+ ", shop_id, shop_name, location "
				+ " from e_sale sa  where status != '0'";
		if (selection != null) {
			sql += " and " + selection;
		}

		sql += " order by sa.publish_time desc ";// TODO根据距离进行排序处理

		if (limitSql != null) {
			sql += limitSql;
		}

		Cursor cursor = null;
		try {
			cursor = getReadableDatabase().rawQuery(sql, selectionArgs);
			while (cursor.moveToNext()) {
				int i = 0;
				SaleEntity sale = new SaleEntity();
				sale.setUuid(cursor.getString(i++));
				sale.setTitle(cursor.getString(i++));
				sale.setContent(cursor.getString(i++));
				sale.setStartDate(cursor.getLong(i++));
				sale.setEndDate(cursor.getLong(i++));
				sale.setTradeId(cursor.getString(i++));
				sale.setVisitCount(cursor.getInt(i++));
				sale.setDiscussCount(cursor.getInt(i++));
				sale.setStatus(cursor.getString(i++));
				sale.setImg(cursor.getString(i++));

				ShopEntity shop = new ShopEntity();
				shop.setUuid(cursor.getString(i++));
				shop.setName(cursor.getString(i++));
				try {
					shop.setLocation(LocationUtils.fromJSONObject(new JSONObject(cursor
							.getString(i++))));
				} catch (Exception e) {
					Logger.warn(TAG, e.getMessage(), e);
				}
				sale.setShop(shop);

				result.add(sale);
			}
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return result;
	}
}
