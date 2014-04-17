package com.seekon.yougouhui.func.spi;

import com.seekon.yougouhui.service.ProcessorCallback;

public interface IModuleProcessor {

	public void getModules(ProcessorCallback callback, String type);
}
