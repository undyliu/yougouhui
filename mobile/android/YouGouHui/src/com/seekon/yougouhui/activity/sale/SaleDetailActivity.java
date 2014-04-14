package com.seekon.yougouhui.activity.sale;

import java.util.Date;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.MenuItem;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.activity.profile.shop.ShopBaseInfoActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.sale.widget.GetSaleTask;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ImageListRemoteAdapter;

public class SaleDetailActivity extends Activity {

	private static final int SALE_IMAGE_WIDTH = 200;

	private SaleEntity sale = null;

	TextView titleView;
	TextView contentView;
	TextView shopView;
	TextView distanceView;
	TextView endDateView;
	TextView visitCountView;
	TextView discussCountView;
	ImageView saleImageView;
	GridView saleImagesView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.channel_sale_detail);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
		loadSaleData();
	}

	private void initViews() {
		titleView = (TextView) findViewById(R.id.sale_title);
		contentView = (TextView) findViewById(R.id.sale_content);
		shopView = (TextView) findViewById(R.id.shop_name);
		distanceView = (TextView) findViewById(R.id.shop_distance);
		endDateView = (TextView) findViewById(R.id.sale_end_date);
		visitCountView = (TextView) findViewById(R.id.sale_visit_count);
		discussCountView = (TextView) findViewById(R.id.sale_discuss_count);

		saleImageView = (ImageView) findViewById(R.id.sale_img);
		saleImageView.setLayoutParams(new LinearLayout.LayoutParams(
				SALE_IMAGE_WIDTH, SALE_IMAGE_WIDTH));
		saleImageView.setAdjustViewBounds(false);
		saleImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		saleImagesView = (GridView) findViewById(R.id.sale_pic_container);
		DisplayMetrics displayMetrics = this.getResources().getDisplayMetrics();
		int colNumber = displayMetrics.widthPixels / (110);
		saleImagesView.setNumColumns(colNumber);

	}

	private void updateViews() {
		if (sale == null) {
			return;
		}

		titleView.setText(sale.getTitle());
		titleView.getPaint().setFakeBoldText(true);

		contentView.setText(sale.getContent());

		shopView.setText(sale.getShop().getName());
		shopView.getPaint().setFakeBoldText(true);
		shopView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(SaleDetailActivity.this,
						ShopBaseInfoActivity.class);
				intent.putExtra(ShopConst.COL_NAME_UUID, sale.getShop().getUuid());
				startActivity(intent);
			}
		});

		distanceView.setText("500");
		distanceView.getPaint().setFakeBoldText(true);

		endDateView.setText(DateUtils.getDateString_yyyyMMdd(new Date(sale
				.getEndDate())));
		endDateView.getPaint().setFakeBoldText(true);

		visitCountView.setText(String.valueOf(sale.getVisitCount()));

		discussCountView.setText(String.valueOf(sale.getDiscussCount()));

		ImageLoader.getInstance().displayImage(sale.getImg(), saleImageView, true);
		saleImageView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(SaleDetailActivity.this,
						ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, sale.getImg());
				intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, 0);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);

				SaleDetailActivity.this.startActivity(intent);
			}
		});

		BaseAdapter baseAdapter = new ImageListRemoteAdapter(this,
				sale.getImages(), 100);
		saleImagesView.setAdapter(baseAdapter);
	}

	private void loadSaleData() {
		final String saleId = this.getIntent().getStringExtra(
				DataConst.COL_NAME_UUID);
		GetSaleTask task = new GetSaleTask(this,
				new TaskCallback<RestMethodResult<JSONObjResource>>() {

					@Override
					public void onPostExecute(RestMethodResult<JSONObjResource> result) {
						if (result.getStatusCode() == 200) {
							sale = SaleUtils.getSale(SaleDetailActivity.this, saleId);
							updateViews();
						} else {
							ViewUtils.showToast("获取活动数据失败.");
						}
					}

					@Override
					public void onCancelled() {

					}
				}, saleId);

		task.execute((Void) null);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}
}
