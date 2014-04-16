package com.seekon.yougouhui.func;

import java.io.Serializable;

/**
 * 地理位置
 * @author undyliu
 *
 */
public class LocationEntity implements Serializable{

	private static final long serialVersionUID = -5370688690944750615L;
	
	private double latitude;
	private double lontitude;
	private double radius;
	private String address;

	public LocationEntity() {
		super();
	}

	public LocationEntity(double latitude, double lontitude, double radius) {
		super();
		this.latitude = latitude;
		this.lontitude = lontitude;
		this.radius = radius;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLontitude() {
		return lontitude;
	}

	public void setLontitude(double lontitude) {
		this.lontitude = lontitude;
	}

	public double getRadius() {
		return radius;
	}

	public void setRadius(double radius) {
		this.radius = radius;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
}
