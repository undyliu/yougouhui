package com.seekon.yougouhui.widget;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_IMG;

import java.util.List;
import java.util.Map;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.SimpleAdapter;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;

/**
 * 包含有Image的ListView的Adapter适配器 通过多线程的方式远程下载Image
 * 
 * @author undyliu
 * 
 */
public class ImageListRemoteAdapter extends SimpleAdapter {

	public ImageListRemoteAdapter(Context context,
			List<? extends Map<String, ?>> data, int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		//
		// ViewHolder holder = null;
		// if(convertView == null){
		// holder = new ViewHolder();
		// convertView = LayoutInflater.from(context).inflate(mResource, null,
		// false);
		// holder.imageView = (ImageView) convertView.findViewById(R.id.img_id);
		// convertView.setTag(holder);
		// }else{
		// holder = (ViewHolder) convertView.getTag();
		// }
		//
		// Map record = (Map) getItem(position);
		// String recordImg = (String) record.get(COL_NAME_IMG);
		// if (recordImg != null && recordImg.trim().length() > 0) {
		// holder.imageView.setVisibility(ImageView.VISIBLE);
		// imageLoader.displayImage(Const.SERVER_APP_URL + recordImg,
		// holder.imageView);
		// }else{
		// if(holder != null && holder.imageView != null){
		// holder.imageView.setVisibility(ImageView.INVISIBLE);
		// }
		// }
		//
		// return convertView;

		View view = super.getView(position, convertView, parent);
		ImageView imageView = (ImageView) view.findViewById(R.id.img_id);

		Map record = (Map) getItem(position);
		String recordImg = (String) record.get(COL_NAME_IMG);
		if (recordImg != null && recordImg.trim().length() > 0) {
			imageView.setVisibility(ImageView.VISIBLE);
			ImageLoader.getInstance().displayImage(recordImg, imageView, true);
		} else {
			if (imageView != null) {
				imageView.setVisibility(ImageView.INVISIBLE);
			}
		}
		return view;
	}

	// class ViewHolder{
	// ImageView imageView;
	// }
}
