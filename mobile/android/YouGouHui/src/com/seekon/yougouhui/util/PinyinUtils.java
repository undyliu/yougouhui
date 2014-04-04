package com.seekon.yougouhui.util;

public class PinyinUtils {

	// private static HanyuPinyinOutputFormat defaultFormat = null;
	//
	// static {
	// defaultFormat = new HanyuPinyinOutputFormat();
	// defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
	// }
	//
	// private PinyinUtils() {
	// }
	//
	// public static String getPinYin(char c) {
	// String[] pinyin = null;
	// try {
	// pinyin = PinyinHelper.toHanyuPinyinStringArray(c, defaultFormat);
	// } catch (BadHanyuPinyinOutputFormatCombination e) {
	// e.printStackTrace();
	// }
	//
	// if (pinyin == null)
	// return new String(new char[] { c });
	//
	// // 只取一个发音，如果是多音字，仅取第一个发音
	// return pinyin[0];
	// }
	//
	// public static String getPinYin(String str) {
	// StringBuilder sb = new StringBuilder();
	// for (int i = 0; i < str.length(); ++i) {
	// sb.append(getPinYin(str.charAt(i)));
	// }
	// return sb.toString();
	// }

	public static String getPinYin(String str) {
		return CharacterParser.getInstance().getSelling(str);
	}
}
