package com.seekon.yougouhui.func.user;

import com.seekon.yougouhui.func.Entity;

public class UserProfileEntity extends Entity {

	private static final long serialVersionUID = -3511492462720388852L;

	private UserEntity user;

	private int shareCount;
	private int shareDiscussCount;
	private int gradeAmount;
	private int gradeUsed;
	private int gradeExceed;
	
	public UserProfileEntity(UserEntity user) {
		super();
		this.user = user;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public int getShareCount() {
		return shareCount;
	}

	public void setShareCount(int shareCount) {
		this.shareCount = shareCount;
	}

	public int getShareDiscussCount() {
		return shareDiscussCount;
	}

	public void setShareDiscussCount(int shareDiscussCount) {
		this.shareDiscussCount = shareDiscussCount;
	}

	public int getGradeAmount() {
		return gradeAmount;
	}

	public void setGradeAmount(int gradeAmount) {
		this.gradeAmount = gradeAmount;
	}

	public int getGradeUsed() {
		return gradeUsed;
	}

	public void setGradeUsed(int gradeUsed) {
		this.gradeUsed = gradeUsed;
	}

	public int getGradeExceed() {
		return gradeExceed;
	}

	public void setGradeExceed(int gradeExceed) {
		this.gradeExceed = gradeExceed;
	}

	public int getGradeRemain(){
		return this.gradeAmount - this.gradeUsed;
	}
}
