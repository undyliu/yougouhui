package com.seekon.yougouhui.func.message;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_RECEIVER;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SENDER;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SEND_SHOP;
import static com.seekon.yougouhui.func.message.MessageConst.COL_NAME_SEND_TIME;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.Logger;

public class MessageData extends AbstractDBHelper {

	private static final String TAG = MessageData.class.getSimpleName();

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_SENDER, COL_NAME_SEND_SHOP, COL_NAME_SEND_TIME,
			COL_NAME_RECEIVER, COL_NAME_CONTENT };

	public MessageData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		db.execSQL("CREATE TABLE IF NOT EXISTS " + MessageConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_SENDER + " TEXT, "
				+ COL_NAME_SEND_SHOP + " TEXT, " + COL_NAME_CONTENT + " TEXT, "
				+ COL_NAME_SEND_TIME + " INTEGER, " + COL_NAME_RECEIVER + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	private String getMessageSqlPart(JoinUser joinUser) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select m.uuid, m.send_time, m.content ");
		sb.append(" , u.uuid as user_id, u.phone, u.name as user_name, u.photo, u.register_time");
		sb.append(" , m.send_shop, s.name as shop_name, s.shop_img ");
		sb.append(" from e_message m ");
		sb.append(" left join e_shop s on m.send_shop = s.uuid");
		switch (joinUser) {
		case JOIN_SENDER:
			sb.append(" join e_user u on m.sender = u.uuid ");
			break;
		case JOIN_RECEIVER:
			sb.append(" join e_user u on m.receiver = u.uuid ");
			break;
		default:
			throw new RuntimeException("JoinUser 参数错误");
		}

		return sb.toString();
	}

	private MessageEntity assembleMessageEntity(Cursor cursor, JoinUser joinUser,
			UserEntity defUser) {
		int i = 0;
		MessageEntity message = new MessageEntity();
		message.setUuid(cursor.getString(i++));
		message.setSendTime(cursor.getLong(i++));
		message.setContent(cursor.getString(i++));

		UserEntity user = new UserEntity(cursor.getString(i++),
				cursor.getString(i++), cursor.getString(i++), null,
				cursor.getString(i++), cursor.getString(i++));
		switch (joinUser) {
		case JOIN_SENDER:
			message.setSender(user);
			message.setReceiver(defUser);
			break;
		case JOIN_RECEIVER:
			message.setReceiver(user);
			message.setSender(defUser);
			break;
		default:
			throw new RuntimeException("JoinUser 参数错误");
		}
		
		String shopId = cursor.getString(i++);
		if(shopId != null && shopId.trim().length() > 0){
			ShopEntity shop = new ShopEntity();
			shop.setUuid(shopId);
			shop.setName(cursor.getString(i++));
			shop.setShopImage(cursor.getString(i++));
			message.setSendShop(shop);
		}
		
		return message;
	}

	public List<MessageEntity> getMessageList(UserEntity sender,
			UserEntity receiver) {
		List<MessageEntity> dataList = new ArrayList<MessageEntity>();
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from ( ");
		sb.append(" select uuid, send_time, content, 1 from e_message ");
		sb.append(" where sender = ? and receiver = ? ");// 发送
		sb.append(" union all ");
		sb.append(" select uuid, send_time, content, 0 from e_message ");
		sb.append(" where sender = ? and receiver = ? ");// 接受
		sb.append(" ) order by send_time ");

		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(
					sb.toString(),
					new String[] { sender.getUuid(), receiver.getUuid(),
							receiver.getUuid(), sender.getUuid() });
			while (cursor.moveToNext()) {
				int i = 0;
				MessageEntity message = new MessageEntity();
				message.setUuid(cursor.getString(i++));
				message.setSendTime(cursor.getLong(i++));
				message.setContent(cursor.getString(i++));

				int type = cursor.getInt(i++);
				switch (type) {
				case 1:
					message.setSender(sender);
					message.setReceiver(receiver);
					break;
				case 0:
					message.setSender(receiver);
					message.setReceiver(sender);
					break;
				default:
					break;
				}

				dataList.add(message);
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

	public List<MessageEntity> getMaxMessageListByReceiver(UserEntity receiver) {
		List<MessageEntity> dataList = new ArrayList<MessageEntity>();
		StringBuffer sb = new StringBuffer();
		sb.append(" select * from (");

		sb.append(" select m.uuid, max(m.send_time) as send_time, m.content ");
		sb.append(" , u.uuid as user_id, u.phone, u.name as user_name, u.photo, u.register_time, 1");
		sb.append(" , m.send_shop, s.name as shop_name, s.shop_img ");
		sb.append(" from e_message m ");
		sb.append(" left join e_shop s on m.send_shop = s.uuid");
		sb.append(" join e_user u on m.sender = u.uuid ");
		sb.append("  where receiver = ? ");
		sb.append(" group by m.sender");

		// sb.append(" union all ");
		//
		// sb.append(" select m.uuid, max(m.send_time) as send_time, m.content ");
		// sb.append(" , u.uuid as user_id, u.phone, u.name as user_name, u.photo, u.register_time, 0");
		//sb.append(" , m.send_shop, s.name as shop_name, s.shop_img ");
		//sb.append(" from e_message m ");
		//sb.append(" left join e_shop s on m.send_shop = s.uuid");
		// sb.append(" join e_user u on m.receiver = u.uuid ");
		// sb.append("  where sender = ? ");
		// sb.append(" group by m.receiver");

		sb.append(") order by send_time");

		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sb.toString(),
					new String[] { receiver.getUuid() /* , receiver.getUuid() */});
			while (cursor.moveToNext()) {
				int i = 0;
				MessageEntity message = new MessageEntity();
				message.setUuid(cursor.getString(i++));
				message.setSendTime(cursor.getLong(i++));
				message.setContent(cursor.getString(i++));

				UserEntity user = new UserEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++), null,
						cursor.getString(i++), cursor.getString(i++));

				int type = cursor.getInt(i++);
				switch (type) {
				case 1:
					message.setSender(user);
					message.setReceiver(receiver);
					break;
				case 0:
					message.setSender(receiver);
					message.setReceiver(user);
					break;
				default:
					break;
				}

				String shopId = cursor.getString(i++);
				if(shopId != null && shopId.trim().length() > 0){
					ShopEntity shop = new ShopEntity();
					shop.setUuid(shopId);
					shop.setName(cursor.getString(i++));
					shop.setShopImage(cursor.getString(i++));
					message.setSendShop(shop);
				}
				
				dataList.add(message);
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

	public MessageEntity getMessageBySender(UserEntity sender, String uuid) {
		StringBuffer sb = new StringBuffer();
		sb.append(getMessageSqlPart(JoinUser.JOIN_RECEIVER));
		sb.append(" where m.uuid = ? ");

		Cursor cursor = null;
		try {
			cursor = getReadableDatabase().rawQuery(sb.toString(),
					new String[] { uuid });
			if (cursor.moveToNext()) {
				return assembleMessageEntity(cursor, JoinUser.JOIN_RECEIVER, sender);
			}
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
		return null;
	}

	enum JoinUser {
		JOIN_SENDER, JOIN_RECEIVER
	}
}
