package com.seekon.yougouhui.func.profile.contact;

import java.util.Comparator;

import com.seekon.yougouhui.func.user.UserEntity;

public class PinyinComparator implements Comparator<UserEntity> {

	public int compare(UserEntity o1, UserEntity o2) {

		return o1.getPinyinName().compareTo(o2.getPinyinName());

	}

}
