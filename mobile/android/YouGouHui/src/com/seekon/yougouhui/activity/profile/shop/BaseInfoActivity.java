package com.seekon.yougouhui.activity.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_DESC;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_ADDRESS;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BARCODE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_BUSI_LICENSE;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_OWNER;
import static com.seekon.yougouhui.func.profile.shop.ShopConst.COL_NAME_SHOP_IMAGE;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TableRow;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopProcessor;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
import com.seekon.yougouhui.util.ViewUtils;

public class BaseInfoActivity extends Activity {

	private static final String TAG = BaseInfoActivity.class.getSimpleName();

	private static final int SHOP_IMAGE_WIDTH = 75;

	private static final int CHANGE_SHOP_REQUEST_CODE = 1;

	private ShopEntity shop = null;

	private TextView nameView;
	private TextView addressView;
	private TextView descView;
	private TextView tradesView;
	private TextView pwdView;
	private ImageView shopImageView;
	private ImageView busiLicenseView;
	private ImageView barcodeView;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_base_info);

		String shopId = this.getIntent().getStringExtra(ShopConst.COL_NAME_UUID);

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
		
		findViewById(R.id.row_shop_name).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
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
						Intent intent = new Intent(BaseInfoActivity.this,
								ChangeShopTextActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						intent.putExtra(DataConst.NAME_TYPE, COL_NAME_ADDRESS);
						intent.putExtra(DataConst.NAME_TITLE,
								R.string.title_shop_change_addr);
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});
		findViewById(R.id.row_shop_desc).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
								ChangeShopTextActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						intent.putExtra(DataConst.NAME_TYPE, COL_NAME_DESC);
						intent.putExtra(DataConst.NAME_TITLE,
								R.string.title_shop_change_desc);
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});
		findViewById(R.id.row_shop_image).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
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
						Intent intent = new Intent(BaseInfoActivity.this,
								ChangeShopImageActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						intent.putExtra(DataConst.NAME_TYPE, COL_NAME_BUSI_LICENSE);
						intent.putExtra(DataConst.NAME_TITLE,
								R.string.title_shop_change_license);
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});
		findViewById(R.id.row_shop_pwd).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
								ChangeShopPwdActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						startActivity(intent);
					}
				});
		findViewById(R.id.row_shop_trades).setOnClickListener(
				new View.OnClickListener() {
					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
								ChangeTradesActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});
		findViewById(R.id.row_shop_barcode).setOnClickListener(
				new View.OnClickListener() {

					@Override
					public void onClick(View v) {
						Intent intent = new Intent(BaseInfoActivity.this,
								SetShopBarcodeActivity.class);
						intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
						startActivityForResult(intent, CHANGE_SHOP_REQUEST_CODE);
					}
				});
	}

	private void loadData(String shopId) {
		shop = loadDataFromLocal(shopId);
		if (shop == null) {
			loadDataFromRemote(shopId);
		} else {
			updateViews();
		}
	}

	private ShopEntity loadDataFromLocal(String shopId) {
		ShopEntity shop = null;
		Cursor cursor = null;
		try {
			String[] projection = new String[] { COL_NAME_NAME, COL_NAME_ADDRESS,
					COL_NAME_DESC, COL_NAME_SHOP_IMAGE, COL_NAME_BUSI_LICENSE,
					COL_NAME_OWNER, COL_NAME_BARCODE };
			String selection = COL_NAME_UUID + "=?";
			String[] selectionArgs = new String[] { shopId };

			cursor = this.getContentResolver().query(ShopConst.CONTENT_URI,
					projection, selection, selectionArgs, null);
			if (cursor.moveToNext()) {
				int i = 0;
				shop = new ShopEntity();
				shop.setUuid(shopId);
				shop.setName(cursor.getString(i++));
				shop.setAddress(cursor.getString(i++));
				shop.setDesc(cursor.getString(i++));
				shop.setShopImage(cursor.getString(i++));
				shop.setBusiLicense(cursor.getString(i++));
				shop.setOwner(cursor.getString(i++));
				shop.setBarcode(cursor.getString(i++));
			}
		} catch (Exception e) {
			Logger.warn(TAG, e.getMessage());
		} finally {
			if (cursor != null) {
				cursor.close();
			}
		}

		if (shop != null) {
			String[] projection = new String[] { COL_NAME_UUID, COL_NAME_CODE,
					COL_NAME_NAME };
			String selection = COL_NAME_UUID
					+ " in (select trade_id from e_shop_trade where shop_id = ?)";
			String[] selectionArgs = new String[] { shopId };
			try {
				cursor = this.getContentResolver().query(TradeConst.CONTENT_URI,
						projection, selection, selectionArgs, COL_NAME_ORD_INDEX);
				while (cursor.moveToNext()) {
					int i = 0;
					TradeEntity trade = new TradeEntity(cursor.getString(i++),
							cursor.getString(i++), cursor.getString(i++));
					shop.addTrade(trade);
				}
			} catch (Exception e) {
				Logger.warn(TAG, e.getMessage());
			} finally {
				if (cursor != null) {
					cursor.close();
				}
			}
		}
		return shop;
	}

	private void loadDataFromRemote(final String shopId) {
		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return ShopProcessor.getInstance(BaseInfoActivity.this).getShop(shopId);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				int status = result.getStatusCode();
				if (status == 200) {
					shop = loadDataFromLocal(shopId);
					updateViews();
				} else {
					ViewUtils.showToast("获取商铺信息失败.");
				}
			}

		};
		task.execute((Void) null);
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
		if(barcode != null && barcode.length() > 0){
			ImageLoader.getInstance().displayImage(barcode, barcodeView, true);
		}
		StringBuffer trades = new StringBuffer();
		for (TradeEntity trade : shop.getTrades()) {
			trades.append(trade.getName() + "  ");
		}
		tradesView.setText(trades);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			finish();
			break;

		default:
			break;
		}
		return super.onOptionsItemSelected(item);
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
