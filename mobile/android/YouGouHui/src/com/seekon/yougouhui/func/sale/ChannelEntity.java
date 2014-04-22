package com.seekon.yougouhui.func.sale;

import com.seekon.yougouhui.func.Entity;

public class ChannelEntity extends Entity {

	private static final long serialVersionUID = 3244087502079025830L;

	private String code;
	private String name;
	private int ordIndex;

	public ChannelEntity() {
		super();
	}

	public ChannelEntity(String uuid, String code, String name, int ordIndex) {
		super(uuid);
		this.code = code;
		this.name = name;
		this.ordIndex = ordIndex;
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

	public int getOrdIndex() {
		return ordIndex;
	}

	public void setOrdIndex(int ordIndex) {
		this.ordIndex = ordIndex;
	}

}
