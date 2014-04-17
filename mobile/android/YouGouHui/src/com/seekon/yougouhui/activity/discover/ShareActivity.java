package com.seekon.yougouhui.activity.discover;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CONTENT;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;

import android.content.Intent;
import android.os.AsyncTask;
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
import com.seekon.yougouhui.activity.profile.shop.ChooseShopActivity;
import com.seekon.yougouhui.barcode.MipcaActivityCapture;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.discover.share.ShareConst;
import com.seekon.yougouhui.func.discover.share.ShareProcessor;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.spi.IShareProcessor;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.Logger;
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
		
		ShopEntity shop = (ShopEntity) this.getIntent().getSerializableExtra(ShopConst.DATA_SHOP_KEY);
		if(shop != null){
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

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				UserEntity user = RunEnv.getInstance().getUser();
				Map share = new HashMap();
				share.put(ShareConst.COL_NAME_PUBLISHER, user.getUuid());
				share.put(COL_NAME_CONTENT, shareContent);
				share.put(ShareConst.DATA_IMAGE_KEY, imageFileUriList);
				share.put(ShareConst.COL_NAME_SHOP_ID, choosedShopId);

				IShareProcessor processor = ShareProcessor
						.getInstance(ShareActivity.this);
				return processor.postShare(share);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);

				if (result == null) {
					ViewUtils.showToast("发布信息失败.");
					return;
				}
				if (result.getStatusCode() == 200) {
					Intent intent = new Intent();
					intent.putExtra(COL_NAME_CONTENT, shareContent);

					setResult(RESULT_OK, intent);
					clean();
					finish();
				} else {
					item.setEnabled(true);
					try {
						ViewUtils.showToast(result.getResource().getString("error"));
					} catch (JSONException e) {
						Logger.error(TAG, e.getMessage());
						ViewUtils.showToast("发布信息失败.");
					}
					return;
				}
			}

			@Override
			protected void onCancelled() {
				item.setEnabled(true);
				showProgress(false);
				super.onCancelled();
			}
		};
		item.setEnabled(false);
		showProgress(true);
		task.execute((Void) null);
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
