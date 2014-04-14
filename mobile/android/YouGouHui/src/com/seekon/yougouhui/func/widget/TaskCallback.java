package com.seekon.yougouhui.func.widget;

public interface TaskCallback<T> {

	public void onPostExecute(T result);

	public void onCancelled();
}
