package com.seekon.yougouhui.func.profile.widget;

import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.MyShareActivity;
import com.seekon.yougouhui.activity.profile.ShareDetailActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.widget.ShareUtils;

public class MyShareItemListAdapter extends SimpleAdapter {

	private Activity activity;

	public MyShareItemListAdapter(Activity activity,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(activity, data, resource, from, to);
		this.activity = activity;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		final Map share = (Map) getItem(position);

		view.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(activity, ShareDetailActivity.class);
				intent.putExtra(ShareConst.COL_NAME_SHARE_ID,
						(String) share.get(DataConst.COL_NAME_UUID));
				activity.startActivityForResult(intent,
						MyShareActivity.SHARE_DETAIL_REQUEST_RESULT_CODE);
			}
		});
		
		TextView contentView = (TextView) view.findViewById(R.id.share_item_content);
		contentView.setText((String)share.get(DataConst.COL_NAME_CONTENT));
		
		TextView imageCountView = (TextView) view.findViewById(R.id.share_item_image_count);
		ImageView imageView = (ImageView) view.findViewById(R.id.share_item_image);
		List<String> imageUrls = (List<String>) share
				.get(ShareConst.DATA_IMAGE_KEY);
		if (imageUrls.size() > 0) {
			imageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
			imageView.setLayoutParams(new LinearLayout.LayoutParams(
					ShareUtils.PUBLISHER_IMAGE_WIDTH, ShareUtils.PUBLISHER_IMAGE_WIDTH));
			imageView.setVisibility(View.VISIBLE);
			ImageLoader.getInstance().displayImage(imageUrls.get(0), imageView, true);
			
			imageCountView.setVisibility(View.VISIBLE);
			imageCountView.setText(imageUrls.size() + "张");
		} else {
			imageView.setVisibility(View.GONE);
			imageCountView.setVisibility(View.GONE);
		}

		return view;
	}

}
