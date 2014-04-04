package com.seekon.yougouhui.func.discover.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.discover.share.CommentConst.COL_NAME_COMMENT_ID;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISHER;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_PUBLISH_TIME;
import static com.seekon.yougouhui.func.discover.share.ShareConst.COL_NAME_SHARE_ID;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.seekon.yougouhui.db.AbstractDBHelper;
import com.seekon.yougouhui.func.user.UserEntity;

public class CommentData extends AbstractDBHelper {

	public static final String[] COL_NAMES = new String[] { COL_NAME_UUID,
			COL_NAME_CONTENT, COL_NAME_SHARE_ID, COL_NAME_PUBLISHER,
			COL_NAME_PUBLISH_TIME, COL_NAME_COMMENT_ID };

	public CommentData(Context context) {
		super(context);
	}

	@Override
	public void onCreate(SQLiteDatabase db) {
		// db.execSQL(" drop table if EXISTS " + CommentConst.TABLE_NAME);
		db.execSQL("CREATE TABLE IF NOT EXISTS " + CommentConst.TABLE_NAME + " ("
				+ COL_NAME_UUID + " TEXT PRIMARY KEY, " + COL_NAME_CONTENT + " TEXT, "
				+ COL_NAME_SHARE_ID + " TEXT, " + COL_NAME_PUBLISHER + " TEXT, "
				+ COL_NAME_PUBLISH_TIME + " TEXT, " + COL_NAME_COMMENT_ID + " TEXT)");
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

	}

	public List<CommentEntity> getCommentData(String shareId) {
		List<CommentEntity> commentList = new ArrayList<CommentEntity>();
		String sql = " select c.uuid, c.content, c.publish_time, c.publisher, u.name as publisher_name, u.photo as publisher_photo "
				+ " from e_comment c left join e_user u on c.publisher = u.uuid "
				+ " where c.share_id = ? order by c.publish_time desc ";
		Cursor cursor = null;
		try {
			cursor = this.getReadableDatabase().rawQuery(sql,
					new String[] { shareId });
			while (cursor.moveToNext()) {
				int i = 0;
				CommentEntity comment = new CommentEntity(cursor.getString(i++),
						cursor.getString(i++));
				comment.setPublishTime(cursor.getLong(i++));
				UserEntity user = new UserEntity(cursor.getString(i++), null,
						cursor.getString(i++), null, cursor.getString(i++));
				comment.setPublisher(user);
				commentList.add(comment);
			}
		} finally {
			cursor.close();
		}
		return commentList;
	}
}
