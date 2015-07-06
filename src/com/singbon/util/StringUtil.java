package com.singbon.util;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

public class StringUtil {

	/**
	 * byte转16进制字符
	 * 
	 * @return
	 */
	public static String toHexString(byte b) {
		String hex = Integer.toHexString(b & 0xFF);
		return hex;
	}

	/**
	 * 数字左补零
	 * 
	 * @return
	 */
	public static String leftPad(int str, int num) {
		String temp = Integer.toHexString(str);
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp = "0" + temp;
		}
		return temp;
	}

	/**
	 * 数字右补零
	 * 
	 * @return
	 */
	public static String rightPad(int str, int num) {
		String temp = Integer.toHexString(str);
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp += "0";
		}
		return temp;
	}

	// 转换日期格式为16进制字符串
	// 例：“2009-12-04” -> “9C04”
	// 修改2009-07-06：二进制前7位表示年，下4位月，最后5位表示日如"2009-07-06" -> "12E6"
	public static String dateToHexString(Calendar date) {
		String year = String.valueOf(date.get(Calendar.YEAR));
		int tmYear = Integer.valueOf(year.substring(2));
		int tmMonth = date.get(Calendar.MONTH) + 1;
		int tmDay = date.get(Calendar.DAY_OF_MONTH);

		String tmpStr = Integer.toHexString((tmYear << 1) | (tmMonth >> 3));
		if (tmpStr.length() == 1) {
			tmpStr = "0" + tmpStr;
		}

		String tmpStr2 = Integer.toHexString(tmMonth << 5 | tmDay);
		if (tmpStr2.length() == 1) {
			tmpStr2 = "0" + tmpStr2;
		}

		tmpStr += tmpStr2;

		if (tmpStr.length() == 4) {
			return tmpStr;
		}
		return "0000";
	}

	// 得到字节数组
	public static byte[] strTobytes(String str) {
		byte[] b = new byte[str.length() / 2];
		for (int i = 0; i < str.length() / 2; i++) {
			String s=str.substring(i * 2, i * 2+2);
			System.out.print(s+" ");
			b[i] = (byte) Integer.parseInt(s, 16);
		}
		return b;
	}

	/**
	 * 获取请求路径
	 * 
	 * @param request
	 * @return
	 */
	public static String requestBase(HttpServletRequest request) {
		String url = request.getRequestURI();
		url = url.replace("/WEB-INF/page", "");
		int last = url.lastIndexOf("/");
		url = url.substring(0, last);
		return url;
	}

	/**
	 * 获取转发路径
	 * 
	 * @param request
	 * @return
	 */
	public static String requestPath(HttpServletRequest request, String path) {
		String url = request.getRequestURI();
		url = url.replace("/WEB-INF/page", "");
		int last = url.lastIndexOf("/");
		url = url.substring(0, last + 1) + path;
		return url;
	}
}
