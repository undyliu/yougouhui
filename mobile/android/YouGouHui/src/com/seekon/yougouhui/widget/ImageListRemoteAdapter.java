package com.seekon.yougouhui.widget;

import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.file.ImageLoader;

/**
 * 包含有Image的ListView的Adapter适配器 通过多线程的方式远程下载Image
 * 
 * @author undyliu
 * 
 */
public class ImageListRemoteAdapter extends BaseAdapter {

	private Context context;
	private List<String> imageList;
	private int iconWidth = 0;

	public ImageListRemoteAdapter(Context context, List<String> imageList,
			int iconWidth) {
		super();
		this.context = context;
		this.imageList = imageList;
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
		holder.imageView.setScaleType(ImageView.ScaleType.CENTER);

		final String image = imageList.get(position);
		if (image != null && image.trim().length() > 0) {
			holder.imageView.setVisibility(ImageView.VISIBLE);
			ImageLoader.getInstance().displayImage(image, holder.imageView, true);
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

	@Override
	public int getCount() {
		return imageList.size();
	}

	@Override
	public Object getItem(int position) {
		return imageList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		ImageView imageView;
	}
}
