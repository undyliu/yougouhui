package com.seekon.yougouhui.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtils {

	private static final String TAG = DateUtils.class.getSimpleName();

	public static final SimpleDateFormat dateformat = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	public static final SimpleDateFormat yyyymmddFormat = new SimpleDateFormat(
			"yyyy-MM-dd");

	public static final SimpleDateFormat mmddFormat = new SimpleDateFormat(
			"MM月dd日");

	private DateUtils() {
	}

	public static String formartTime(long time) {
		Date date = new Date(time);
		return dateformat.format(date);
	}

	public static String formatTime_MMdd(long time) {
		Date date = new Date(time);
		return mmddFormat.format(date);
	}

	public static Date getDate_yyyyMMdd(String dateString) {
		try {
			return yyyymmddFormat.parse(dateString);
		} catch (ParseException e) {
			Logger.error(TAG, e.getMessage());
			throw new RuntimeException(e);
		}
	}

	public static int getYear(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.YEAR);
	}

	public static int getMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.MONTH) + 1;
	}

	public static int getDayOfMoth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.DAY_OF_MONTH);
	}

	public static String getDateString_yyyyMMdd(int year, int month,
			int dayOfMonth) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, dayOfMonth);
		return yyyymmddFormat.format(calendar.getTime());
	}
	
	public static String getDateString_yyyyMMdd(Date date) {
		return yyyymmddFormat.format(date.getTime());
	}
	
	public static boolean beforeDateString_yyyyMMdd(String date1, String date2){
		Calendar calendar1 = Calendar.getInstance();
		calendar1.setTime(getDate_yyyyMMdd(date1));
		
		Calendar calendar2 = Calendar.getInstance();
		calendar2.setTime(getDate_yyyyMMdd(date2));
		
		return calendar1.before(calendar2);
	}
}
