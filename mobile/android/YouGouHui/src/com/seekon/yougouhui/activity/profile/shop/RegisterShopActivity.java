package com.seekon.yougouhui.activity.profile.shop;

import static com.seekon.yougouhui.func.DataConst.COL_NAME_CODE;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_NAME;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_ORD_INDEX;
import static com.seekon.yougouhui.func.DataConst.COL_NAME_UUID;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.annotation.TargetApi;
import android.app.ActionBar;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.CompoundButton;
import android.widget.FrameLayout;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.func.DataConst;
import com.seekon.yougouhui.func.RunEnv;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;
import com.seekon.yougouhui.func.profile.shop.ShopProcessor;
import com.seekon.yougouhui.func.profile.shop.TradeConst;
import com.seekon.yougouhui.func.profile.shop.TradeEntity;
import com.seekon.yougouhui.func.profile.shop.widget.GetTradesTask;
import com.seekon.yougouhui.func.profile.shop.widget.RegisterPagerAdapter;
import com.seekon.yougouhui.func.profile.shop.widget.TradeListAdapter;
import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.func.widget.TaskCallback;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.resource.JSONArrayResource;
import com.seekon.yougouhui.rest.resource.JSONObjResource;
import com.seekon.yougouhui.util.ViewUtils;

/**
 * 注册商铺
 * 
 * @author undyliu
 * 
 */
