package com.seekon.yougouhui.func.grade;

import com.seekon.yougouhui.func.Entity;
import com.seekon.yougouhui.func.shop.ShopEntity;

public class GradeItemsEntity extends Entity {

	private static final long serialVersionUID = -313252185629764999L;

	private String userId;
	private String grader;
	private long gradeTime;
	private long endTime;
	private int gradeAmout;
	private int gradeUsed;
	private ShopEntity shop;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getGrader() {
		return grader;
	}

	public void setGrader(String grader) {
		this.grader = grader;
	}

	public long getGradeTime() {
		return gradeTime;
	}

	public void setGradeTime(long gradeTime) {
		this.gradeTime = gradeTime;
	}

	public long getEndTime() {
		return endTime;
	}

	public void setEndTime(long endTime) {
		this.endTime = endTime;
	}

	public int getGradeAmout() {
		return gradeAmout;
	}

	public void setGradeAmout(int gradeAmout) {
		this.gradeAmout = gradeAmout;
	}

	public int getGradeUsed() {
		return gradeUsed;
	}

	public void setGradeUsed(int gradeUsed) {
		this.gradeUsed = gradeUsed;
	}

	public ShopEntity getShop() {
		return shop;
	}

	public void setShop(ShopEntity shop) {
		this.shop = shop;
	}


}
