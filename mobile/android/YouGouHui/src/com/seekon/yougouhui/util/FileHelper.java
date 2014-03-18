package com.seekon.yougouhui.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.content.Context;
import android.os.Environment;

import com.seekon.yougouhui.YouGouHuiApp;

/**
 * 
 * 文件读写操作类
 * 
 * @author undyliu
 * 
 */
public class FileHelper {

	private static final String TAG = FileHelper.class.getSimpleName();

	private FileHelper() {
	}

	public static void write(byte[] content, String fileName) {
		write(content, fileName, Context.MODE_PRIVATE);
	}

	public static void write(byte[] content, String fileName, int mode) {
		if(fileExists(fileName)){
			return;
		}
		
		FileOutputStream os = null;
		try {
			os = getFileOutputStream(fileName, mode);
			os.write(content);
			os.flush();
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			closeOutputStream(os);
		}
	}

	public static void write(InputStream is, String fileName) {
		write(is, fileName, Context.MODE_PRIVATE);
	}

	public static void write(InputStream is, String fileName, int mode) {
		if(fileExists(fileName)){
			return;
		}
		
		byte[] content = new byte[1024];
		Context context = YouGouHuiApp.getAppContext();
		FileOutputStream os = null;
		try {
			os = context.openFileOutput(fileName, mode);
			int size = 0;
			while ((size = is.read(content)) != -1) {
				os.write(content, 0, size);
			}
			os.flush();
		} catch (Exception e) {
			Logger.error(TAG, e.getMessage(), e);
		} finally {
			closeOutputStream(os);
		}
	}

	public static InputStream read(String fileName) {
		try {
			return getFileInputStream(fileName);
		} catch (FileNotFoundException e) {
			Logger.error(TAG, e.getMessage(), e);
		}
		return null;
	}

	/**
	 * 创建file文件对象，首先从sd卡中创建，若没有sd卡，则从手机本机存储中创建
	 * 
	 * @param fileName
	 * @throws FileNotFoundException
	 */
	private static FileOutputStream getFileOutputStream(String fileName, int mode)
			throws FileNotFoundException {
		if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			File sdCardDir = Environment.getExternalStorageDirectory();
			return new FileOutputStream(new File(sdCardDir, fileName));
		}
		return YouGouHuiApp.getAppContext().openFileOutput(fileName, mode);
	}
	
	/**
	 * 
	 * @param fileName
	 * @return
	 * @throws FileNotFoundException
	 */
	private static InputStream getFileInputStream(String fileName) throws FileNotFoundException{
		if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			File sdCardDir = Environment.getExternalStorageDirectory();
			return new FileInputStream(new File(sdCardDir, fileName));
		}
		return YouGouHuiApp.getAppContext().openFileInput(fileName);
	}
	
	public static boolean fileExists(String fileName){
		InputStream is = null;
		try{
			is = getFileInputStream(fileName);
			return is != null && is.read() > 0;
		}catch(Exception e){
			Logger.error(TAG, e.getMessage(), e);
		}finally{
			closeInputStream(is);
		}
		return false;
	}
	
	public static void closeOutputStream(OutputStream os){
		if (os != null) {
			try {
				os.close();
			} catch (IOException e) {
				Logger.error(TAG, e.getMessage(), e);
			}
		}
	}
	
	public static void closeInputStream(InputStream is){
		if (is != null) {
			try {
				is.close();
			} catch (IOException e) {
				Logger.error(TAG, e.getMessage(), e);
			}
		}
	}
}
