package com.seekon.yougouhui.func.sale.widget;

import java.text.DecimalFormat;
import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.util.LocationUtils;

public class ChannelSaleListAdapter<T extends SaleEntity> extends
		EntityListAdapter<T> {
	private static final int SALE_IMAGE_WIDTH = 150;

	public ChannelSaleListAdapter(Context context, List<T> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.channel_sale_item,
					null, false);
			holder.titleView = (TextView) view.findViewById(R.id.sale_title);
			holder.titleView.getPaint().setFakeBoldText(true);
			holder.saleImageView = (ImageView) view.findViewById(R.id.sale_img);
			holder.saleImageView.setLayoutParams(new LinearLayout.LayoutParams(
					SALE_IMAGE_WIDTH, SALE_IMAGE_WIDTH));
			holder.saleImageView.setAdjustViewBounds(false);
			holder.saleImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);

			holder.contentView = (TextView) view.findViewById(R.id.sale_content);

			holder.visitCountView = (TextView) view
					.findViewById(R.id.sale_visit_count);
			holder.visitCountView.getPaint().setFakeBoldText(true);

			holder.discussCountView = (TextView) view
					.findViewById(R.id.sale_discuss_count);
			holder.discussCountView.getPaint().setFakeBoldText(true);

			holder.publisherView = (TextView) view.findViewById(R.id.sale_publisher);
			holder.publisherView.getPaint().setFakeBoldText(true);

			holder.distanceView = (TextView) view.findViewById(R.id.shop_distance);
			holder.distanceView.getPaint().setFakeBoldText(true);

			holder.statusImgView = (ImageView) view
					.findViewById(R.id.sale_status_img);
			holder.statusView = (TextView) view.findViewById(R.id.sale_status);
			holder.statusView.getPaint().setFakeBoldText(true);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		SaleEntity sale = (SaleEntity) getItem(position);

		holder.titleView.setText(sale.getTitle());
		ImageLoader.getInstance().displayImage(sale.getImg(), holder.saleImageView,
				true);

		holder.contentView.setText(sale.getContent());
		holder.visitCountView.setText(String.valueOf(sale.getVisitCount()));
		holder.discussCountView.setText(String.valueOf(sale.getDiscussCount()));
		holder.publisherView.setText(sale.getShop().getName());

		LocationEntity currentLocation = RunEnv.getInstance().getLocationEntity();
		LocationEntity shopLocation = sale.getShop().getLocation();
		if (currentLocation != null && shopLocation != null) {
			holder.distanceView.setText(new DecimalFormat("###,###.##")
					.format(LocationUtils.distance(currentLocation, shopLocation)));
		} else {
			holder.distanceView.setText("未知");
		}

		String status = sale.getStatus();
		if (DataConst.STATUS_AUDITED.equals(status)) {
			holder.statusImgView.setImageResource(R.drawable.valid);
			holder.statusView.setText(R.string.label_sale_status_valid);
		} else if (DataConst.STATUS_ENDED.equals(status)) {
			holder.statusImgView.setImageResource(R.drawable.closed);
			holder.statusView.setText(R.string.label_sale_status_ended);
		} else {// 其他的都显示为作废
			holder.statusImgView.setImageResource(R.drawable.cancel);
			holder.statusView.setText(R.string.label_sale_status_canceled);
		}

		return view;
	}

	final public class ViewHolder {
		TextView titleView;
		ImageView saleImageView;
		TextView contentView;
		TextView visitCountView;
		TextView discussCountView;
		TextView publisherView;
		public TextView distanceView;
		ImageView statusImgView;
		TextView statusView;
	}

}
