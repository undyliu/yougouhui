package com.seekon.yougouhui.func.profile.contact;

import com.seekon.yougouhui.func.user.UserEntity;
import com.seekon.yougouhui.util.PinyinUtils;

public class ContactEntity extends UserEntity {

	private static final long serialVersionUID = -5260233131627278402L;

	private String pinyinName;

	public ContactEntity(String uuid, String phone, String name, String pwd,
			String photo) {
		super(uuid, phone, name, pwd, photo);
		pinyinName = PinyinUtils.getPinYin(name);
	}

	public String getPinyinName() {
		return pinyinName;
	}

	public String getFirstLetter() {
		return new String(new char[] { pinyinName.charAt(0) });
	}
}
