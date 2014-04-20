package com.seekon.yougouhui.func.profile.share.widget;

import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.MyShareActivity;
import com.seekon.yougouhui.activity.profile.ShareDetailActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareEntity;

public class MyShareItemListAdapter extends BaseAdapter {

	private static final int SHARE_IMAGE_WIDHT = 100;

	private Activity activity;

	private List<ShareEntity> shareList;

	public MyShareItemListAdapter(Activity activity, List<ShareEntity> shareList) {
		super();
		this.activity = activity;
		this.shareList = shareList;
	}

	@Override
	public View getView(int position, View view, ViewGroup parent) {

		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(activity).inflate(R.layout.my_share_item,
					null, false);
			holder.view = view;
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		final ShareEntity share = (ShareEntity) getItem(position);

		view.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(activity, ShareDetailActivity.class);
				intent.putExtra(ShareConst.COL_NAME_SHARE_ID, share.getUuid());
				activity.startActivityForResult(intent,
						MyShareActivity.SHARE_DETAIL_REQUEST_RESULT_CODE);
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

	@Override
	public int getCount() {
		return shareList.size();
	}

	@Override
	public Object getItem(int position) {
		return shareList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	class ViewHolder {
		View view;
	}
}
