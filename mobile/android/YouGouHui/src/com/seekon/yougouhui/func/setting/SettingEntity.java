package com.seekon.yougouhui.func.setting;

import java.io.Serializable;

public class SettingEntity implements Serializable {

	private static final long serialVersionUID = -2824285180400025486L;

	private String uuid;
	private String code;
	private String name;
	private String img;
	private String value;

	public SettingEntity(String uuid, String code, String name, String img) {
		super();
		this.uuid = uuid;
		this.code = code;
		this.name = name;
		this.img = img;
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

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
