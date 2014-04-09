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
		TradeEntity other = (TradeEntity) obj;
		if (uuid == null) {
			if (other.uuid != null)
				return false;
		} else if (!uuid.equals(other.uuid))
			return false;
		return true;
	}

}
