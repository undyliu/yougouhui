package com.seekon.yougouhui.widget;

import java.util.ArrayList;
import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;

import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.file.ImageLoader;

public class ShareImageAdapter extends BaseAdapter {

	public static final int IMAGE_VIEW_WIDTH  = 100;
	
	private Context mContext;

	private List<String> images;

	public ShareImageAdapter(Context mContext, List<String> images) {
		super();
		this.mContext = mContext;
		this.images = images;
		if (images == null) {
			this.images = new ArrayList<String>();
		}
	}

	@Override
	public int getCount() {
		return images.size();
	}

	@Override
	public Object getItem(int position) {
		return images.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(final int position, View convertView, ViewGroup parent) {
		ImageView imageView;
		if (convertView == null) {
			imageView = new ImageView(mContext);
			
			GridView.LayoutParams lp = new GridView.LayoutParams(IMAGE_VIEW_WIDTH, IMAGE_VIEW_WIDTH);
			
			imageView.setLayoutParams(lp);
			imageView.setAdjustViewBounds(false);
			imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			imageView.setPadding(8, 8, 8, 8);
		} else {
			imageView = (ImageView) convertView;
		}

		final String image = (String) this.getItem(position);
		ImageLoader.getInstance().displayImage(image, imageView, true);
		imageView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(mContext, ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, image);
				intent
						.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, position);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);

				mContext.startActivity(intent);
			}
		});

		return imageView;
	}

}
