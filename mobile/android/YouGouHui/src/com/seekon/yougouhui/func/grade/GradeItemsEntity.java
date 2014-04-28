package com.seekon.yougouhui.func.grade;

import com.seekon.yougouhui.func.Entity;

public class GradeItemsEntity extends Entity {

	private static final long serialVersionUID = -313252185629764999L;

	private String userId;
	private String grader;
	private long gradeTime;
	private int grade;

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

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

}
