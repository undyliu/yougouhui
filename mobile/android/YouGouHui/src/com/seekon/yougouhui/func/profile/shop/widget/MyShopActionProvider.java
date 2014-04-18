package com.seekon.yougouhui.func.profile.shop.widget;

import java.lang.reflect.Field;

import android.content.Context;
import android.content.Intent;
import android.view.ActionProvider;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.PopupMenu.OnMenuItemClickListener;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.activity.profile.shop.ChangeShopPwdActivity;
import com.seekon.yougouhui.activity.profile.shop.ShopMainActivity;
import com.seekon.yougouhui.activity.sale.SalePublishActivity;
import com.seekon.yougouhui.func.profile.shop.ShopConst;
import com.seekon.yougouhui.func.profile.shop.ShopEntity;

public class MyShopActionProvider extends ActionProvider {

	private Context context;

	PopupMenu mPopupMenu;

	private ShopEntity shop = null;

	public MyShopActionProvider(Context context) {
		super(context);
		this.context = context;
	}

	@Override
	@Deprecated
	public View onCreateActionView() {
		LayoutInflater layoutInflater = LayoutInflater.from(context);
		View view = layoutInflater.inflate(R.layout.action_add_provider, null);
		ImageView popupView = (ImageView) view.findViewById(R.id.action_add_view);
		popupView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				showPopup(v);
			}
		});
		return view;
	}

	/**
	 * show the popup menu.
	 * 
	 * @param v
	 */
	private void showPopup(View v) {
		setShopFromContext();

		mPopupMenu = new PopupMenu(context, v);
		mPopupMenu.setOnMenuItemClickListener(new OnMenuItemClickListener() {

			@Override
			public boolean onMenuItemClick(MenuItem item) {
				int itemId = item.getItemId();
				switch (itemId) {
				case R.id.menu_change_pwd:
					changeShopEmpPwd();
					break;
				case R.id.menu_publish_new_sale:
					publishNewSale();
					break;
				default:
					break;
				}
				return false;
			}

		});

		Menu menu = mPopupMenu.getMenu();
		MenuInflater inflater = mPopupMenu.getMenuInflater();
		inflater.inflate(R.menu.my_shop_pop, menu);

		String status = shop.getStatus();
		if (!status.equals(ShopConst.STATUS_AUDITED)) {
			menu.findItem(R.id.menu_publish_new_sale).setVisible(false);
		}
		mPopupMenu.show();
	}

	private void setShopFromContext() {
		try {
			Field field = context.getClass().getDeclaredField("mBase");
			field.setAccessible(true);
			ShopMainActivity activity = (ShopMainActivity) field.get(context);
			shop = activity.getCurrentShop();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void changeShopEmpPwd() {
		Intent intent = new Intent(context, ChangeShopPwdActivity.class);
		intent.putExtra(ShopConst.DATA_SHOP_KEY, shop);
		context.startActivity(intent);
	}

	private void publishNewSale() {
		Intent intent = new Intent(context, SalePublishActivity.class);
		intent.putExtra(ShopConst.COL_NAME_UUID, shop.getUuid());
		context.startActivity(intent);
	}
}