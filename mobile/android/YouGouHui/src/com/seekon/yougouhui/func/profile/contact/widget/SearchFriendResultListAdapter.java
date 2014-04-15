package com.seekon.yougouhui.func.profile.contact.widget;

import java.util.List;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.contact.AddFriendActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.widget.UserClickListener;
import com.seekon.yougouhui.func.profile.contact.AddFriendTask;
import com.seekon.yougouhui.func.user.UserEntity;

public class SearchFriendResultListAdapter extends BaseAdapter {
	private final String TAG = SearchFriendResultListAdapter.class
			.getSimpleName();

	private Activity context;
	private List<UserEntity> searchResultList = null;

	public SearchFriendResultListAdapter(Activity context,
			List<UserEntity> searchResultList) {
		super();
		this.context = context;
		this.searchResultList = searchResultList;
	}

	@Override
	public int getCount() {
		return searchResultList.size();
	}

	@Override
	public Object getItem(int position) {
		return searchResultList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
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

		UserClickListener userListener = new UserClickListener(user, context,
				AddFriendActivity.OPEN_FRIEND_REQUEST_CODE);

		TextView userNameView = (TextView) view
				.findViewById(R.id.contact_user_name);
		userNameView.setText(user.getName());
		userNameView.setOnClickListener(userListener);

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
		userPhotoView.setOnClickListener(userListener);

		String userPhoto = user.getPhoto();
		if (userPhoto != null && userPhoto.length() > 0) {
			ImageLoader.getInstance().displayImage(userPhoto, userPhotoView, true);
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