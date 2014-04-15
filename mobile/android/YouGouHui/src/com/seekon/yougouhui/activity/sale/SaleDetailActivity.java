package com.seekon.yougouhui.activity.sale;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.DisplayMetrics;
import android.view.Gravity;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.activity.profile.shop.ShopBaseInfoActivity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.sale.SaleDiscussData;
import com.seekon.yougouhui.func.sale.SaleDiscussEntity;
import com.seekon.yougouhui.func.sale.SaleDiscussProcessor;
import com.seekon.yougouhui.func.sale.SaleEntity;
import com.seekon.yougouhui.func.sale.SaleFavoritProcessor;
import com.seekon.yougouhui.func.sale.SaleUtils;
import com.seekon.yougouhui.func.sale.widget.DiscussPopupWindow;
import com.seekon.yougouhui.func.sale.widget.GetSaleTask;
import com.seekon.yougouhui.func.sale.widget.SaleDiscussListAdapter;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.layout.XListView;
import com.seekon.yougouhui.layout.XListView.IXListViewListener;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.DateUtils;
import com.seekon.yougouhui.util.ViewUtils;
import com.seekon.yougouhui.widget.ImageListRemoteAdapter;

public class SaleDetailActivity extends Activity implements IXListViewListener {

	private static final int SALE_IMAGE_WIDTH = 200;

	private SaleEntity sale = null;

	private List<SaleDiscussEntity> discussList = new ArrayList<SaleDiscussEntity>();

	TextView titleView;
	TextView contentView;
	TextView shopView;
	TextView distanceView;
	TextView endDateView;
	TextView visitCountView;
	TextView discussCountView;
	ImageView saleImageView;
	GridView saleImagesView;
	Button favoritButton;
	View discussView;
	XListView discussListView;
	ImageView discussExpandView;
	SaleDiscussListAdapter discussListAdapter;
	Button discussButton;

	private Handler mHandler;
	private SaleDiscussData saleDiscussData;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.channel_sale_detail);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		showProgress(true);

		mHandler = new Handler();
		saleDiscussData = new SaleDiscussData(this);

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

		favoritButton = (Button) findViewById(R.id.b_sale_favorite);

		discussExpandView = (ImageView) findViewById(R.id.img_sale_discuss_expand);

		discussListAdapter = new SaleDiscussListAdapter(this,
				new ArrayList<SaleDiscussEntity>());

		discussView = findViewById(R.id.discuss_view);

		discussListView = (XListView) findViewById(R.id.listview_main);
		discussListView.setPullLoadEnable(true);
		discussListView.setXListViewListener(this);
		discussListView.setAdapter(discussListAdapter);

		discussButton = (Button) findViewById(R.id.b_discuss);
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

		favoritButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

					@Override
					protected RestMethodResult<JSONObjResource> doInBackground(
							Void... params) {
						return SaleFavoritProcessor.getInstance(SaleDetailActivity.this)
								.addSaleFavorit(sale.getUuid(),
										RunEnv.getInstance().getUser().getUuid());
					}

					@Override
					protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
						if (result.getStatusCode() == 200) {
							favoritButton.setText(R.string.label_button_has_favorited);
							favoritButton.setEnabled(false);
						} else {
							ViewUtils.showToast("收藏失败.");
						}
					}

				};

				task.execute((Void) null);
			}
		});

		discussExpandView.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				discussView.setVisibility(View.VISIBLE);
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
				popupWindow.init(activity, sale.getUuid(), discussListAdapter);
				popupWindow.setBackgroundDrawable(new BitmapDrawable());
				popupWindow.setOutsideTouchable(true);
				popupWindow.setFocusable(true);
				popupWindow
						.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
				popupWindow.showAtLocation(discussView, Gravity.BOTTOM, 0, 0);

			}
		});
	}

	private void loadSaleData() {
		final String saleId = this.getIntent().getStringExtra(
				DataConst.COL_NAME_UUID);
		GetSaleTask task = new GetSaleTask(this,
				new TaskCallback<RestMethodResult<JSONObjResource>>() {

					@Override
					public void onPostExecute(RestMethodResult<JSONObjResource> result) {
						showProgress(false);
						if (result.getStatusCode() == 200) {
							sale = SaleUtils.getSale(SaleDetailActivity.this, saleId);
							sale.getImages().remove(sale.getImg());

							updateViews();
						} else {
							ViewUtils.showToast("获取活动数据失败.");
						}

					}

					@Override
					public void onCancelled() {
						showProgress(false);
					}
				}, saleId);

		task.execute((Void) null);

		AsyncTask<Void, Void, Boolean> favoritTask = new AsyncTask<Void, Void, Boolean>() {

			@Override
			protected Boolean doInBackground(Void... params) {
				return SaleUtils.isSaleFavorited(SaleDetailActivity.this, saleId,
						RunEnv.getInstance().getUser().getUuid());
			}

			@Override
			protected void onPostExecute(Boolean result) {
				if (result) {
					favoritButton.setText(R.string.label_button_has_favorited);
					favoritButton.setEnabled(false);
				}
			}
		};

		favoritTask.execute((Void) null);

		loadDiscussData(saleId);
	}

	private void loadDiscussData(final String saleId) {
		discussList = saleDiscussData.getDiscussList(saleId);
		if (discussList.isEmpty()) {
			AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONArrayResource>>() {

				@Override
				protected RestMethodResult<JSONArrayResource> doInBackground(
						Void... params) {
					return SaleDiscussProcessor.getInstance(SaleDetailActivity.this)
							.getDiscusses(saleId);
				}

				@Override
				protected void onPostExecute(RestMethodResult<JSONArrayResource> result) {
					if (result.getStatusCode() == 200) {
						discussList = saleDiscussData.getDiscussList(saleId);
						discussListAdapter.updateData(discussList);
					}
				}

			};
			task.execute((Void) null);
		} else {
			discussListAdapter.updateData(discussList);
		}
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

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.sale_detail_main), show);
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
