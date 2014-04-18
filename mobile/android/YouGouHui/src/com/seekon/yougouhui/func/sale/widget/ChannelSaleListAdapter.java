package com.seekon.yougouhui.func.sale.widget;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.sale.SaleEntity;

public class ChannelSaleListAdapter extends BaseAdapter {
	private static final int SALE_IMAGE_WIDTH = 150;
	private Context context;
	private List<SaleEntity> saleList;

	public ChannelSaleListAdapter(Context context, List<SaleEntity> saleList) {
		super();
		this.context = context;
		this.saleList = saleList;
	}

	@Override
	public int getCount() {
		return saleList.size();
	}

	@Override
	public Object getItem(int position) {
		return saleList.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	public void updateData(List<SaleEntity> saleList) {
		this.saleList = saleList;
		this.notifyDataSetChanged();
	}

	@Override
	public View getView(int postition, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.channel_sale_item,
					null, false);
			holder.view = view;
			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		SaleEntity sale = saleList.get(postition);

		TextView titleView = (TextView) view.findViewById(R.id.sale_title);
		titleView.setText(sale.getTitle());
		titleView.getPaint().setFakeBoldText(true);

		ImageView saleImageView = (ImageView) view.findViewById(R.id.sale_img);
		saleImageView.setLayoutParams(new LinearLayout.LayoutParams(
				SALE_IMAGE_WIDTH, SALE_IMAGE_WIDTH));
		saleImageView.setAdjustViewBounds(false);
		saleImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		ImageLoader.getInstance().displayImage(sale.getImg(), saleImageView, true);

		TextView contentView = (TextView) view.findViewById(R.id.sale_content);
		contentView.setText(sale.getContent());

		TextView visitCountView = (TextView) view
				.findViewById(R.id.sale_visit_count);
		visitCountView.setText(String.valueOf(sale.getVisitCount()));
		visitCountView.getPaint().setFakeBoldText(true);

		TextView discussCountView = (TextView) view
				.findViewById(R.id.sale_discuss_count);
		discussCountView.setText(String.valueOf(sale.getDiscussCount()));
		discussCountView.getPaint().setFakeBoldText(true);

		TextView publisherView = (TextView) view.findViewById(R.id.sale_publisher);
		publisherView.setText(sale.getShop().getName());
		publisherView.getPaint().setFakeBoldText(true);

		TextView distanceView = (TextView) view.findViewById(R.id.shop_distance);
		distanceView.setText("500");
		distanceView.getPaint().setFakeBoldText(true);

		return view;
	}

	class ViewHolder {
		View view;
	}

}
