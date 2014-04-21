package com.seekon.yougouhui.func.contact.widget;

import java.lang.reflect.Field;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.view.ActionProvider;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.PopupMenu.OnMenuItemClickListener;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.contact.AddFriendTask;
import com.seekon.yougouhui.func.contact.DeleteFriendTask;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

public class FriendProfileActionProvider extends ActionProvider {

	private Context context;

	PopupMenu mPopupMenu;

	private UserEntity friend = null;

	public FriendProfileActionProvider(Context context) {
		super(context);
		this.context = context;
	}

	@Override
	@Deprecated
	public View onCreateActionView() {
		LayoutInflater layoutInflater = LayoutInflater.from(context);
		View view = layoutInflater.inflate(R.layout.action_add_provider, null);
		ImageView popupView = (ImageView) view.findViewById(R.id.action_add_view);
		popupView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				showPopup(v);
			}
		});
		return view;
	}

	/**
	 * show the popup menu.
	 * 
	 * @param v
	 */
	private void showPopup(View v) {
		setFriendFromContext();
		if (RunEnv.getInstance().getUser().equals(friend)) {// TODO:
			return;
		}

		mPopupMenu = new PopupMenu(context, v);
		mPopupMenu.setOnMenuItemClickListener(new OnMenuItemClickListener() {

			@Override
			public boolean onMenuItemClick(MenuItem item) {
				int itemId = item.getItemId();
				switch (itemId) {
				case R.id.menu_add_friend:
					addFriend(item);
					break;
				case R.id.menu_del_friend:
					deleteFriend(item);
					break;
				default:
					break;
				}
				return false;
			}

		});

		Menu menu = mPopupMenu.getMenu();
		MenuInflater inflater = mPopupMenu.getMenuInflater();
		inflater.inflate(R.menu.friend_profile_pop, menu);

		List<UserEntity> friends = RunEnv.getInstance().getUser().getFriends();
		if (friends.contains(friend)) {
			MenuItem item = menu.findItem(R.id.menu_add_friend);
			item.setVisible(false);
		} else {
			MenuItem item = menu.findItem(R.id.menu_del_friend);
			item.setVisible(false);
		}
		mPopupMenu.show();
	}

	private void setFriendFromContext() {
		try {
			Field field = context.getClass().getDeclaredField("mBase");
			field.setAccessible(true);
			Activity activity = (Activity) field.get(context);
			friend = (UserEntity) activity.getIntent().getSerializableExtra(
					UserConst.DATA_KEY_USER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void addFriend(MenuItem item) {
		new AddFriendTask(context, friend, item).execute((Void) null);
	}

	private void deleteFriend(MenuItem item) {
		new DeleteFriendTask(context, friend, item).execute((Void) null);
	}
}
