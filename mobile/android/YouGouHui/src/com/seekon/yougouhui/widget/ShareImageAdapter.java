package com.seekon.yougouhui.widget;

import java.util.ArrayList;
import java.util.List;

import com.seekon.yougouhui.file.ImageLoader;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;

public class ShareImageAdapter extends BaseAdapter {

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
	public View getView(int position, View convertView, ViewGroup parent) {
		ImageView imageView;
		if (convertView == null) {
			imageView = new ImageView(mContext);
			//imageView.setLayoutParams(new GridView.LayoutParams(100, 100));// 设置ImageView宽高
			imageView.setAdjustViewBounds(false);
			imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			imageView.setPadding(8, 8, 8, 8);
		} else {
			imageView = (ImageView) convertView;
		}

		String image = (String) this.getItem(position);
		ImageLoader.getInstance().displayImage(image, imageView, true);

		return imageView;
	}

}
