package com.seekon.yougouhui.activity.share;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.PicContainerActivity;
import com.seekon.yougouhui.activity.shop.ChooseShopActivity;
import com.seekon.yougouhui.barcode.MipcaActivityCapture;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.share.ShareConst;
import com.seekon.yougouhui.func.share.ShareEntity;
import com.seekon.yougouhui.func.share.ShareProcessor;
import com.seekon.yougouhui.func.shop.ShopConst;
import com.seekon.yougouhui.func.shop.ShopEntity;
import com.seekon.yougouhui.func.spi.IShareProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.AbstractRestTaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestUtils;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

public class ShareActivity extends PicContainerActivity {

	private final static int SCANNIN_REQUEST_CODE = 400;

	private final static int CHOOSE_SHOP_REQUEST_CODE = 500;

	private String choosedShopId = null;

	private EditText choosedShopNameView = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {

		setContentView(R.layout.discover_share);

		Button barcodeScan = (Button) findViewById(R.id.b_scan_shop_barcode);
		barcodeScan.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent();
				intent.setClass(ShareActivity.this, MipcaActivityCapture.class);
				intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
				startActivityForResult(intent, SCANNIN_REQUEST_CODE);
			}
		});

		Button chooseShop = (Button) findViewById(R.id.b_choose_shop);
		chooseShop.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent();
				intent.setClass(ShareActivity.this, ChooseShopActivity.class);
				startActivityForResult(intent, CHOOSE_SHOP_REQUEST_CODE);
			}
		});

		choosedShopNameView = (EditText) findViewById(R.id.share_shop_barcode);

		ShopEntity shop = (ShopEntity) this.getIntent().getSerializableExtra(
				ShopConst.DATA_SHOP_KEY);
		if (shop != null) {
			choosedShopId = shop.getUuid();
			choosedShopNameView.setText(shop.getName());
		}

		super.onCreate(savedInstanceState);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.discover_share, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case R.id.menu_discover_share:
			this.publishShare(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == SCANNIN_REQUEST_CODE) {
			if (resultCode == RESULT_OK) {
				String barcode = data.getExtras().getString("result");
				if (barcode != null && barcode.length() > 0) {
					String[] barcodes = barcode.split(";");
					if (barcodes.length == 2) {
						choosedShopId = barcodes[0];
						choosedShopNameView.setText(barcodes[1]);
					}
				} else {
					ViewUtils.showToast("扫描的商家二维码不正确.");
				}
			}
		} else if (requestCode == CHOOSE_SHOP_REQUEST_CODE) {
			if (resultCode == RESULT_OK && data != null) {
				ShopEntity shop = (ShopEntity) data
						.getSerializableExtra(ShopConst.DATA_SHOP_KEY);
				if (shop != null) {
					choosedShopNameView.setText(shop.getName());
					choosedShopId = shop.getUuid();
				}
			}
		}

		super.onActivityResult(requestCode, resultCode, data);
	}

	private void publishShare(final MenuItem item) {
		EditText view = (EditText) findViewById(R.id.share_content);
		final String shareContent = view.getText().toString();

		view.setError(null);
		if (TextUtils.isEmpty(shareContent)) {
			view.setError(this.getString(R.string.error_field_required));
			view.findFocus();
			return;
		}

		item.setEnabled(false);
		showProgress(true);

		RestUtils
				.executeAsyncRestTask(new AbstractRestTaskCallback<JSONObjResource>(
						"发布信息失败.") {

					@Override
					public RestMethodResult<JSONObjResource> doInBackground() {
						
						ShareEntity share = new ShareEntity();
						share.setContent(shareContent);
						share.setShopId(choosedShopId);
						share.setPublisher(RunEnv.getInstance().getUser());
						share.setImages(imageFileUriList);
						
						IShareProcessor processor = ShareProcessor
								.getInstance(ShareActivity.this);
						return processor.postShare(share);
					}

					@Override
					public void onSuccess(RestMethodResult<JSONObjResource> result) {
						Intent intent = new Intent();
						intent.putExtra(COL_NAME_CONTENT, shareContent);

						setResult(RESULT_OK, intent);
						clean();
						finish();
					}

					@Override
					public void onFailed(String errorMessage) {
						showProgress(false);
						item.setEnabled(true);
						super.onFailed(errorMessage);
					}

					@Override
					public void onCancelled() {
						item.setEnabled(true);
						showProgress(false);
						super.onCancelled();
					}
				});
	}

	private void showProgress(boolean show) {
		ViewUtils.showProgress(this, findViewById(R.id.discover_share), show,
				R.string.default_progress_status_message);
	}

	@Override
	public GridView getPicContainer() {
		return (GridView) findViewById(R.id.share_pic_container);
	}

}
