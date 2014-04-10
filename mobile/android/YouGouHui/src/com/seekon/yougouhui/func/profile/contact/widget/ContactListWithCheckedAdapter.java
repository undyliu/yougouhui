package com.seekon.yougouhui.func.profile.contact.widget;

import java.util.List;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton.OnCheckedChangeListener;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.user.UserEntity;

public class ContactListWithCheckedAdapter extends ContactListAdapter {

	private OnCheckedChangeListener onCheckedChangeListener = null;

	public ContactListWithCheckedAdapter(Context mContext,
			List<UserEntity> contactList,
			OnCheckedChangeListener onCheckedChangeListener) {
		super(mContext, contactList);
		this.onCheckedChangeListener = onCheckedChangeListener;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup arg2) {
		View view = super.getView(position, convertView, arg2);
		ViewHolder viewHolder = (ViewHolder) view.getTag();
		if (viewHolder.checkBox == null) {
			viewHolder.checkBox = (CheckBox) view.findViewById(R.id.c_contact_user);
			viewHolder.checkBox.setVisibility(View.VISIBLE);
			viewHolder.checkBox.setId(position);
		} else {
			viewHolder.checkBox.setVisibility(View.VISIBLE);
		}

		if (onCheckedChangeListener != null) {
			viewHolder.checkBox.setOnCheckedChangeListener(onCheckedChangeListener);
		}
		return view;
	}

}
