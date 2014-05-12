package com.seekon.yougouhui.func.message.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class MessageListAdapter extends EntityListAdapter<MessageEntity> {

	public MessageListAdapter(Context context, List<MessageEntity> dataList2) {
		super(context, dataList2);
	}

	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.my_message_item, null);

			holder.imageView = (ImageView) view.findViewById(R.id.sender_photo);
			holder.nameView = (TextView) view.findViewById(R.id.sender_name);
			holder.contentView = (TextView) view.findViewById(R.id.mess_content);
			
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}
		
		MessageEntity message = (MessageEntity) getItem(position);
		UserEntity sender = message.getSender();
		String userPhoto = sender.getPhoto();
		if(userPhoto != null && userPhoto.length() > 0){
			ImageLoader.getInstance().displayImage(userPhoto, holder.imageView, true);
		}else{
			holder.imageView.setImageResource(R.drawable.default_user_photo);
		}
		
		holder.nameView.setText(sender.getName());
		holder.contentView.setText(message.getContent());
		
		return view;
	}

	class ViewHolder {
		ImageView imageView;
		TextView nameView;
		TextView contentView;
	}
}
