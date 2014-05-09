package com.seekon.yougouhui.func.grade.widget;

import java.util.List;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.shop.ShopBaseInfoActivity;
import com.seekon.yougouhui.func.grade.GradeItemsEntity;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.widget.EntityListAdapter;
import com.seekon.yougouhui.util.DateUtils;

public class GradeItemsListAdapter extends EntityListAdapter<GradeItemsEntity> {

	public GradeItemsListAdapter(Context context, List<GradeItemsEntity> dataList) {
		super(context, dataList);
	}

	@Override
	public View getView(int position, View view, ViewGroup arg2) {
		ViewHolder holder = null;
		if (view == null) {
			holder = new ViewHolder();
			view = LayoutInflater.from(context).inflate(R.layout.grade_items_item,
					null, false);

			int itemBaseWith = context.getResources().getDisplayMetrics().widthPixels / 9;

			holder.gradeTimeView = (TextView) view.findViewById(R.id.grade_time);
			holder.gradeTimeView.setWidth(itemBaseWith * 2);

			holder.shopNameView = (TextView) view.findViewById(R.id.shop_name);
			holder.shopNameView.setWidth(itemBaseWith * 3);

			holder.gradeAmountView = (TextView) view.findViewById(R.id.grade_amount);
			holder.gradeAmountView.setWidth(itemBaseWith);

			holder.gradeUsedView = (TextView) view.findViewById(R.id.grade_used);
			holder.gradeUsedView.setWidth(itemBaseWith);

			holder.endTimeView = (TextView) view.findViewById(R.id.end_time);
			holder.endTimeView.setWidth(itemBaseWith * 2);

			view.setTag(holder);
		} else {
			holder = (ViewHolder) view.getTag();
		}

		GradeItemsEntity item = (GradeItemsEntity) getItem(position);

		holder.gradeTimeView.setText(DateUtils.getDateString_yyyyMMdd(item
				.getGradeTime()));
		holder.gradeAmountView.setText(String.valueOf(item.getGradeAmout()));
		holder.gradeUsedView.setText(String.valueOf(item.getGradeUsed()));
		holder.endTimeView.setText(DateUtils.getDateString_yyyyMMdd(item
				.getEndTime()));

		final ShopEntity shop = item.getShop();
		holder.shopNameView.setText(shop.getName());
		holder.shopNameView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(context, ShopBaseInfoActivity.class);
				intent.putExtra(ShopConst.COL_NAME_UUID, shop.getUuid());
				context.startActivity(intent);
			}
		});

		return view;
	}

	class ViewHolder {
		TextView gradeTimeView;
		TextView shopNameView;
		TextView gradeAmountView;
		TextView gradeUsedView;
		TextView endTimeView;
	}
}
