package com.seekon.yougouhui.activity.sale;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.PicContainerActivity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleProcessor;
import com.seekon.yougouhui.func.sale.widget.SaleTradeListAdapter;
import com.seekon.yougouhui.func.shop.GetShopTaskCallback;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.shop.TradeEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 促销活动
 * 
 * @author undyliu
 * 
 */
public abstract class SalePromoteActivity extends PicContainerActivity {

	private static final int SALE_START_DATE_DIALOG = 100;
	private static final int SALE_END_DATE_DIALOG = 200;

	protected TextView shopNameView;
	protected EditText titleView;
	protected EditText contentView;
	protected EditText startDateView;
	protected EditText endDateView;
	protected ImageView startDateChooseView;
	protected ImageView endDateChooseView;

	protected String shopId;
	protected SaleTradeListAdapter saleTradeListAdapter;
	protected List<TradeEntity> shopTradeList = new ArrayList<TradeEntity>();

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		shopId = this.getIntent().getStringExtra(SaleConst.COL_NAME_SHOP_ID);

		initViews();
		loadShopData();

	}

	private void initViews() {
		shopNameView = (TextView) findViewById(R.id.shop_name);
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

		saleTradeListAdapter = new SaleTradeListAdapter(this, shopTradeList);
		((GridView) findViewById(R.id.shop_trade_view))
				.setAdapter(saleTradeListAdapter);
	}

	private void loadShopData() {
		shopTradeList = ShopUtils.getShopTradeList(this, shopId);
		if (shopTradeList.isEmpty()) {
			ShopUtils.loadDataFromRemote(new GetShopTaskCallback(this, shopId) {

				@Override
				public void onSuccess(RestMethodResult<JSONObjResource> result) {
					shopTradeList = ShopUtils.getShopTradeList(SalePromoteActivity.this,
							shopId);
					updateViews();
				}
			});
		} else {
			updateViews();
		}
	}

	protected void updateViews() {
		ShopEntity shop = ShopUtils.loadDataFromLocal(this, shopId);
		if (shop == null) {
			ShopUtils.loadDataFromRemote(new GetShopTaskCallback(this, shopId) {

				@Override
				public void onSuccess(RestMethodResult<JSONObjResource> result) {
					ShopEntity shop = ShopUtils.loadDataFromLocal(
							SalePromoteActivity.this, shopId);
					shopNameView.setText(shop.getName());
				}
			});
		} else {
			shopNameView.setText(shop.getName());
		}
		saleTradeListAdapter.updateData(shopTradeList);
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

	protected void publishSaleInfo(final MenuItem item) {
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
		if (trade == null) {
			ViewUtils.showToast("请设置所属业务.");
			return;
		}

		ShopEntity shop = new ShopEntity();
		shop.setUuid(shopId);

		final SaleEntity sale = new SaleEntity();
		sale.setTitle(title);
		sale.setContent(content);
		sale.setShop(shop);
		sale.setPublisher(RunEnv.getInstance().getUser());
		sale.setTradeId(trade.getUuid());
		sale.setStartDate(DateUtils.getDate_yyyyMMdd(startDate).getTime());
		sale.setEndDate(DateUtils.getDate_yyyyMMdd(endDate).getTime());
		sale.setImages(imageFileUriList);

		showProgress(true);
		item.setEnabled(false);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"发布活动信息失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return SaleProcessor.getInstance(SalePromoteActivity.this)
								.publishSale(sale);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						Intent intent = new Intent();
						intent.putExtra(SaleConst.DATA_REQUEST_PUBLISH_RESULT, true);
						setResult(RESULT_OK, intent);
						finish();
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

	@Override
	public GridView getPicContainer() {
		return (GridView) findViewById(R.id.sale_pic_container);
	}

	protected void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.sale_promite_main), show);
	}
}
