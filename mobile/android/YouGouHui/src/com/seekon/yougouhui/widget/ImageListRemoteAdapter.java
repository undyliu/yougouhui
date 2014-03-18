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
import com.seekon.yougouhui.util.RemoteImageHelper;

/**
 * 包含有Image的ListView的Adapter适配器
 * 通过多线程的方式远程下载Image
 * @author undyliu
 *
 */
public class ImageListRemoteAdapter extends SimpleAdapter{

	public ImageListRemoteAdapter(Context context, List<? extends Map<String, ?>> data,
			int resource, String[] from, int[] to) {
		super(context, data, resource, from, to);
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = super.getView(position, convertView, parent);
		Map record = (Map) getItem(position);

		String recordImg = (String) record.get(COL_NAME_IMG);
		if (recordImg != null && recordImg.trim().length() > 0) {
			ImageView imageView = (ImageView) view.findViewById(R.id.img_id);

			RemoteImageHelper.loadImage(imageView, recordImg);
		}
		return view;
	}
}
