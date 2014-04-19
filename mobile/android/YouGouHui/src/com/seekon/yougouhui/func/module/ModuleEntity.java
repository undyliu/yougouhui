package com.seekon.yougouhui.func.module;

import java.io.Serializable;

public class ModuleEntity implements Serializable {

	private static final long serialVersionUID = 4177014469142742441L;

	private String uuid;
	private String code;
	private String name;
	private int imageResourceId;
	
 
	public ModuleEntity(String uuid, String code, String name, int imageResourceId) {
		super();
		this.uuid = uuid;
		this.code = code;
		this.name = name;
		this.imageResourceId = imageResourceId;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getImageResourceId() {
		return imageResourceId;
	}

	public void setImageResourceId(int imageResourceId) {
		this.imageResourceId = imageResourceId;
	}

}
