package com.seekon.yougouhui.func.profile.shop;

import java.io.Serializable;

public class TradeEntity implements Serializable {

	private static final long serialVersionUID = 2423254379959590316L;

	private String uuid;
	private String code;
	private String name;

	public TradeEntity() {
		super();
	}

	public TradeEntity(String uuid, String code, String name) {
		super();
		this.uuid = uuid;
		this.code = code;
		this.name = name;
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

}
