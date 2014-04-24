package com.seekon.yougouhui.func.contact.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.contact.AddFriendActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.contact.AddFriendTask;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.UserClickListener;

public class SearchFriendResultListAdapter extends FriendListAdapter {

	public SearchFriendResultListAdapter(Context context,
			List<UserEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		ViewHolder viewHolder = (ViewHolder) view.getTag();

		final UserEntity user = (UserEntity) this.getItem(position);
		boolean isFriend = false;
		if (RunEnv.getInstance().getUser().getFriends().contains(user)) {
			isFriend = true;
		}

		final Button addFriend = viewHolder.addFriend;
		addFriend.setVisibility(View.VISIBLE);
		addFriend.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				addFriend(user, addFriend);
			}
		});
		if (isFriend) {
			addFriend.setText(R.string.b_title_allready_friends);
			addFriend.setEnabled(false);
		} else {
			addFriend.setText(R.string.b_title_add_friend);
			addFriend.setEnabled(true);
		}

		if (context instanceof Activity) {
			UserClickListener userListener = new UserClickListener(user,
					(Activity) context, AddFriendActivity.OPEN_FRIEND_REQUEST_CODE);
			viewHolder.userNameView.setOnClickListener(userListener);
			viewHolder.userPhotoView.setOnClickListener(userListener);
		}
		return view;
	}

	private void addFriend(final UserEntity friend, final Button addFriend) {
		new AddFriendTask(context, friend, addFriend).execute((Void) null);
	}
}