package com.seekon.yougouhui.service;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import com.seekon.yougouhui.R;
import com.seekon.yougouhui.YouGouHuiApp;
import com.seekon.yougouhui.rest.RestMethodResult;
import com.seekon.yougouhui.rest.RestStatus;
import com.seekon.yougouhui.util.Logger;

public class ProcessorProxy implements InvocationHandler {

	private static final String TAG = ProcessorProxy.class.getSimpleName();

	private Object target;

	public Object bind(Object target) {
		this.target = target;
		return Proxy.newProxyInstance(target.getClass().getClassLoader(), target
				.getClass().getInterfaces(), this);
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		Object result = null;
		try {
			result = method.invoke(target, args);
		} catch (Throwable e) {// 处理运行过程中抛出的异常
			Logger.warn(TAG, e.getMessage());

			Class clazz = method.getReturnType();
			if (clazz.isAssignableFrom(RestMethodResult.class)) {
				result = new RestMethodResult(RestStatus.RUNTIME_ERROR, YouGouHuiApp
						.getAppContext().getString(R.string.runtime_error), null);
			}
		}
		return result;
	}

}
