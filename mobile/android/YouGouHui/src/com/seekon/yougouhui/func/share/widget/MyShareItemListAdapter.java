package com.seekon.yougouhui.func.share.widget;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.share.MyShareActivity;
import com.seekon.yougouhui.activity.share.ShareDetailActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class MyShareItemListAdapter extends EntityListAdapter<ShareEntity> {

	private static final int SHARE_IMAGE_WIDHT = 100;

	public MyShareItemListAdapter(Context context, List<ShareEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {

		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.my_share_item, null,
					false);
			holder.view = view;
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		final ShareEntity share = (ShareEntity) getItem(position);

		view.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ShareDetailActivity.class);
				intent.putExtra(ShareConst.COL_NAME_SHARE_ID, share.getUuid());
				if (context instanceof Activity) {
					((Activity) context).startActivityForResult(intent,
							MyShareActivity.SHARE_DETAIL_REQUEST_RESULT_CODE);
				} else {
					context.startActivity(intent);
				}
			}
		});

		TextView contentView = (TextView) view
				.findViewById(R.id.share_item_content);
		contentView.setText(share.getContent());

		TextView imageCountView = (TextView) view
				.findViewById(R.id.share_item_image_count);
		ImageView imageView = (ImageView) view.findViewById(R.id.share_item_image);
		List<FileEntity> imageFiles = share.getImages();
		if (imageFiles.size() > 0) {
			imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			imageView.setLayoutParams(new LinearLayout.LayoutParams(
					SHARE_IMAGE_WIDHT, SHARE_IMAGE_WIDHT));
			imageView.setVisibility(View.VISIBLE);
			String fileUri = imageFiles.get(0).getFileUri();
			if (fileUri != null) {
				imageView.setImageBitmap(FileHelper.decodeFile(fileUri, true,
						SHARE_IMAGE_WIDHT, SHARE_IMAGE_WIDHT));
			} else {
				ImageLoader.getInstance().displayImage(
						imageFiles.get(0).getAliasName(), imageView, true);
			}

			imageCountView.setVisibility(View.VISIBLE);
			imageCountView.setText("共" + imageFiles.size() + "张");
		} else {
			imageView.setVisibility(View.GONE);
			imageCountView.setVisibility(View.GONE);
		}

		return view;
	}

	class ViewHolder {
		View view;
	}
}
