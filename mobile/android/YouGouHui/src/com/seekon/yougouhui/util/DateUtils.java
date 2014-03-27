package com.seekon.yougouhui.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	public static SimpleDateFormat dateformat = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	private DateUtils() {
	}

	public static String formartTime(long time) {
		Date date = new Date(time);
		return dateformat.format(date);
	}
}
