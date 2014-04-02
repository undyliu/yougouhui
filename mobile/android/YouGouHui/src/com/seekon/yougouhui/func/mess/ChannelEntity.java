package com.seekon.yougouhui.func.mess;

import java.io.Serializable;

public class ChannelEntity implements Serializable {

	private static final long serialVersionUID = 3244087502079025830L;

	private String uuid;
	private String code;
	private String name;
	private int ordIndex;

	public ChannelEntity() {
		super();
	}

	public ChannelEntity(String uuid, String code, String name, int ordIndex) {
		super();
		this.uuid = uuid;
		this.code = code;
		this.name = name;
		this.ordIndex = ordIndex;
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

	public int getOrdIndex() {
		return ordIndex;
	}

	public void setOrdIndex(int ordIndex) {
		this.ordIndex = ordIndex;
	}

}
