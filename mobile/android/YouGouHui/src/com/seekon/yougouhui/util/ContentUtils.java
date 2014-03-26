package com.seekon.yougouhui.util;

import android.content.ContentUris;
import android.net.Uri;

public class ContentUtils extends ContentUris {

	public static String parseStringId(Uri contentUri) {
		return contentUri.getLastPathSegment();
	}

	public static Uri.Builder appendId(Uri.Builder builder, String id) {
		return builder.appendEncodedPath(id);
	}

	public static Uri withAppendedId(Uri contentUri, String id) {
		return appendId(contentUri.buildUpon(), id).build();
	}
}
