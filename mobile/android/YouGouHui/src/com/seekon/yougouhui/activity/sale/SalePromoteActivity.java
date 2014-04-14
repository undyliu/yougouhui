package com.seekon.yougouhui.activity.sale;

import java.util.Date;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.PicContainerActivity;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.shop.ShopTradeProcessor;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.SaleTradeListAdapter;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 促销活动
 * 
 * @author undyliu
 * 
 */
public class SalePromoteActivity extends PicContainerActivity {

	private static final int SALE_START_DATE_DIALOG = 100;
	private static final int SALE_END_DATE_DIALOG = 200;

	private EditText titleView;
	private EditText contentView;
	private EditText startDateView;
	private EditText endDateView;
	private ImageView startDateChooseView;
	private ImageView endDateChooseView;

	private String shopId;
	private SaleTradeListAdapter saleTradeListAdapter;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setContentView(R.layout.shop_sale_promote);

		shopId = this.getIntent().getStringExtra(DataConst.COL_NAME_UUID);

		initViews();

		super.onCreate(savedInstanceState);
	}

	private void initViews() {
		titleView = (EditText) findViewById(R.id.sale_title);
		contentView = (EditText) findViewById(R.id.sale_content);

		startDateChooseView = (ImageView) findViewById(R.id.img_choose_sale_start_date);
		startDateChooseView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				showDialog(SALE_START_DATE_DIALOG);
			}
		});

		startDateView = (EditText) findViewById(R.id.sale_start_date);
		startDateView.setEnabled(false);

		endDateView = (EditText) findViewById(R.id.sale_end_date);
		endDateView.setEnabled(false);

		endDateChooseView = (ImageView) findViewById(R.id.img_choose_sale_end_date);
		endDateChooseView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				showDialog(SALE_END_DATE_DIALOG);
			}
		});

		saleTradeListAdapter = new SaleTradeListAdapter(this, ShopTradeProcessor
				.getInstance(this).getShopTradeList(shopId));
		((GridView) findViewById(R.id.shop_trade_view))
				.setAdapter(saleTradeListAdapter);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case R.id.menu_common_save:
			publishSaleInfo(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	@Deprecated
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case SALE_START_DATE_DIALOG:
			return getDatePickerDialog(startDateView);
		case SALE_END_DATE_DIALOG:
			return getDatePickerDialog(endDateView);
		}

		return super.onCreateDialog(id);

	}

	private Dialog getDatePickerDialog(final EditText textView) {
		Date date = null;
		String startDate = textView.getText().toString();
		if (TextUtils.isEmpty(startDate)) {
			date = new Date(System.currentTimeMillis());
		} else {
			date = DateUtils.getDate_yyyyMMdd(startDate);
		}

		return new DatePickerDialog(this, new DatePickerDialog.OnDateSetListener() {

			@Override
			public void onDateSet(DatePicker view, int year, int monthOfYear,
					int dayOfMonth) {
				textView.setText(DateUtils.getDateString_yyyyMMdd(year, monthOfYear,
						dayOfMonth));
			}
		}, DateUtils.getYear(date), DateUtils.getMonth(date) - 1,
				DateUtils.getDayOfMoth(date));
	}

	private void publishSaleInfo(final MenuItem item) {
		titleView.setError(null);
		contentView.setError(null);
		startDateView.setError(null);
		endDateView.setError(null);

		View focusView = null;
		boolean cancel = false;
		String errorFieldRequired = getString(R.string.error_field_required);

		final String startDate = startDateView.getText().toString();
		final String endDate = endDateView.getText().toString();
		if (TextUtils.isEmpty(startDate)) {
			startDateView.setError(errorFieldRequired);
			cancel = true;
			focusView = startDateView;
		}
		if (TextUtils.isEmpty(endDate)) {
			endDateView.setError(errorFieldRequired);
			cancel = true;
			focusView = endDateView;
		}
		if (!TextUtils.isEmpty(startDate) && !TextUtils.isEmpty(endDate)
				&& !DateUtils.beforeDateString_yyyyMMdd(startDate, endDate)) {
			endDateView
					.setError(getString(R.string.error_end_date_must_after_start_date));
			cancel = true;
			focusView = endDateView;
		}

		final String content = contentView.getText().toString();
		if (TextUtils.isEmpty(content)) {
			contentView.setError(errorFieldRequired);
			cancel = true;
			focusView = contentView;
		}

		final String title = titleView.getText().toString();
		if (TextUtils.isEmpty(title)) {
			titleView.setError(errorFieldRequired);
			cancel = true;
			focusView = titleView;
		}

		if (cancel) {
			focusView.requestFocus();
			return;
		}
		if (imageFileUriList.isEmpty()) {
			ViewUtils.showToast("请添加至少一张活动图片.");
			return;
		}
		TradeEntity trade = saleTradeListAdapter.getCheckedTrade();
		if(trade ==  null){
			ViewUtils.showToast("请设置所属业务.");
			return;
		}
		
		final SaleEntity sale = new SaleEntity();
		sale.setTitle(title);
		sale.setContent(content);
		sale.setShopId(shopId);
		sale.setPublisher(RunEnv.getInstance().getUser());
		sale.setTradeId(trade.getUuid());
		sale.setStartDate(DateUtils.getDate_yyyyMMdd(startDate).getTime());
		sale.setEndDate(DateUtils.getDate_yyyyMMdd(endDate).getTime());
		sale.setImages(imageFileUriList);
		
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>(){

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return SaleProcessor.getInstance(SalePromoteActivity.this).publishSale(sale);
			}
			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				item.setEnabled(true);
				if(result.getStatusCode() == 200){
					
				}else{
					ViewUtils.showToast("发布活动信息失败.");
				}
			}
			
			@Override
			protected void onCancelled() {
				item.setEnabled(true);
				super.onCancelled();
			}
		};
		
		item.setEnabled(false);
		task.execute((Void)null);
	}

	@Override
	public GridView getPicContainer() {
		return (GridView) findViewById(R.id.sale_pic_container);
	}
}
