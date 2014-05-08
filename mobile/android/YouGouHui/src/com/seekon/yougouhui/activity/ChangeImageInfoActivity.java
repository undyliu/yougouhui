package com.seekon.yougouhui.activity;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.file.FileEntity;
import com.seekon.yougouhui.file.FileHelper;
import com.seekon.yougouhui.file.ImageLoader;

public abstract class ChangeImageInfoActivity extends Activity {

	protected static final int ICON_WIDTH = 200;

	protected static final int LOAD_IMAGE_ACTIVITY_REQUEST_CODE = 1;

	protected ImageView photoView = null;

	protected FileEntity imageFile = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.change_image_info);

		ActionBar actionBar = this.getActionBar();
		actionBar.setDisplayHomeAsUpEnabled(true);

		photoView = (ImageView) findViewById(R.id.image_icon);
		photoView.setLayoutParams(new FrameLayout.LayoutParams(ICON_WIDTH,
				ICON_WIDTH));
		photoView.setScaleType(ImageView.ScaleType.CENTER_CROP);

		imageFile = getImageFile();
		if (imageFile != null) {
			addUserIconToView();
		} else {
			photoView.setImageResource(R.drawable.add_camera);
		}

		photoView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(Intent.ACTION_PICK,
						android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
				startActivityForResult(intent, LOAD_IMAGE_ACTIVITY_REQUEST_CODE);
			}
		});

		TextView imageLabel = (TextView) findViewById(R.id.image_label);
		imageLabel.setText(getImageLabel());
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		this.getMenuInflater().inflate(R.menu.common_save, menu);
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
			doChangeImage(item);
			break;
		default:
			break;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if (requestCode == LOAD_IMAGE_ACTIVITY_REQUEST_CODE) {
			if (resultCode == RESULT_OK && null != data) {
				Uri selectedImage = data.getData();
				String[] filePathColumn = { MediaStore.Images.Media.DATA };
				Cursor cursor = null;
				try {
					cursor = getContentResolver().query(selectedImage, filePathColumn,
							null, null, null);
					cursor.moveToFirst();
					int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
					String fileUrl = cursor.getString(columnIndex);
					imageFile = new FileEntity(fileUrl, FileHelper.getAliasName(fileUrl));
				} finally {
					cursor.close();
				}
				addUserIconToView();
			}
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private void addUserIconToView() {
		String fileUrl = imageFile.getFileUri();
		if (fileUrl != null && fileUrl.trim().length() > 0) {
			photoView.setImageBitmap(FileHelper.decodeFile(fileUrl, true, ICON_WIDTH,
					ICON_WIDTH));
		} else {
			String aliasName = imageFile.getAliasName();
			if (aliasName != null && aliasName.trim().length() > 0) {
				ImageLoader.getInstance().displayImage(aliasName, photoView, true);
			}else{
				photoView.setImageResource(R.drawable.add_camera);
			}
		}

		final ImageButton iconPreview = (ImageButton) findViewById(R.id.image_icon_preview);
		iconPreview.setVisibility(View.VISIBLE);
		iconPreview.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				Intent intent = new Intent(ChangeImageInfoActivity.this,
						ImagePreviewActivity.class);
				intent.putExtra(ImagePreviewActivity.IMAGE_SRC_KEY, imageFile);
				// intent
				// .putExtra(ImagePreviewActivity.SHOW_BY_LOCAL_FILE, showLocalImage);
				intent.putExtra(ImagePreviewActivity.IMAGE_DELETE_FLAG, false);
				startActivity(intent);
			}
		});

		final ImageButton iconDel = (ImageButton) findViewById(R.id.image_icon_del);
		iconDel.setVisibility(View.VISIBLE);
		iconDel.setOnClickListener(new View.OnClickListener() {

			@Override
			public void onClick(View v) {
				photoView.setImageResource(R.drawable.add_camera);
				iconDel.setVisibility(View.GONE);
				iconPreview.setVisibility(View.GONE);
				imageFile = null;
			}
		});
	}

	protected abstract void doChangeImage(final MenuItem item);

	protected abstract int getImageLabel();

	protected abstract FileEntity getImageFile();
}
