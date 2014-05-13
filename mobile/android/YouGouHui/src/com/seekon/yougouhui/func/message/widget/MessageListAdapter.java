package com.seekon.yougouhui.func.message.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.util.DateUtils;

public class MessageListAdapter extends EntityListAdapter<MessageEntity> {

	private static final int USER_ICON_WIDTH = 75;
	private static final int CONTENT_DISPLAY_LENGTH = 60;
	
	public MessageListAdapter(Context context, List<MessageEntity> dataList2) {
		super(context, dataList2);
	}

	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.my_message_item,
					null);

			holder.imageView = (ImageView) view.findViewById(R.id.sender_photo);
			holder.nameView = (TextView) view.findViewById(R.id.sender_name);
			holder.nameView.getPaint().setFakeBoldText(true);
			holder.contentView = (TextView) view.findViewById(R.id.mess_content);

			holder.imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
//			holder.imageView.setLayoutParams(new LinearLayout.LayoutParams(
//					USER_ICON_WIDTH, USER_ICON_WIDTH));
			LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(USER_ICON_WIDTH, USER_ICON_WIDTH);
			layoutParams.setMargins(10, 10, 0, 5);
			holder.imageView.setLayoutParams(layoutParams);
			
			holder.sendTimeView = (TextView) view.findViewById(R.id.send_time);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		MessageEntity message = (MessageEntity) getItem(position);
		ShopEntity shop = message.getSendShop();
		if (shop != null) {
			String userPhoto = shop.getShopImage();
			if (userPhoto != null && userPhoto.length() > 0) {
				ImageLoader.getInstance().displayImage(userPhoto, holder.imageView,
						true);
			} else {
				holder.imageView.setImageResource(R.drawable.default_user_photo);
			}

			holder.nameView.setText(shop.getName());
		} else {
			UserEntity sender = message.getSender();
			String userPhoto = sender.getPhoto();
			if (userPhoto != null && userPhoto.length() > 0) {
				ImageLoader.getInstance().displayImage(userPhoto, holder.imageView,
						true);
			} else {
				holder.imageView.setImageResource(R.drawable.default_user_photo);
			}

			holder.nameView.setText(sender.getName());
		}
		
		String content = message.getContent();
		int pos = content.indexOf("\n");
		if(pos > 0){
			content = content.substring(0, pos);
		}
		if(content.length() > CONTENT_DISPLAY_LENGTH){
			content = content.substring(0, CONTENT_DISPLAY_LENGTH - 3) + "...";
		}
		
		holder.contentView.setText(content);
		holder.sendTimeView.setText(DateUtils.formatTime_MMdd(message
				.getSendTime()));
		
		return view;
	}

	class ViewHolder {
		ImageView imageView;
		TextView nameView;
		TextView contentView;
		TextView sendTimeView;
	}
}
