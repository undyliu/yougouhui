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
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.func.widget.UserClickListener;

public class FriendListAdapter extends EntityListAdapter<UserEntity> {

	public FriendListAdapter(Context context, List<UserEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder viewHolder = null;
		if (view == null) {
			viewHolder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.catalog_list_item,
					null);
			viewHolder.userNameView = (TextView) view
					.findViewById(R.id.contact_user_name);
			viewHolder.userPhotoView = (ImageView) view
					.findViewById(R.id.contact_user_photo);
			viewHolder.userPhotoView.setLayoutParams(new LinearLayout.LayoutParams(
					60, 60));
			viewHolder.addFriend = (Button) view.findViewById(R.id.b_add_friend);
			view.setTag(viewHolder);
		} else {
			viewHolder = (ViewHolder) view.getTag();
		}

		final UserEntity user = (UserEntity) this.getItem(position);

		viewHolder.userNameView.setText(user.getName());

		String userPhoto = user.getPhoto();
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto,
					viewHolder.userPhotoView, true);
		}

		if (context instanceof Activity) {
			UserClickListener userListener = new UserClickListener(user,
					(Activity) context, AddFriendActivity.OPEN_FRIEND_REQUEST_CODE);
			viewHolder.userNameView.setOnClickListener(userListener);
			viewHolder.userPhotoView.setOnClickListener(userListener);
		}

		viewHolder.addFriend.setVisibility(View.GONE);

		return view;
	}

	final static class ViewHolder {
		TextView userNameView;
		ImageView userPhotoView;
		Button addFriend;
	}

}
