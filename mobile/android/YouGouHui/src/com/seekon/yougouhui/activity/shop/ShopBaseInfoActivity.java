package com.seekon.yougouhui.activity.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.shop.ShopConst.COL_NAME_SHOP_IMAGE;

import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TableRow;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.sale.ShopSaleListActivity;
import com.seekon.yougouhui.activity.share.ShareActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.favorit.ShopFavoritProcessor;
import com.seekon.yougouhui.func.shop.GetShopTaskCallback;
import com.seekon.yougouhui.func.shop.GetTradesTaskCallback;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopUtils;
import com.seekon.yougouhui.func.shop.TradeEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;

public class ShopBaseInfoActivity extends Activity {

	//private static final String TAG = ShopBaseInfoActivity.class.getSimpleName();

	private static final int SHOP_IMAGE_WIDTH = 75;

	private static final int CHANGE_SHOP_REQUEST_CODE = 1;

	private ShopEntity shop = null;
	private boolean readonly = true;

	private TextView nameView;
	private TextView addressView;
	private TextView descView;
	private TextView tradesView;
	private TextView pwdView;
	private ImageView shopImageView;
	private ImageView busiLicenseView;
	private ImageView barcodeView;

	private Menu menu;
	private boolean shopFavorited = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_base_info);

		String shopId = this.getIntent().getStringExtra(ShopConst.COL_NAME_UUID);
		readonly = this.getIntent().getBooleanExtra(DataConst.NAME_READONLY, true);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();
		loadData(shopId);
	}

	private void initViews() {
		nameView = (TextView) findViewById(R.id.shop_name);
		addressView = (TextView) findViewById(R.id.shop_address);
		descView = (TextView) findViewById(R.id.shop_desc);
		tradesView = (TextView) findViewById(R.id.shop_trades);
		pwdView = (TextView) findViewById(R.id.shop_pwd);

		shopImageView = (ImageView) findViewById(R.id.shop_image);
		shopImageView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		shopImageView.setLayoutParams(new TableRow.LayoutParams(SHOP_IMAGE_WIDTH,
				SHOP_IMAGE_WIDTH));

		busiLicenseView = (ImageView) findViewById(R.id.shop_busi_license);
		busiLicenseView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		busiLicenseView.setLayoutParams(new TableRow.LayoutParams(SHOP_IMAGE_WIDTH,
				SHOP_IMAGE_WIDTH));

		barcodeView = (ImageView) findViewById(R.id.shop_barcode);
		barcodeView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		barcodeView.setLayoutParams(new TableRow.LayoutParams(SHOP_IMAGE_WIDTH,
				SHOP_IMAGE_WIDTH));
	}

	private void loadData(String shopId) {
		shop = ShopUtils.loadDataFromLocal(this, shopId);
		if (shop == null) {
			loadDataFromRemote(shopId);
		} else {
			updateViews();
		}

	}

	private void loadDataFromRemote(final String shopId) {
		ShopUtils.loadDataFromRemote(this, new GetShopTaskCallback(this, shopId) {

			@Override
			public void onSuccess(RestMethodResult<JSONObjResource> result) {
				shop = ShopUtils.loadDataFromLocal(ShopBaseInfoActivity.this, shopId);
				updateViews();
			}
		});
	}
	
	private void updateViews() {
		if (shop == null) {
			return;
		}

		nameView.setText(shop.getName());
		addressView.setText(shop.getAddress());
		descView.setText(shop.getDesc());
		pwdView.setText("......");

		ImageLoader.getInstance().displayImage(shop.getShopImage(), shopImageView,
				true);
		ImageLoader.getInstance().displayImage(shop.getBusiLicense(),
				busiLicenseView, true);
		String barcode = shop.getBarcode();
		if (barcode != null && barcode.length() > 0) {
			ImageLoader.getInstance().displayImage(barcode, barcodeView, true);
		}
		
		StringBuffer trades = new StringBuffer();
		for (TradeEntity trade : shop.getTrades()) {
			trades.append(trade.getName() + "  ");
		}
		tradesView.setText(trades);
		
		if (!readonly) {
			setListeners();
		}else{
			findViewById(R.id.row_shop_pwd).setVisibility(View.GONE);
		}

		final String status = shop.getStatus();
		findViewById(R.id.row_shop_barcode).setOnClickListener(
				new View.OnClickListener() {

					@Override
					public void onClick(View v) {
						Intent intent = new Intent(ShopBaseInfoActivity.this,
								SetShopBarcodeActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						intent.putExtra(DataConst.NAME_READONLY,
								readonly || !status.equals(ShopConst.STATUS_REGISTERED));
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});

		AsyncTask<Void, Void, Boolean> favoritTask = new AsyncTask<Void, Void, Boolean>() {

			@Override
			protected Boolean doInBackground(Void... params) {
				return ShopUtils.isShopFavorited(ShopBaseInfoActivity.this,
						shop.getUuid(), RunEnv.getInstance().getUser().getUuid());
			}

			@Override
			protected void onPostExecute(Boolean result) {
				if (result) {
					shopFavorited = true;
					if (menu != null) {
						updateMenuStatus();
					}
				}
			}
		};

		favoritTask.execute((Void) null);
	}

	private void setListeners() {
		final String status = shop.getStatus();
		String ownerId = shop.getOwner();
		String userId = RunEnv.getInstance().getUser().getUuid();
		if (userId.equals(ownerId)) {// 只有店主才可以修改商铺的基本信息
			if (status.equals(ShopConst.STATUS_REGISTERED)) {
				findViewById(R.id.row_shop_name).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeShopTextActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								intent.putExtra(DataConst.NAME_TYPE, COL_NAME_NAME);
								intent.putExtra(DataConst.NAME_TITLE,
										R.string.title_shop_change_name);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});
				findViewById(R.id.row_shop_address).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeShopTextActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								intent.putExtra(DataConst.NAME_TYPE, COL_NAME_ADDRESS);
								intent.putExtra(DataConst.NAME_TITLE,
										R.string.title_shop_change_addr);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});
				findViewById(R.id.row_shop_image).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeShopImageActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								intent.putExtra(DataConst.NAME_TYPE, COL_NAME_SHOP_IMAGE);
								intent.putExtra(DataConst.NAME_TITLE,
										R.string.title_shop_change_image);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});
				findViewById(R.id.row_shop_busi_license).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeShopImageActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								intent.putExtra(DataConst.NAME_TYPE, COL_NAME_BUSI_LICENSE);
								intent.putExtra(DataConst.NAME_TITLE,
										R.string.title_shop_change_license);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});

				findViewById(R.id.row_shop_trades).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeTradesActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});
			}
			if (status.equals(ShopConst.STATUS_REGISTERED)
					|| status.equals(ShopConst.STATUS_AUDITED)) {
				findViewById(R.id.row_shop_desc).setOnClickListener(
						new View.OnClickListener() {
							@Override
							public void onClick(View v) {
								Intent intent = new Intent(ShopBaseInfoActivity.this,
										ChangeShopTextActivity.class);
								intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
								intent.putExtra(DataConst.NAME_TYPE, COL_NAME_DESC);
								intent.putExtra(DataConst.NAME_TITLE,
										R.string.title_shop_change_desc);
								startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
							}
						});
			}
		}
		findViewById(R.id.row_shop_pwd).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(ShopBaseInfoActivity.this,
								ChangeShopPwdActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						startActivity(intent);
					}
				});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.shop_base_info, menu);
		this.menu = menu;
		updateMenuStatus();

		return true;
	}

	private void updateMenuStatus() {
		MenuItem item = menu.findItem(R.id.menu_shop_favorit_cancel);
		item.setVisible(shopFavorited);

		item = menu.findItem(R.id.menu_shop_favorit);
		item.setVisible(!shopFavorited);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;
		case R.id.menu_shop_favorit:
			addShopFavorit(item);
			break;
		case R.id.menu_shop_favorit_cancel:
			cancelShopFavorit(item);
			break;
		case R.id.menu_share_publish:
			publishShare();
			break;
		case R.id.menu_shop_sale_list:
			shopSaleList();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void shopSaleList() {
		Intent intent = new Intent(this, ShopSaleListActivity.class);
		intent.putExtra(DataConst.COL_NAME_UUID, shop.getUuid());
		startActivity(intent);
	}

	private void publishShare() {
		Intent intent = new Intent(this, ShareActivity.class);
		intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
		startActivity(intent);
	}

	private void addShopFavorit(final MenuItem item) {
		item.setEnabled(false);
		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("收藏商铺失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopFavoritProcessor.getInstance(ShopBaseInfoActivity.this)
								.addShopFavorit(shop, RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						shopFavorited = true;
						updateMenuStatus();
					}

					@Override
					public void onFailed(String errorMessage) {
						onCancelled();
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						super.onCancelled();
					}
				});
	}

	private void cancelShopFavorit(final MenuItem item) {
		item.setEnabled(false);
		RestUtils.executeAsyncRestTask(this,
				new AbstractRestTaskCallback<JSONObjResource>("取消收藏商铺失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return ShopFavoritProcessor.getInstance(ShopBaseInfoActivity.this)
								.deleteShopFavorit(shop.getUuid(),
										RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						shopFavorited = false;
						updateMenuStatus();
					}

					@Override
					public void onFailed(String errorMessage) {
						onCancelled();
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						super.onCancelled();
					}
				});
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case CHANGE_SHOP_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				shop = (ShopEntity) data.getSerializableExtra(ShopConst.DATA_SHOP_KEY);
				updateViews();
			}
			break;

		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}
}
