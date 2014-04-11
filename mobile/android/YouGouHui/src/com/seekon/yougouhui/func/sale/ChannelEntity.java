package com.seekon.yougouhui.func.sale;

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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((uuid == null) ? 0 : uuid.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ChannelEntity other = (ChannelEntity) obj;
		if (uuid == null) {
			if (other.uuid != null)
				return false;
		} else if (!uuid.equals(other.uuid))
			return false;
		return true;
	}

}
