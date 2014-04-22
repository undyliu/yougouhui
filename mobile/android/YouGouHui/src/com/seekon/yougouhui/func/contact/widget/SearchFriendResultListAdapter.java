package com.seekon.yougouhui.func.contact.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.contact.AddFriendActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.contact.AddFriendTask;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.UserClickListener;

public class SearchFriendResultListAdapter extends EntityListAdapter<UserEntity> {

	public SearchFriendResultListAdapter(Context context,
			List<UserEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder viewHolder = null;
		if (view == null) {
			viewHolder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.catalog_list_item,
					null);
			viewHolder.view = view;
			view.setTag(viewHolder);
		} else {
			viewHolder = (ViewHolder) view.getTag();
		}

		final UserEntity user = (UserEntity) this.getItem(position);
		boolean isFriend = false;
		if (RunEnv.getInstance().getUser().getFriends().contains(user)) {
			isFriend = true;
		}

		TextView userNameView = (TextView) view
				.findViewById(R.id.contact_user_name);
		userNameView.setText(user.getName());

		
		final Button addFriend = (Button) view.findViewById(R.id.b_add_friend);
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

		ImageView userPhotoView = (ImageView) view
				.findViewById(R.id.contact_user_photo);
		userPhotoView.setLayoutParams(new LinearLayout.LayoutParams(60, 60));

		String userPhoto = user.getPhoto();
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto, userPhotoView, true);
		}

		if(context instanceof Activity){
			UserClickListener userListener = new UserClickListener(user, (Activity) context,
					AddFriendActivity.OPEN_FRIEND_REQUEST_CODE);
			userNameView.setOnClickListener(userListener);
			userPhotoView.setOnClickListener(userListener);
		}
		return view;
	}

	final static class ViewHolder {
		View view;
	}

	private void addFriend(final UserEntity friend, final Button addFriend) {
		new AddFriendTask(context, friend, addFriend).execute((Void) null);
	}
}