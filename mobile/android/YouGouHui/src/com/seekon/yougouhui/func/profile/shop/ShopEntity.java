package com.seekon.yougouhui.func.profile.shop;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.seekon.yougouhui.func.user.UserEntity;

public class ShopEntity implements Serializable {

	private static final long serialVersionUID = -7361233046679253011L;

	private String uuid;
	private String name;
	private String address;
	private String desc;
	private String shopImage;
	private String busiLicense;
	private long registerTime;
	private String owner;
	private String status;
	private String barcode;
	
	private List<TradeEntity> trades = new ArrayList<TradeEntity>();
	private List<UserEntity> employees = new ArrayList<UserEntity>();

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getShopImage() {
		return shopImage;
	}

	public void setShopImage(String shopImage) {
		this.shopImage = shopImage;
	}

	public String getBusiLicense() {
		return busiLicense;
	}

	public void setBusiLicense(String busiLicense) {
		this.busiLicense = busiLicense;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public long getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(long registerTime) {
		this.registerTime = registerTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public List<TradeEntity> getTrades() {
		return trades;
	}

	public void setTrades(List<TradeEntity> trades) {
		this.trades = trades;
	}

	public List<UserEntity> getEmployees() {
		return employees;
	}

	public void setEmployees(List<UserEntity> employees) {
		this.employees = employees;
	}
	
	public void addEmployee(UserEntity emp){
		this.employees.add(emp);
	}
	
	public void addTrade(TradeEntity trade){
		this.trades.add(trade);
	}
}
