package com.singbon.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.singbon.device.CRC16;

public class StringUtil {

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
	 * @param path
	 *            后缀路径
	 * @return
	 */
	public static String requestPath(HttpServletRequest request, String path) {
		String url = request.getRequestURI();
		url = url.replace("/WEB-INF/page", "");
		int last = url.lastIndexOf("/");
		url = url.substring(0, last + 1) + path;
		return url;
	}

	/**
	 * byte转int
	 * 
	 * @return
	 */
	public static int byteToInt(byte b) {
		return b & 0xFF;
	}

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
	 * 返回数字左补零字符串，如1返回"01"
	 * 
	 * @return
	 */
	public static String leftPad(int str, int num) {
		String temp = Integer.toString(str);
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp = "0" + temp;
		}
		return temp;
	}

	/**
	 * 16进制数字左补零
	 * 
	 * @return
	 */
	public static String hexLeftPad(int str, int num) {
		String temp = Integer.toHexString(str).replace("ffffff", "");
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp = "0" + temp;
		}
		return temp;
	}

	/**
	 * 16进制数字右补零
	 * 
	 * @return
	 */
	public static String hexRightPad(int str, int num) {
		String temp = Integer.toHexString(str);
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp += "0";
		}
		return temp;
	}

	/**
	 * 字符串左补零
	 * 
	 * @return
	 */
	public static String stringLeftPad(String str, int num) {
		num = num - str.length();
		for (int i = 0; i < num; i++) {
			str = "0" + str;
		}
		return str;
	}

	/**
	 * 字符串右补零
	 * 
	 * @return
	 */
	public static String stringRightPad(String str, int num) {
		num = num - str.length();
		for (int i = 0; i < num; i++) {
			str += "0";
		}
		return str;
	}

	/**
	 * 转换日期格式为16进制字符串 例：“2009-12-04” -> “9C04”
	 * 修改2009-07-06：二进制前7位表示年，下4位月，最后5位表示日如"2009-07-06" -> "12E6"
	 * 
	 * @param date
	 * @return
	 */

	public static String dateToHexString(Calendar date) {
		String year = String.valueOf(date.get(Calendar.YEAR));
		byte tmYear = (byte) ((int) Integer.valueOf(year.substring(2)));
		byte tmMonth = (byte) (date.get(Calendar.MONTH) + 1);
		byte tmDay = (byte) date.get(Calendar.DAY_OF_MONTH);

		String tmpStr = Integer.toHexString((tmYear << 1) | (tmMonth >> 3));
		if (tmpStr.length() == 1) {
			tmpStr = "0" + tmpStr;
		}

		String tmpStr2 = Integer.toHexString((byte) (tmMonth << 5 | tmDay));
		tmpStr2 = tmpStr2.substring(tmpStr2.length() - 2);
		if (tmpStr2.length() == 1) {
			tmpStr2 = "0" + tmpStr2;
		}

		tmpStr += tmpStr2;

		if (tmpStr.length() == 4) {
			return tmpStr;
		}
		return "0000";
	}

	/**
	 * 转换16进制字符串为日期格式 例：“9C04” -> “2009-12-04”
	 * 修改2009-07-06：二进制前7位表示年，下4位月，最后5位表示日如"12E6" -> "2009-07-06"
	 */
	public static String dateFromHexString(String hexStr) {
		int tm1 = Integer.parseInt(hexStr.substring(0, 2), 16);
		int tm2 = Integer.parseInt(hexStr.substring(2), 16);
		int tmYear = (tm1 & 0XFE) >> 1;
		int tmMonth = (tm1 & 0X01) << 3 | (tm2 >> 5);
		int tmDay = tm2 & 0X1F;

		String year = "20" + leftPad(tmYear, 2);
		String month = leftPad(tmMonth, 2);
		String day = leftPad(tmDay, 2);

		String tmpDate = year + "-" + month + "-" + day;
		if (tmpDate.length() == 10) {
			return tmpDate;
		}
		return "0000-00-00";
	}

	/**
	 * 2进制字符串转16进制字符串
	 */
	public static String binaryHexString(String binary) {
		String[] strs = binary.split(" ");
		String result = "";
		for (String string : strs) {
			String hex = Integer.toString(Integer.parseInt(string, 2), 16);
			result += hex;
		}
		return result;
	}

	/**
	 * 四字节时间戳
	 * 
	 * @return
	 */
	public static String timeToHexString() {
		String tempStr = "";
		Calendar c = Calendar.getInstance();
		c.set(2000, 1, 1);
		long time = (System.currentTimeMillis() - c.getTimeInMillis()) / 1000;

		for (int i = 24; i >= 0; i -= 8) {
			String tmpStr1 = Integer.toHexString((byte) ((time >> i) & 0xff)).replace("ffffff", "");
			if (tmpStr1.length() == 1) {
				tempStr = "0" + tmpStr1;
			} else {
				tempStr += tmpStr1;
			}
		}

		return tempStr;
	}

	/**
	 * 得到字节数组
	 * 
	 * @param str
	 * @return
	 */
	public static byte[] strTobytes(String str) {
		byte[] b = new byte[str.length() / 2];
		for (int i = 0; i < str.length() / 2 - 2; i++) {
			String s = str.substring(i * 2, i * 2 + 2);
			StringUtil.print(s + " ");
			b[i] = (byte) Integer.parseInt(s, 16);
		}
		return b;
	}

	/**
	 * 获取国标码
	 * 
	 * @param str
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String strToGB2312(String str) throws UnsupportedEncodingException {
		String result = "";
		byte[] strByte = str.getBytes("GB2312");
		for (byte b : strByte) {
			result += StringUtil.hexLeftPad(b, 2);
		}
		return StringUtil.stringRightPad(result, 32);
	}

	/**
	 * 日期格式化
	 * 
	 * @param date
	 * @param format
	 * @return
	 */
	public static String dateFormat(Date date, String format) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}

	/**
	 * 获取hex字节数据
	 * 
	 * @param begin
	 * @param end
	 * @param b
	 * @return
	 */
	public static String byteToHexString(int begin, int end, byte[] b) {
		String baseInfoStr = "";
		for (int i = begin; i <= end; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			baseInfoStr += hex;
		}
		return baseInfoStr;
	}

	/**
	 * 转换卡hex字节数据到int
	 * 
	 * @param begin
	 * @param end
	 * @param b
	 * @return
	 */
	public static int hexToInt(int begin, int end, byte[] b) {
		return Integer.parseInt(byteToHexString(begin, end, b), 16);
	}

	public static void main(String[] args) {
		//消费机初始化29 74 e7 0c 3c 9e 11 e5 83 9f d4 be d9 80 4c 01 00 bc 61 4e 00 00 00 00 00 00 02 02 00 0A 19 19 00 00 00 00 97 b0
		byte[] b = StringUtil
				.strTobytes("29 74 e7 0c 3c 9e 11 e5 83 9f d4 be d9 80 4c 01 00 bc 61 4e 00 00 00 00 00 00 02 02 00 0d 01 01 00 00 00 00 00 07 00 6a f5 "
						.replaceAll(" ", ""));
		CRC16.generate(b);
		StringUtil.print(Integer.toHexString(b[b.length - 2]) + " ");
		StringUtil.println(Integer.toHexString(b[b.length - 1]));
	}

	public static void print(Object obj) {
		System.out.print(obj);
	}

	public static void println(Object obj) {
		System.out.println(obj);
	}
}