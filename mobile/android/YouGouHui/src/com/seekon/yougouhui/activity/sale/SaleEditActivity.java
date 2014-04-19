package com.seekon.yougouhui.activity.sale;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.sale.GetSaleTaskCallback;
import com.seekon.yougouhui.func.sale.SaleDiscussData;
import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.func.sale.SaleDiscussProcessor;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.sale.widget.SaleDiscussListAdapter;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

public class SaleEditActivity extends SalePromoteActivity implements IXListViewListener{

	private SaleEntity sale;
	private List<SaleDiscussEntity> discussList = new ArrayList<SaleDiscussEntity>();
	
	private SaleDiscussData saleDiscussData;
	private Handler mHandler;
	
	View discussView;
	XListView discussListView;
	ImageView discussExpandView;
	SaleDiscussListAdapter discussListAdapter;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.shop_sale_edit);

		mHandler = new Handler();
		saleDiscussData = new SaleDiscussData(this);
		
		discussListAdapter = new SaleDiscussListAdapter(this,
				new ArrayList<SaleDiscussEntity>());
		
		discussView = findViewById(R.id.discuss_view);
		
		discussListView = (XListView) findViewById(R.id.listview_main);
		discussListView.setPullLoadEnable(true);
		discussListView.setXListViewListener(this);
		discussListView.setAdapter(discussListAdapter);

		discussExpandView = (ImageView) findViewById(R.id.img_sale_discuss_expand);
		
		loadSale();

		super.onCreate(savedInstanceState);
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
		
		loadDiscussData(saleId);
	}

	private void loadDiscussData(final String saleId) {
		discussList = saleDiscussData.getDiscussList(saleId);
		if (discussList.isEmpty()) {
			RestUtils
					.executeAsyncRestTask(new AbstractRestTaskCallback<JSONArrayResource>(
							"获取评论数据失败.") {

						@Override
						public RestMethodResult<JSONArrayResource> doInBackground() {
							return SaleDiscussProcessor.getInstance(SaleEditActivity.this)
									.getDiscusses(saleId);
						}

						@Override
						public void onSuccess(RestMethodResult<JSONArrayResource> result) {
							discussList = saleDiscussData.getDiscussList(saleId);
							discussListAdapter.updateData(discussList);
						}

					});
		} else {
			discussListAdapter.updateData(discussList);
		}
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
				discussView.setVisibility(visibility == View.VISIBLE ? View.GONE : View.VISIBLE);
			}
		});
	}

	@Override
	public void onRefresh() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				discussListView.stopRefresh();
				discussListView.stopLoadMore();
			}
		}, 2000);
	}

	@Override
	public void onLoadMore() {
		mHandler.postDelayed(new Runnable() {

			@Override
			public void run() {
				discussListView.stopRefresh();
				discussListView.stopLoadMore();
			}
		}, 2000);
	}

}
