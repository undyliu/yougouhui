package com.seekon.yougouhui.activity.shop;


import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.ImagePreviewActivity;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.ImageLoader;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.shop.ShopProcessor;
import com.seekon.yougouhui.func.widget.AbstractChangeInfoTask;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class SetShopBarcodeActivity extends Activity {

	private static final int BARCODE_ICON_WITH = 300;

	private ShopEntity shop;
	private boolean readonly = true;
	private ImageView barCodeView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_set_barcode);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		readonly = this.getIntent().getBooleanExtra(DataConst.NAME_READONLY, true);
		shop = (ShopEntity) this.getIntent().getSerializableExtra(
				ShopConst.DATA_SHOP_KEY);

		initViews();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		if (!readonly) {
			getMenuInflater().inflate(R.menu.shop_barcode, menu);
		}
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int id = item.getItemId();
		switch (id) {
		case android.R.id.home:
			back();
			break;
		case R.id.menu_create_barcode:
			createBarcode(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		barCodeView = (ImageView) findViewById(R.id.image_shop_barcode);
		barCodeView.setScaleType(ImageView.ScaleType.CENTER_CROP);
		barCodeView.setLayoutParams(new LinearLayout.LayoutParams(
				BARCODE_ICON_WITH, BARCODE_ICON_WITH));

		final String barcode = shop.getBarcode();
		if (barcode != null && barcode.length() > 0) {
			ImageLoader.getInstance().displayImage(barcode, barCodeView, true);

			barCodeView.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					Intent intent = new Intent(SetShopBarcodeActivity.this,
							ImagePreviewActivity.class);
					intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, new FileEntity(null, barcode));
					intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);
					startActivity(intent);
				}
			});
		}
	}

	private void back() {
		Intent intent = new Intent();
		intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
		setResult(RESULT_OK, intent);
		finish();
	}

	private void createBarcode(final MenuItem item) {
		AbstractChangeInfoTask task = new AbstractChangeInfoTask(item) {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				return ShopProcessor.getInstance(SetShopBarcodeActivity.this)
						.createShopBarcode(shop);
			}

			@Override
			protected void showProgressInner(boolean show) {
				showProgress(show);
			}

			@Override
			protected void doSuccess(RestMethodResult<JSONObjResource> result) {
				String barcode = shop.getBarcode();
				if (barcode != null && barcode.length() > 0) {
					ImageLoader.getInstance().displayImage(barcode, barCodeView, true);
				}
			}
		};

		item.setEnabled(false);
		showProgress(true);
		task.execute((Void) null);
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, barCodeView, show);
	}
}
