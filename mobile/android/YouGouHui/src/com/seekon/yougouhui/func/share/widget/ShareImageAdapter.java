package com.seekon.yougouhui.func.share.widget;

import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ImageView;

import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

public class ShareImageAdapter extends EntityListAdapter<FileEntity> {

	public static final int IMAGE_VIEW_WIDTH = 100;

	public ShareImageAdapter(Context context, List<FileEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		ImageView imageView;
		if (convertView == null) {
			imageView = new ImageView(context);

			GridView.LayoutParams lp = new GridView.LayoutParams(IMAGE_VIEW_WIDTH,
					IMAGE_VIEW_WIDTH);

			imageView.setLayoutParams(lp);
			imageView.setAdjustViewBounds(false);
			imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			imageView.setPadding(8, 8, 8, 8);
		} else {
			imageView = (ImageView) convertView;
		}

		final FileEntity image = (FileEntity) this.getItem(position);
		String fileUri = image.getFileUri();
		if (fileUri != null) {
			imageView.setImageBitmap(FileHelper.decodeFile(fileUri, true,
					IMAGE_VIEW_WIDTH, IMAGE_VIEW_WIDTH));
		} else {
			ImageLoader.getInstance().displayImage(image.getAliasName(), imageView,
					true);
		}

		imageView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
				intent
						.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, position);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);

				context.startActivity(intent);
			}
		});

		return imageView;
	}

}
