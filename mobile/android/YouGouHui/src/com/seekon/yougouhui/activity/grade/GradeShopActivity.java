package com.seekon.yougouhui.activity.grade;

import android.app.ActionBar;
import android.app.Activity;
import android.app.ProgressDialog;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.seekon.yougouhui.Const;
import com.seekon.yougouhui.R;

/**
 * 使用webview的方式来处理积分商城
 * @author undyliu
 *
 */
public class GradeShopActivity extends Activity {

	private WebView webView;
	private ProgressDialog progressDialog;
	private Handler handler;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.base_webview);

		initViews();
		
		handler = new Handler() {
			public void handleMessage(Message msg) {
				if (!Thread.currentThread().isInterrupted()) {
					switch (msg.what) {
					case 0:
						progressDialog.show();
						break;
					case 1:
						progressDialog.hide();
						break;
					}
				}
				super.handleMessage(msg);
			}
		};
		
		loadurl(webView, Const.SERVER_APP_URL + "/pub/grade_shop.html");
	}

	private void initViews() {
		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		webView = (WebView) findViewById(R.id.webview_main);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setScrollBarStyle(0);// 滚动条风格，为0就是不给滚动条留空间，滚动条覆盖在网页上

		webView.setWebViewClient(new WebViewClient() {
			public boolean shouldOverrideUrlLoading(final WebView view,
					final String url) {
				loadurl(view, url);
				return true;
			}

		});
		webView.setWebChromeClient(new WebChromeClient() {
			public void onProgressChanged(WebView view, int progress) {
				if (progress == 100) {
					handler.sendEmptyMessage(1);
				}
				super.onProgressChanged(view, progress);
			}
		});

		progressDialog = new ProgressDialog(this);
		progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		progressDialog.setMessage("数据载入中，请稍候！");
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {// 捕捉返回键
		if ((keyCode == KeyEvent.KEYCODE_BACK) && webView.canGoBack()) {
			webView.goBack();
			return true;
		}
		return super.onKeyDown(keyCode, event);
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

	public void loadurl(final WebView view, final String url) {
		new Thread() {
			public void run() {
				handler.sendEmptyMessage(0);
				view.loadUrl(url);// 载入网页
			}
		}.start();
	}
}
