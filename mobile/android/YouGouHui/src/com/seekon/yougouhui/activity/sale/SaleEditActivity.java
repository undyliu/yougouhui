package com.seekon.yougouhui.activity.sale;

import java.util.Date;

import android.os.Bundle;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.sale.GetSaleTaskCallback;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.widget.AsyncRestRequestTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;

public class SaleEditActivity extends SalePromoteActivity {

	private SaleEntity sale;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.shop_sale_edit);

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
	}

}
