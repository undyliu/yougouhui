package com.seekon.yougouhui.widget;

import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.ImageView;

import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.widget.EntityListAdapter;

/**
 * 包含有Image的ListView的Adapter适配器 通过多线程的方式远程下载Image
 * 
 * @author undyliu
 * 
 */
public class ImageListRemoteAdapter extends EntityListAdapter<FileEntity> {

	private int iconWidth = 0;

	public ImageListRemoteAdapter(Context context, List<FileEntity> imageList,
			int iconWidth) {
		super(context, imageList);
		this.iconWidth = iconWidth;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {

		ViewHolder holder = null;
		if (convertView == null) {
			holder = new ViewHolder();
			convertView = new ImageView(context);
			holder.imageView = (ImageView) convertView;
			convertView.setTag(holder);
		} else {
			holder = (ViewHolder) convertView.getTag();
		}

		holder.imageView.setLayoutParams(new AbsListView.LayoutParams(iconWidth,
				iconWidth));
		holder.imageView.setAdjustViewBounds(false);
		holder.imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		final FileEntity image = (FileEntity) getItem(position);
		String fileUrl = image.getFileUri();
		String aliasName = image.getAliasName();

		if (fileUrl != null && fileUrl.trim().length() > 0) {
			holder.imageView.setVisibility(ImageView.VISIBLE);
			holder.imageView.setImageBitmap(FileHelper.decodeFile(fileUrl, true,
					iconWidth, iconWidth));
		} else if (aliasName != null && aliasName.trim().length() > 0) {
			holder.imageView.setVisibility(ImageView.VISIBLE);
			ImageLoader.getInstance().displayImage(aliasName, holder.imageView, true);
		} else {
			holder.imageView.setVisibility(ImageView.INVISIBLE);
		}

		holder.imageView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
				intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, 0);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);

				context.startActivity(intent);
			}
		});

		return holder.imageView;
	}

	class ViewHolder {
		ImageView imageView;
	}
}
