package com.seekon.yougouhui.func;

import java.util.Comparator;

public class PinyinComparator implements Comparator<PinyinEntity> {

	public int compare(PinyinEntity o1, PinyinEntity o2) {

		return o1.getPinyinName().compareTo(o2.getPinyinName());

	}

}
