package com.seekon.yougouhui.activity.sale;

import java.util.Date;

import android.app.ActionBar;
import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.activity.share.ShareActivity;
import com.seekon.yougouhui.activity.shop.ShopBaseInfoActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.LocationEntity;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.favorit.SaleFavoritProcessor;
import com.seekon.yougouhui.func.sale.GetSaleTaskCallback;
import com.seekon.yougouhui.func.sale.SaleConst;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.sale.widget.DiscussPopupWindow;
import com.seekon.yougouhui.func.sale.widget.SaleDiscussListView;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.LocationUtils;
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
	View discussView;
	SaleDiscussListView discussListView;
	ImageView discussExpandView;
	ImageView statusImgView;
	TextView statusView;
	
	Button discussButton;

	private Menu menu;
	private boolean saleFavorited = false;
	private BroadcastReceiver locationReceiver;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.channel_sale_detail);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		showProgress(true);

		initViews();
		locationReceiver = new BroadcastReceiver() {

			@Override
			public void onReceive(Context context, Intent intent) {
				LocationEntity locationEntity = new LocationEntity();
				BDLocation location = intent
						.getParcelableExtra(Const.DATA_BROAD_LOCATION);
				if (location.getLocType() == BDLocation.TypeNetWorkLocation) {
					locationEntity.setAddress(location.getAddrStr());
				}

				locationEntity.setLatitude(location.getLatitude());
				locationEntity.setLontitude(location.getLongitude());
				locationEntity.setRadius(location.getRadius());

				LocationEntity currentLocation = RunEnv.getInstance()
						.getLocationEntity();
				if (currentLocation == null || !currentLocation.equals(locationEntity)) {
					RunEnv.getInstance().setLocationEntity(locationEntity);
				}

				updateDistanceView();
			}
		};

		loadSaleData();
	}

	@Override
	public void onResume() {
		this.registerReceiver(locationReceiver, new IntentFilter(
				Const.KEY_BROAD_LOCATION));
		super.onResume();
	}

	@Override
	public void onPause() {
		this.unregisterReceiver(locationReceiver);
		super.onPause();
	}

	private void initViews() {
		titleView = (TextView) findViewById(R.id.sale_title);
		contentView = (TextView) findViewById(R.id.sale_content);
		shopView = (TextView) findViewById(R.id.d_shop_name);
		distanceView = (TextView) findViewById(R.id.d_shop_distance);
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

		discussExpandView = (ImageView) findViewById(R.id.img_sale_discuss_expand);

		discussView = findViewById(R.id.discuss_view);

		discussListView = (SaleDiscussListView) findViewById(R.id.listview_main);
		discussListView.init();

		discussButton = (Button) findViewById(R.id.b_discuss);
		
		statusImgView = (ImageView) findViewById(R.id.sale_status_img);
		statusView = (TextView) findViewById(R.id.sale_status);
		statusView.getPaint().setFakeBoldText(true);
	}

	private void updateDistanceView() {
		if (sale == null) {
			return;
		}
		LocationEntity currentLocation = RunEnv.getInstance().getLocationEntity();
		LocationEntity shopLocation = sale.getShop().getLocation();
		if (currentLocation != null && shopLocation != null) {
			distanceView.setText(String.valueOf(LocationUtils.distance(
					currentLocation, shopLocation)));
		} else {
			distanceView.setText("未知");
		}
		distanceView.getPaint().setFakeBoldText(true);
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

		updateDistanceView();

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
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, new FileEntity(
						null, sale.getImg()));
				intent.putExtra(ImagePreviewActivity.IMAGE_INDEX_IN_CONTAINER, 0);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);

				SaleDetailActivity.this.startActivity(intent);
			}
		});

		BaseAdapter baseAdapter = new ImageListRemoteAdapter(this,
				sale.getImages(), 100);
		saleImagesView.setAdapter(baseAdapter);

		discussExpandView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				int visibility = discussView.getVisibility();
				discussView.setVisibility(visibility == View.VISIBLE ? View.GONE
						: View.VISIBLE);
				if (visibility == View.GONE && sale != null) {
					discussListView.loadDiscussData(sale);
				}
			}
		});

		discussButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Activity activity = SaleDetailActivity.this;

				ViewUtils.popupInputMethodWindow(activity);// 打开输入键盘

				DiscussPopupWindow popupWindow = new DiscussPopupWindow();
				popupWindow.setHeight(WindowManager.LayoutParams.WRAP_CONTENT);
				popupWindow.setWidth(WindowManager.LayoutParams.FILL_PARENT);
				popupWindow.init(activity, sale.getUuid(),
						discussListView.getEntityListAdapter());
				popupWindow.setBackgroundDrawable(new BitmapDrawable());
				popupWindow.setOutsideTouchable(true);
				popupWindow.setFocusable(true);
				popupWindow
						.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
				popupWindow.showAtLocation(discussView, Gravity.BOTTOM, 0, 0);

			}
		});
		if (this.menu != null) {
			for (int i = 0; i < this.menu.size(); i++) {
				this.menu.getItem(i).setEnabled(true);
			}
		}
		
		String status = sale.getStatus();
		if(DataConst.STATUS_AUDITED.equals(status)){
			statusImgView.setImageResource(R.drawable.valid);
			statusView.setText(R.string.label_sale_status_valid);
		}else if(DataConst.STATUS_ENDED.equals(status)){
			statusImgView.setImageResource(R.drawable.closed);
			statusView.setText(R.string.label_sale_status_ended);
		}else{//其他的都显示为作废
			statusImgView.setImageResource(R.drawable.cancel);
			statusView.setText(R.string.label_sale_status_canceled);
		}
	}

	private void loadSaleData() {
		final String saleId = this.getIntent().getStringExtra(
				DataConst.COL_NAME_UUID);

		RestUtils.executeAsyncRestTask(new GetSaleTaskCallback(this, saleId) {

			@Override
			public void onSuccess(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				sale = SaleUtils.getSale(SaleDetailActivity.this, saleId);
				// sale.getImages().remove(sale.getImg());

				updateViews();
			}

			@Override
			public void onFailed(String errorMessage) {
				showProgress(false);
				super.onFailed(errorMessage);
			}

			@Override
			public void onCancelled() {
				showProgress(false);
			}
		});

		AsyncTask<Void, Void, Boolean> favoritTask = new AsyncTask<Void, Void, Boolean>() {

			@Override
			protected Boolean doInBackground(Void... params) {
				return SaleUtils.isSaleFavorited(SaleDetailActivity.this, saleId,
						RunEnv.getInstance().getUser().getUuid());
			}

			@Override
			protected void onPostExecute(Boolean result) {
				if (result) {
					saleFavorited = result;
					updateMenuStatus();
				}
			}
		};

		favoritTask.execute((Void) null);

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.sale_detail, menu);
		this.menu = menu;
		updateMenuStatus();

		return true;
	}

	private void updateMenuStatus() {
		if (menu != null) {
			MenuItem item = menu.findItem(R.id.menu_sale_favorit_cancel);
			item.setVisible(saleFavorited);

			item = menu.findItem(R.id.menu_sale_favorit);
			item.setVisible(!saleFavorited);
		}
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.back();
			break;
		case R.id.menu_sale_favorit:
			favoritSale(item);
			break;
		case R.id.menu_sale_favorit_cancel:
			cancelFavoritSale(item);
			break;
		case R.id.menu_share_publish:
			publishShare();
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void back(){
		if(sale != null){
			Intent intent = new Intent();
			intent.putExtra(SaleConst.DATA_SALE_KEY, sale);
			setResult(RESULT_OK, intent);
		}
		this.finish();
	}
	
	private void publishShare() {
		Intent intent = new Intent(this, ShareActivity.class);
		intent.putExtra(ShopConst.DATA_SHOP_KEY, sale.getShop());
		startActivity(intent);
	}

	private void favoritSale(final MenuItem item) {
		item.setEnabled(false);
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"收藏失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return SaleFavoritProcessor.getInstance(SaleDetailActivity.this)
								.addSaleFavorit(sale, RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						saleFavorited = true;
						updateMenuStatus();
					}

					@Override
					public void onFailed(String errorMessage) {
						item.setEnabled(true);
						super.onFailed(errorMessage);
					}
				});
	}

	private void cancelFavoritSale(final MenuItem item) {
		item.setEnabled(false);
		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"取消收藏失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						return SaleFavoritProcessor.getInstance(SaleDetailActivity.this)
								.deleteSaleFavorit(sale.getUuid(),
										RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						saleFavorited = false;
						updateMenuStatus();
					}

					@Override
					public void onFailed(String errorMessage) {
						super.onFailed(errorMessage);
						item.setEnabled(true);
					}
				});
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.sale_detail_main), show);
	}

}
