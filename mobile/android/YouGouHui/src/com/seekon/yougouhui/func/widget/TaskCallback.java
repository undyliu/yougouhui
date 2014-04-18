package com.seekon.yougouhui.func.widget;

public interface TaskCallback<T> {

	public T doInBackground();

	public void onSuccess(T result);

	public void onFailed(String errorMessage);

	public void onCancelled();
}
