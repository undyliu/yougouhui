package com.seekon.yougouhui.func.profile.contact.widget;

import android.content.Context;
import android.view.ActionProvider;
import android.view.LayoutInflater;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.PopupMenu.OnMenuItemClickListener;

import com.seekon.yougouhui.R;

public class FriendAddProvider extends ActionProvider {

	private Context context;

	PopupMenu mPopupMenu;

	public FriendAddProvider(Context context) {
		super(context);
		this.context = context;
	}

	@Override
	@Deprecated
	public View onCreateActionView() {
		LayoutInflater layoutInflater = LayoutInflater.from(context);
		View view = layoutInflater.inflate(R.layout.contact_add_friend_provider,
				null);
		ImageView popupView = (ImageView) view.findViewById(R.id.add_friend_view);
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
				// do someting
				return false;
			}

		});
		MenuInflater inflater = mPopupMenu.getMenuInflater();
		inflater.inflate(R.menu.contact_add_friend_pop, mPopupMenu.getMenu());
		mPopupMenu.show();
	}

}
