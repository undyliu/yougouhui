package com.seekon.yougouhui.activity.sale;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.database.Cursor;
import android.os.Bundle;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleData;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleImgConst;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;

public class SaleEditActivity extends SalePromoteActivity {

	private SaleEntity sale;

	private SaleData saleData;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.shop_sale_edit);
		
		saleData = new SaleData(this);
		loadSale();
		
		super.onCreate(savedInstanceState);
	}

	private void loadSale() {
		sale = (SaleEntity) this.getIntent().getSerializableExtra(SaleConst.DATA_SALE_KEY);
		sale = saleData.getSale(sale.getUuid());
		if (sale == null) {
			ViewUtils.showToast("获取活动数据失败.");
			return;
		}

		Cursor cursor = null;
		try {
			cursor = this.getContentResolver().query(SaleImgConst.CONTENT_URI,
					new String[] { DataConst.COL_NAME_IMG },
					SaleImgConst.COL_NAME_SALE_ID + "=?", new String[] { sale.getUuid() },
					DataConst.COL_NAME_ORD_INDEX);
			List<String> images = new ArrayList<String>();
			while(cursor.moveToNext()){
				images.add(cursor.getString(0));
			}
			sale.setImages(images);
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}
	}
	
	@Override
	protected void updateViews() {
		super.updateViews();
		
		if(sale == null){
			return;
		}
		
		String tradeId = sale.getTradeId();
		
		imageFileUriList = sale.getImages();
		imageAdapter.notifyDataSetChanged();
		
		for(TradeEntity trade : shopTradeList){
			if(tradeId.equals(trade.getUuid())){
				this.saleTradeListAdapter.setDefaultCheckedTrade(trade);
				break;
			}
		}
		
		titleView.setText(sale.getTitle());
		contentView.setText(sale.getContent());
		startDateView.setText(DateUtils.getDateString_yyyyMMdd(new Date(sale.getStartDate())));
		endDateView.setText(DateUtils.getDateString_yyyyMMdd(new Date(sale.getEndDate())));
		
		TextView visitCountView = (TextView) findViewById(R.id.sale_visit_count);
		visitCountView.setText(String.valueOf(sale.getVisitCount()));
		visitCountView.getPaint().setFakeBoldText(true);
		
		TextView discussCountView = (TextView) findViewById(R.id.sale_discuss_count);
		discussCountView.setText(String.valueOf(sale.getDiscussCount()));
		discussCountView.getPaint().setFakeBoldText(true);
	}

}
