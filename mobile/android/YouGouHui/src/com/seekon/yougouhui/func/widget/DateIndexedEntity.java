package com.seekon.yougouhui.func.widget;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DateIndexedEntity implements Serializable {

	private static final long serialVersionUID = 9027364238896522863L;

	private Date date;
	private int itemCount;
	private List subItemList = new ArrayList();

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getItemCount() {
		return itemCount;
	}

	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}

	public List getSubItemList() {
		return subItemList;
	}

	public void setSubItemList(List subItemList) {
		this.subItemList = subItemList;
	}

}