public class RegisterShopActivity extends TradeCheckedChangeActivity implements
		OnPageChangeListener {

	private static final int SHOP_ICON_WIDTH = 100;

	private static final int LOAD_IMAGE_REQUEST_CODE = 1;

	private static final int LOAD_LICENSE_REQUEST_CODE = 2;

	private static List<String> pageTitles = new ArrayList<String>();
	static {
		pageTitles.add("免责授权");
		pageTitles.add("基本信息");
		pageTitles.add("设置密码");
	}

	private LayoutInflater mInflater;
	private ViewPager viewPager;
	private View licenseInfoView;
	private View baseInfoView;
	private View pwdInfoView;

	private TextView nameView;
	private ImageView shopImgView;
	private TextView addrView;
	private TextView descView;
	private ImageView busiLicenseView;
	private TradeListAdapter tradeAdapter;
	private List<TradeEntity> trades = new ArrayList<TradeEntity>();

	private String shopImage = null;
	private String busiLicense = null;
	private List<TradeEntity> selectedTrades = new ArrayList<TradeEntity>();

	private TextView pwdView;
	private TextView pwdConfView;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.shop_register);
		mInflater = LayoutInflater.from(this);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		initViews();

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.common_save, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		int itemId = item.getItemId();
		switch (itemId) {
		case android.R.id.home:
			this.finish();
			break;
		case R.id.menu_common_save:
			registerShop(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	private void initViews() {
		licenseInfoView = mInflater.inflate(R.layout.shop_register_license, null);
		baseInfoView = mInflater.inflate(R.layout.shop_register_base, null);
		pwdInfoView = mInflater.inflate(R.layout.shop_register_pwd, null);

		viewPager = (ViewPager) findViewById(R.id.shop_register_viewpager);
		viewPager.setOnPageChangeListener(this);
		viewPager.setCurrentItem(0);

		List<View> pageViews = new ArrayList<View>();
		pageViews.add(licenseInfoView);
		pageViews.add(baseInfoView);
		pageViews.add(pwdInfoView);
		viewPager.setAdapter(new RegisterPagerAdapter(pageViews, pageTitles));

		GridView tradeView = (GridView) baseInfoView
				.findViewById(R.id.shop_trade_view);
		
		tradeAdapter = new TradeListAdapter(this, getTradeList());
		tradeView.setAdapter(tradeAdapter);

		loadTrades();

		nameView = (TextView) baseInfoView.findViewById(R.id.shop_name);
		addrView = (TextView) baseInfoView.findViewById(R.id.shop_address);
		descView = (TextView) baseInfoView.findViewById(R.id.shop_desc);
		shopImgView = (ImageView) baseInfoView.findViewById(R.id.shop_image);
		busiLicenseView = (ImageView) baseInfoView
				.findViewById(R.id.shop_busi_license);

		shopImgView.setLayoutParams(new FrameLayout.LayoutParams(SHOP_ICON_WIDTH,
				SHOP_ICON_WIDTH));
		shopImgView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_IMAGE_REQUEST_CODE);
			}
		});

		busiLicenseView.setLayoutParams(new FrameLayout.LayoutParams(
				SHOP_ICON_WIDTH, SHOP_ICON_WIDTH));
		busiLicenseView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_LICENSE_REQUEST_CODE);
			}
		});

		pwdView = (TextView) pwdInfoView.findViewById(R.id.password);
		pwdConfView = (TextView) pwdInfoView.findViewById(R.id.password_conf);
	}

	private List<Map<String, ?>> getTradeList(){
		List<Map<String, ?>> tradeList = new ArrayList<Map<String, ?>>();
		for(TradeEntity trade : trades){
			Map data = new HashMap();
			data.put(DataConst.NAME_CHECKED, false);
			data.put(TradeConst.DATA_TRADE_KEY, trade);
			tradeList.add(data);
		}
		return tradeList;
	}
	
	private void loadTrades() {
		loadTradeFromLocal();
		if (trades.isEmpty()) {
			loadTradesFromRemote();
		} else {
			tradeAdapter.updateData(getTradeList());
		}
	}

	private void loadTradeFromLocal() {
		Cursor cursor = null;
		try {
			cursor = this.getContentResolver().query(
					TradeConst.CONTENT_URI,
					new String[] { COL_NAME_UUID, COL_NAME_CODE, COL_NAME_NAME,
							COL_NAME_ORD_INDEX }, null, null, COL_NAME_ORD_INDEX);
			while (cursor.moveToNext()) {
				if (cursor.getString(1).equalsIgnoreCase("all")) {
					continue;
				}
				int i = 0;
				trades.add(new TradeEntity(cursor.getString(i++),
						cursor.getString(i++), cursor.getString(i++)));
			}
		} finally {
			cursor.close();
		}
	}

	private void loadTradesFromRemote() {
		GetTradesTask task = new GetTradesTask(RegisterShopActivity.this,
				new TaskCallback<RestMethodResult<JSONArrayResource>>() {

					@Override
					public void onPostExecute(RestMethodResult<JSONArrayResource> result) {
						int status = result.getStatusCode();
						if (status == 200) {
							loadTradeFromLocal();
							tradeAdapter.notifyDataSetChanged();
						} else {
							ViewUtils.showToast("获取主营业务数据失败.");
						}
					}

					@Override
					public void onCancelled() {

					}
				});

		task.execute((Void) null);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case LOAD_IMAGE_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				shopImage = addShopIconToView(
						(ImageView) findViewById(R.id.shop_image),
						(ImageButton) findViewById(R.id.shop_image_del), data);
			}
			break;
		case LOAD_LICENSE_REQUEST_CODE:
			if (resultCode == RESULT_OK && data != null) {
				busiLicense = addShopIconToView(
						(ImageView) findViewById(R.id.shop_busi_license),
						(ImageButton) findViewById(R.id.shop_busi_license_del), data);
			}
		default:
			break;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
	private String addShopIconToView(final ImageView imageView,
			final ImageButton delButton, Intent data) {
		String iconPath = null;
		Uri selectedImage = data.getData();
		String[] filePathColumn = { MediaStore.Images.Media.DATA };
		Cursor cursor = null;
		try {
			cursor = getContentResolver().query(selectedImage, filePathColumn, null,
					null, null);
			cursor.moveToFirst();
			int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
			iconPath = cursor.getString(columnIndex);
		} finally {
			cursor.close();
		}

		imageView.setBackgroundResource(0);
		imageView.setBackground(new BitmapDrawable(FileHelper.decodeFile(iconPath,
				true, SHOP_ICON_WIDTH, SHOP_ICON_WIDTH)));

		delButton.setVisibility(View.VISIBLE);
		delButton.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				imageView.setBackgroundResource(R.drawable.add_camera);
				delButton.setVisibility(View.GONE);

				int viewId = v.getId();
				if (viewId == R.id.shop_busi_license_del) {
					busiLicense = null;
				} else if (viewId == R.id.shop_image_del) {
					shopImage = null;
				}
			}
		});
		return iconPath;
	}

	private void registerShop(final MenuItem item) {
		nameView.setError(null);
		addrView.setError(null);
		descView.setError(null);
		pwdView.setError(null);
		pwdConfView.setError(null);

		View focusView = null;
		boolean cancel = false;
		String requiredError = getString(R.string.error_field_required);

		final String password = pwdView.getText().toString();
		final String passwordConf = pwdConfView.getText().toString();
		if (TextUtils.isEmpty(passwordConf)) {
			pwdConfView.setError(requiredError);
			focusView = pwdConfView;
			cancel = true;
		} else if (passwordConf.length() < 4) {
			pwdConfView.setError(getString(R.string.error_invalid_password));
			focusView = pwdConfView;
			cancel = true;
		}
		if (!password.equals(passwordConf)) {
			pwdConfView.setError(getString(R.string.error_password_inconfirmed));
			focusView = pwdConfView;
			cancel = true;
		}
		if (TextUtils.isEmpty(password)) {
			pwdView.setError(requiredError);
			focusView = pwdView;
			cancel = true;
		} else if (password.length() < 4) {
			pwdView.setError(getString(R.string.error_invalid_password));
			focusView = pwdView;
			cancel = true;
		}

		final String desc = descView.getText().toString();
		if (TextUtils.isEmpty(desc)) {
			descView.setError(requiredError);
			focusView = descView;
			cancel = true;
		}
		final String address = addrView.getText().toString();
		if (TextUtils.isEmpty(address)) {
			addrView.setError(requiredError);
			focusView = addrView;
			cancel = true;
		}
		final String name = nameView.getText().toString();
		if (TextUtils.isEmpty(name)) {
			nameView.setError(requiredError);
			focusView = nameView;
			cancel = true;
		}

		if (cancel) {
			focusView.requestFocus();
			if (focusView.equals(pwdView) || focusView.equals(pwdConfView)) {
				viewPager.setCurrentItem(2);
			} else {
				viewPager.setCurrentItem(1);
			}
			return;
		}

		if (shopImage == null) {
			ViewUtils.showToast("请选择商铺图片.");
			viewPager.setCurrentItem(1);
			return;
		}
		if (busiLicense == null) {
			ViewUtils.showToast("请选择营业执照的图片.");
			viewPager.setCurrentItem(1);
			return;
		}
		if (selectedTrades == null || selectedTrades.isEmpty()) {
			ViewUtils.showToast("请选择主营业务.");
			viewPager.setCurrentItem(1);
			return;
		}

		AsyncTask<Void, Void, RestMethodResult<JSONObjResource>> task = new AsyncTask<Void, Void, RestMethodResult<JSONObjResource>>() {

			@Override
			protected RestMethodResult<JSONObjResource> doInBackground(Void... params) {
				ShopEntity shop = new ShopEntity();
				shop.setAddress(address);
				shop.setName(name);
				shop.setDesc(desc);
				shop.setShopImage(shopImage);
				shop.setBusiLicense(busiLicense);
				shop.setTrades(selectedTrades);

				UserEntity currentUser = RunEnv.getInstance().getUser();
				shop.setOwner(currentUser.getUuid());
				UserEntity emp = currentUser.clone();
				if (emp != null) {
					emp.setPwd(password);
					shop.addEmployee(emp);
				}

				return ShopProcessor.getInstance(RegisterShopActivity.this)
						.registerShop(shop);
			}

			@Override
			protected void onPostExecute(RestMethodResult<JSONObjResource> result) {
				showProgress(false);
				item.setEnabled(true);
				int status = result.getStatusCode();
				if (status == 200) {
					Intent intent = new Intent();
					setResult(RESULT_OK, intent);
					finish();
				} else {
					ViewUtils.showToast("注册商铺失败.");
				}
			}

			@Override
			protected void onCancelled() {
				showProgress(false);
				item.setEnabled(true);
				super.onCancelled();
			}
		};

		showProgress(true);
		item.setEnabled(false);
		task.execute((Void) null);
	}

	private void showProgress(final boolean show) {
		ViewUtils.showProgress(this, viewPager, show);
	}

	@Override
	public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
		int id = buttonView.getId();
		TradeEntity trade = trades.get(id);
		if (isChecked) {
			if (!selectedTrades.contains(trade)) {
				selectedTrades.add(trade);
			}
		} else {
			selectedTrades.remove(trade);
		}
	}

	@Override
	public void onPageScrollStateChanged(int state) {

	}

	@Override
	public void onPageScrolled(int position, float positionOffset,
			int positionOffsetPixels) {

	}

	@Override
	public void onPageSelected(int position) {

	}
}
