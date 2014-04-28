package com.seekon.yougouhui.func.widget;

import java.lang.reflect.Field;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
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
import com.seekon.yougouhui.activity.MainActivity;
import com.seekon.yougouhui.activity.contact.AddFriendActivity;
import com.seekon.yougouhui.activity.share.ShareActivity;
import com.seekon.yougouhui.activity.user.RegisterActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.user.UserConst;
import com.seekon.yougouhui.func.user.UserEntity;

public class MainActionAddProvider extends ActionProvider {

	private Context context;

	PopupMenu mPopupMenu;

	public MainActionAddProvider(Context context) {
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
		mPopupMenu = new PopupMenu(context, v);
		mPopupMenu.setOnMenuItemClickListener(new OnMenuItemClickListener() {

			@Override
			public boolean onMenuItemClick(MenuItem item) {
				int itemId = item.getItemId();
				switch (itemId) {
				case R.id.menu_add_friend:
					addFriend();
					break;
				case R.id.menu_publish_share:
					publishShare();
					break;
				case R.id.menu_register_user:
					registerUser();
					break;
				default:
					break;
				}
				return false;
			}

		});
		
		Menu menu = mPopupMenu.getMenu();
		MenuInflater inflater = mPopupMenu.getMenuInflater();
		inflater.inflate(R.menu.main_more_pop, menu);
		
		String userType = RunEnv.getInstance().getUser().getType();
		if(UserConst.TYPE_USER_ANONYMOUS.equals(userType)){
			menu.findItem(R.id.menu_add_friend).setVisible(false);
		}else{
			menu.findItem(R.id.menu_register_user).setVisible(false);
		}
		
		mPopupMenu.show();
	}

	private void registerUser(){
		Activity activity = getAttachedActivity();
		if(activity != null){
			Intent intent = new Intent(activity, RegisterActivity.class);
			activity.startActivityForResult(intent, MainActivity.REGISTER_USER_REQUEST_CODE);
		}else{
			Intent intent = new Intent(context, RegisterActivity.class);
			context.startActivity(intent);
		}
	}
	
	private void addFriend() {
		Intent intent = new Intent(context, AddFriendActivity.class);
		context.startActivity(intent);
	}

	private void publishShare() {
		Intent intent = new Intent(context, ShareActivity.class);
		context.startActivity(intent);
	}
	
	private Activity getAttachedActivity() {
		try {
			Field field = context.getClass().getDeclaredField("mBase");
			field.setAccessible(true);
			return (Activity) field.get(context);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
