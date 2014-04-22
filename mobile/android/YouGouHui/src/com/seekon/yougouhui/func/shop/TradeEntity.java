package com.seekon.yougouhui.func.shop;

import com.seekon.yougouhui.func.Entity;

public class TradeEntity extends Entity {

	private static final long serialVersionUID = 2423254379959590316L;

	private String code;
	private String name;

	public TradeEntity() {
		super();
	}

	public TradeEntity(String uuid, String code, String name) {
		super(uuid);
		this.code = code;
		this.name = name;
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
