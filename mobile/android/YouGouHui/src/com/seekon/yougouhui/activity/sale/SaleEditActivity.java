package com.seekon.yougouhui.activity.sale;

import java.util.Date;

import android.os.Bundle;
import android.os.Handler;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.sale.GetSaleTaskCallback;
import com.seekon.yougouhui.func.sale.SaleDiscussData;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.sale.widget.SaleDiscussListView;
import com.seekon.yougouhui.func.shop.TradeEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

public class SaleEditActivity extends SalePromoteActivity {

	private SaleEntity sale;

	private SaleDiscussData saleDiscussData;
	private Handler mHandler;

	View discussView;
	SaleDiscussListView discussListView;
	ImageView discussExpandView;
	private Menu menu;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.shop_sale_edit);

		mHandler = new Handler();
		saleDiscussData = new SaleDiscussData(this);

		discussView = findViewById(R.id.discuss_view);
		discussListView = (SaleDiscussListView) findViewById(R.id.listview_main);
		discussListView.init();
		discussExpandView = (ImageView) findViewById(R.id.img_sale_discuss_expand);

		loadSale();

		super.onCreate(savedInstanceState);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.sale_edit, menu);
		this.menu = menu;
		if (sale != null) {
			String status = sale.getStatus();
			if (DataConst.STATUS_CANCELED.equals(status)) {
				menu.findItem(R.id.menu_sale_cancel).setEnabled(false);
			}
		}
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case R.id.menu_sale_cancel:
			cancelSale(item);
			break;
		case R.id.menu_sale_publish:
			// publishSaleInfo(item);//不支持重新发布
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void loadSale() {
		final String saleId = this.getIntent().getStringExtra(
				DataConst.COL_NAME_UUID);
		AsyncRestRequestTask<JSONObjResource> task = new AsyncRestRequestTask<JSONObjResource>(
				new GetSaleTaskCallback(this, saleId) {

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						sale = SaleUtils.getSale(SaleEditActivity.this, saleId);
						updateViews();
					}
				});
		task.execute((Void) null);

	}

	@Override
	protected void updateViews() {
		super.updateViews();

		if (sale == null) {
			return;
		}

		String tradeId = sale.getTradeId();

		imageFileUriList = sale.getImages();
		imageAdapter.notifyDataSetChanged();

		for (TradeEntity trade : shopTradeList) {
			if (tradeId.equals(trade.getUuid())) {
				this.saleTradeListAdapter.setDefaultCheckedTrade(trade);
				break;
			}
		}

		titleView.setText(sale.getTitle());
		contentView.setText(sale.getContent());
		startDateView.setText(DateUtils.getDateString_yyyyMMdd(new Date(sale
				.getStartDate())));
		endDateView.setText(DateUtils.getDateString_yyyyMMdd(new Date(sale
				.getEndDate())));

		TextView visitCountView = (TextView) findViewById(R.id.sale_visit_count);
		visitCountView.setText(String.valueOf(sale.getVisitCount()));
		visitCountView.getPaint().setFakeBoldText(true);

		TextView discussCountView = (TextView) findViewById(R.id.sale_discuss_count);
		discussCountView.setText(String.valueOf(sale.getDiscussCount()));
		discussCountView.getPaint().setFakeBoldText(true);

		discussExpandView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				int visibility = discussView.getVisibility();
				discussView.setVisibility(visibility == View.VISIBLE ? View.GONE
						: View.VISIBLE);
				if (visibility == View.VISIBLE && sale != null) {
					discussListView.loadDiscussData(sale);
				}
			}
		});

		updateViewsWidthStatus();
	}

	private void updateViewsWidthStatus() {
		this.contentView.setEnabled(false);
		this.titleView.setEnabled(false);
		this.startDateChooseView.setEnabled(false);
		this.endDateChooseView.setEnabled(false);

		if (menu != null) {
			String status = sale.getStatus();
			if (DataConst.STATUS_CANCELED.equals(status)) {
				menu.findItem(R.id.menu_sale_cancel).setEnabled(false);
			}
			// if (DataConst.STATUS_AUDITED.equals(status)) {
			// //menu.findItem(R.id.menu_sale_cancel).setEnabled(true);
			// //menu.findItem(R.id.menu_sale_cancel).setVisible(true);
			// } else if (DataConst.STATUS_REGISTERED.equals(status)) {
			// //menu.findItem(R.id.menu_sale_cancel).setEnabled(true);
			// //menu.findItem(R.id.menu_sale_cancel).setVisible(true);
			// //menu.findItem(R.id.menu_sale_publish).setEnabled(true);
			// //menu.findItem(R.id.menu_sale_publish).setVisible(true);
			//
			// //this.contentView.setEnabled(true);
			// //this.titleView.setEnabled(true);
			// //this.startDateChooseView.setEnabled(true);
			// //this.endDateChooseView.setEnabled(true);
			// }
		}
	}

	private void cancelSale(final MenuItem item) {
		item.setEnabled(false);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>() {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return SaleProcessor.getInstance(SaleEditActivity.this).cancelSale(
								sale);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						updateViewsWidthStatus();
						onCancelled();
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						onCancelled();
					}

					@Override
					public void onCancelled() {
						showProgress(false);
						item.setEnabled(true);
						super.onCancelled();
					}
				});
	}

}
