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
	
	private DateUtils() {
	}

	public static String formartTime(long time) {
		Date date = new Date(time);
		return dateformat.format(date);
	}
	
	public static Date getDate_yyyyMMdd(String dateString){
		try {
			return yyyymmddFormat.parse(dateString);
		} catch (ParseException e) {
			Logger.error(TAG, e.getMessage());
			throw new RuntimeException(e);
		}
	}
	
	public static int getMonth(Date date){
		Calendar calendar = Calendar.getInstance(); 
		calendar.setTime(date);
		return calendar.get(Calendar.MONTH) + 1;
	}
	
	public static int getDate(Date date){
		Calendar calendar = Calendar.getInstance(); 
		calendar.setTime(date);
		return calendar.get(Calendar.DAY_OF_MONTH);
	}
}
