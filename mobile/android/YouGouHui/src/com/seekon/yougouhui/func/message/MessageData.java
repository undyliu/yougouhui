package com.seekon.yougouhui.func.message;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SENDER;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SEND_TIME;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_RECEIVER;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.Logger;

public class MessageData extends AbstractDBHelper {

	private static final String TAG = MessageData.class.getSimpleName();

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_SENDER, COL_NAME_SEND_TIME, COL_NAME_RECEIVER, COL_NAME_CONTENT };

	public MessageData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + MessageConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_SENDER + " TEXT, "
				+ COL_NAME_CONTENT + " TEXT, " + COL_NAME_SEND_TIME + " INTEGER, "
				+ COL_NAME_RECEIVER + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	private String getMessageSqlPart() {
		StringBuffer sb = new StringBuffer();
		sb.append(" select m.uuid, m.send_time, m.receiver, m.content ");
		sb.append(" , u.uuid as user_id, u.phone, u.name as user_name, u.photo, u.register_time");
		sb.append(" from e_message m ");
		sb.append(" join e_user u on m.sender = u.uuid ");
		return sb.toString();
	}

	private MessageEntity assembleMessageEntity(Cursor cursor) {
		int i = 0;
		MessageEntity message = new MessageEntity();
		message.setUuid(cursor.getString(i++));
		message.setSendTime(cursor.getLong(i++));
		message.setReceiver(cursor.getString(i++));
		message.setContent(cursor.getString(i++));

		UserEntity user = new UserEntity(cursor.getString(i++),
				cursor.getString(i++), cursor.getString(i++), null,
				cursor.getString(i++), cursor.getString(i++));
		message.setSender(user);
		return message;
	}

	public List<MessageEntity> getMessageListByReceiver(String receiver) {
		List<MessageEntity> dataList = new ArrayList<MessageEntity>();
		final String sql = getMessageSqlPart()
				+ " where receiver = ? order by send_time";

		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sql,
					new String[] { receiver });
			while (cursor.moveToNext()) {
				dataList.add(assembleMessageEntity(cursor));
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return dataList;
	}

	public List<MessageEntity> getMaxMessageListByReceiver(String receiver) {
		List<MessageEntity> dataList = new ArrayList<MessageEntity>();
		StringBuffer sb = new StringBuffer();
		sb.append(" select m.uuid, max(m.send_time), m.receiver, m.content ");
		sb.append(" , u.uuid as user_id, u.phone, u.name as user_name, u.photo, u.register_time");
		sb.append(" from e_message m ");
		sb.append(" join e_user u on m.sender = u.uuid ");
		sb.append("  where receiver = ? ");
		sb.append(" group by m.sender");
		sb.append(" order by m.sender");

		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sb.toString(),
					new String[] { receiver });
			while (cursor.moveToNext()) {
				dataList.add(assembleMessageEntity(cursor));
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return dataList;
	}
}
