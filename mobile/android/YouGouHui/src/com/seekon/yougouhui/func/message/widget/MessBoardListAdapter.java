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
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.message.MessageEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class MessBoardListAdapter extends EntityListAdapter<MessageEntity> {

	private static final int USER_ICON_WIDTH = 60;
	
	public MessBoardListAdapter(Context context, List<MessageEntity> dataList2) {
		super(context, dataList2);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.message_board_item,
					null);

			holder.senderPhoto = (ImageView) view.findViewById(R.id.sender_photo);
			holder.sendContent = (TextView) view.findViewById(R.id.send_content);
			holder.receiverPhoto = (ImageView) view.findViewById(R.id.receiver_photo);
			holder.receiveContent = (TextView) view.findViewById(R.id.receive_content);
			
			holder.senderPhoto.setScaleType(ImageView.ScaleType.CENTER_CROP);
			holder.senderPhoto.setLayoutParams(new LinearLayout.LayoutParams(
					USER_ICON_WIDTH, USER_ICON_WIDTH));
			holder.receiverPhoto.setScaleType(ImageView.ScaleType.CENTER_CROP);
			holder.receiverPhoto.setLayoutParams(new LinearLayout.LayoutParams(
					USER_ICON_WIDTH, USER_ICON_WIDTH));
			
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		UserEntity curUser = RunEnv.getInstance().getUser(); 
		MessageEntity message = (MessageEntity) getItem(position);
		if(curUser.equals(message.getSender())){
			setViewVisible(holder, true);
			
			String userPhoto = curUser.getPhoto();
			if(userPhoto != null && userPhoto.length() > 0){
				ImageLoader.getInstance().displayImage(userPhoto, holder.senderPhoto, true);
			}else{
				holder.senderPhoto.setImageResource(R.drawable.default_user_photo);
			}
			
			holder.sendContent.setText(message.getContent());
		}else{
			setViewVisible(holder, false);
			
			String userPhoto = curUser.getPhoto();
			if(userPhoto != null && userPhoto.length() > 0){
				ImageLoader.getInstance().displayImage(userPhoto, holder.receiverPhoto, true);
			}else{
				holder.receiverPhoto.setImageResource(R.drawable.default_user_photo);
			}
			
			holder.receiveContent.setText(message.getContent());
		}
		
		return view;
	}

	private void setViewVisible(ViewHolder holder, boolean sender){
		if(sender){
			holder.receiverPhoto.setVisibility(View.GONE);
			holder.receiveContent.setVisibility(View.GONE);
			
			holder.senderPhoto.setVisibility(View.VISIBLE);
			holder.sendContent.setVisibility(View.VISIBLE);
		}else{
			holder.receiverPhoto.setVisibility(View.VISIBLE);
			holder.receiveContent.setVisibility(View.VISIBLE);
			
			holder.senderPhoto.setVisibility(View.GONE);
			holder.sendContent.setVisibility(View.GONE);
		}
	}
	
	class ViewHolder {
		ImageView senderPhoto;
		TextView sendContent;
		ImageView receiverPhoto;
		TextView receiveContent;
	}
}
