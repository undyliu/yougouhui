package com.seekon.yougouhui.func.profile.contact;

import java.util.Comparator;

public class PinyinComparator implements Comparator<ContactEntity> {

	public int compare(ContactEntity o1, ContactEntity o2) {

		return o1.getPinyinName().compareTo(o2.getPinyinName());

	}

}
