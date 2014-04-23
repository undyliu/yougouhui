package com.seekon.yougouhui.func.shop.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.share.CommentEntity;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShopReplyEntity;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.util.DateUtils;

public class ShopShareListAdapter extends EntityListAdapter<ShareEntity> {

	public static final int PUBLISHER_IMAGE_WIDTH = 40;

	public static final int SHARE_IMAGE_WIDTH = 150;

	public ShopShareListAdapter(Context context, List<ShareEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {

		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.shop_share_item,
					null);

			holder.publisherPhoto = (ImageView) view
					.findViewById(R.id.publisher_photo);
			holder.publisherPhoto.setScaleType(ImageView.ScaleType.CENTER_CROP);
			holder.publisherPhoto.setLayoutParams(new LinearLayout.LayoutParams(
					PUBLISHER_IMAGE_WIDTH, PUBLISHER_IMAGE_WIDTH));

			holder.publisherName = (TextView) view.findViewById(R.id.publisher_name);
			holder.publisherName.getPaint().setFakeBoldText(true);

			holder.replyStatus = (TextView) view.findViewById(R.id.reply_status);
			holder.content = (TextView) view.findViewById(R.id.share_content);

			holder.shareImage = (ImageView) view.findViewById(R.id.share_image);
			holder.shareImage.setScaleType(ImageView.ScaleType.CENTER_CROP);
			holder.shareImage.setLayoutParams(new LinearLayout.LayoutParams(
					SHARE_IMAGE_WIDTH, SHARE_IMAGE_WIDTH));

			holder.shareImageCount = (TextView) view
					.findViewById(R.id.share_image_count);
			holder.publishDate = (TextView) view.findViewById(R.id.publish_date);
			holder.commentCount = (TextView) view.findViewById(R.id.comment_count);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		ShareEntity share = (ShareEntity) getItem(position);
		UserEntity publisher = share.getPublisher();

		String photo = publisher.getPhoto();
		if (photo != null && photo.length() > 0) {
			ImageLoader.getInstance()
					.displayImage(photo, holder.publisherPhoto, true);
		}
		holder.publisherName.setText(publisher.getName());

		holder.content.setText(share.getContent());

		List<FileEntity> images = share.getImages();
		if (images != null && images.size() > 0) {
			holder.shareImage.setVisibility(View.VISIBLE);
			ImageLoader.getInstance().displayImage(images.get(0).getAliasName(),
					holder.shareImage, true);

			holder.shareImageCount.setVisibility(View.VISIBLE);
			holder.shareImageCount.setText("共" + images.size() + "张");
		} else {
			holder.shareImage.setVisibility(View.GONE);
			holder.shareImageCount.setVisibility(View.GONE);
		}

		holder.publishDate
				.setText(DateUtils.formatTime_MMdd(share.getPublishTime()));

		List<CommentEntity> comments = share.getComments();
		int commentCount = comments == null ? 0 : comments.size();
		holder.commentCount.setText("共" + commentCount + "条评论");

		ShopReplyEntity reply = share.getShopReply();
		if (reply == null) {
			holder.replyStatus.setText(R.string.label_share_reply_no);
		} else {
			String status = reply.getStatus();
			if (DataConst.STATUS_AUDITED.equals(status)) {
				holder.replyStatus.setText(R.string.label_share_reply_status_valid);
			} else {
				holder.replyStatus.setText(R.string.label_share_reply_status_draft);
			}
		}

		return view;
	}

	class ViewHolder {
		ImageView publisherPhoto;
		TextView publisherName;
		TextView replyStatus;
		TextView content;
		ImageView shareImage;
		TextView shareImageCount;
		TextView publishDate;
		TextView commentCount;
	}
}
