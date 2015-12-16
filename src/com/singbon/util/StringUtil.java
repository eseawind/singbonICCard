package com.singbon.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.singbon.device.CRC16;
import com.singbon.entity.Company;
import com.singbon.entity.WaterRateGroup;

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
	public static Integer byteToInt(byte b) {
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
	public static String leftPad(Integer str, Integer num) {
		String temp = Integer.toString(str);
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp = "0" + temp;
		}
		return temp;
	}

	/**
	 * 转换成16进制字符串再左补零
	 * 
	 * @return
	 */
	public static String hexLeftPad(int str, Integer num) {
		String temp = Integer.toHexString(str).replace("ffffff", "");
		num = num - temp.length();
		for (int i = 0; i < num; i++) {
			temp = "0" + temp;
		}
		return temp;
	}

	/**
	 * long转换成16进制字符串再左补零
	 * 
	 * @return
	 */
	public static String hexLeftPad(long str, Integer num) {
		String temp = Long.toHexString(str).replace("ffffff", "");
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
	public static String hexRightPad(Integer str, Integer num) {
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
	public static String strLeftPad(String str, Integer num) {
		num = num - str.length();
		for (int i = 0; i < num; i++) {
			str = "0" + str;
		}
		return str;
	}

	/**
	 * 字符串左补字符
	 * 
	 * @param str
	 *            原字符串
	 * @param num
	 *            总长度
	 * @param c
	 *            被补字符
	 * @return
	 */
	public static String strLeftPadWithChar(String str, Integer num, String c) {
		num = num - str.length();
		for (int i = 0; i < num; i++) {
			str = c + str;
		}
		return str;
	}

	/**
	 * 字符串右补零
	 * 
	 * @return
	 */
	public static String strRightPad(String str, Integer num) {
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

	public static String dateToHexStr(Calendar date) {
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
	 * 转换日期格式为16进制字符串 例：“2009-12-04” -> “9C04”
	 * 修改2009-07-06：二进制前7位表示年，下4位月，最后5位表示日如"2009-07-06" -> "12E6"
	 * 
	 * @param date
	 * @return
	 */

	public static String dateStrToHexStr(String dateStr) {
		Calendar date = Calendar.getInstance();
		String[] dateStrs = dateStr.split("-");
		date.set(StringUtil.objToInt(dateStrs[0]), StringUtil.objToInt(dateStrs[1]), StringUtil.objToInt(dateStrs[2]));
		date.add(Calendar.MONTH, -1);
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
	public static String dateFromHexStr(String hexStr) {
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
	public static String binaryHexStr(String binary) {
		String[] strs = binary.split(" ");
		String result = "";
		for (String s : strs) {
			String hex = Integer.toString(Integer.parseInt(s, 2), 16);
			result += hex;
		}
		if (result.length() == 1) {
			result = "0" + result;
		}
		return result;
	}

	/**
	 * 四字节时间戳
	 * 
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static String timeToHexStr() {
		String tempStr = "";
		Date date = new Date("2000/01/01");
		long time = (System.currentTimeMillis() - date.getTime()) / 1000;

		for (int i = 24; i >= 0; i -= 8) {
			String tmpStr1 = Integer.toHexString((byte) ((time >> i) & 0xff)).replace("ffffff", "");
			if (tmpStr1.length() == 1) {
				tempStr = tempStr + "0" + tmpStr1;
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
		return StringUtil.strRightPad(result, 32);
	}

	/**
	 * 获取BCD码int
	 * 
	 * @param str
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Integer byteToBCDInt(byte b) {
		return Integer.parseInt(toHexString(b));
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
	 * 从字节数组中获取指定位置的hex字符形式数据 byte[]b= {00, 11, 22, 33, 44}; byteToHexStr(1, 3,
	 * byte[] b) 结果11 22 33
	 * 
	 * @param begin
	 * @param end
	 * @param b
	 * @return
	 */
	public static String getHexStrFromBytes(Integer begin, Integer end, byte[] b) {
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
	public static Integer hexToInt(Integer begin, Integer end, byte[] b) {
		return Integer.parseInt(getHexStrFromBytes(begin, end, b), 16);
	}

	/**
	 * 转换卡hex字节数据到long
	 * 
	 * @param begin
	 * @param end
	 * @param b
	 * @return
	 */
	public static Long hexToLong(Integer begin, Integer end, byte[] b) {
		return Long.parseLong(getHexStrFromBytes(begin, end, b), 16);
	}

	/**
	 * 获取系统密码
	 * 
	 * @param company
	 * @return
	 */
	public static String getSysPwd(Company company) {
		int tmKey = 0;
		String tmStr = "";

		byte[] nameByte = null;
		try {
			nameByte = strTobytes(strToGB2312(company.getCompanyName()) + "0000");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		for (int i = 0; i < nameByte.length; i++) {
			int b = byteToInt(nameByte[i]);
			tmKey = tmKey + b;
			if (b >= 127) {
				if (i == nameByte.length - 1)
					tmKey = tmKey + b * 10;
				else
					tmKey = tmKey + Integer.valueOf(b + "" + byteToInt(nameByte[i + 1]));
			}
		}
		tmKey = tmKey + Integer.valueOf(company.getSerialNumber()) + company.getBaseSection() + Integer.valueOf(company.getAuthNumber());
		tmStr = String.valueOf(tmKey);
		tmStr = strLeftPadWithChar(tmStr, 12, "8");
		tmStr = new StringBuffer(tmStr).reverse().toString();

		return tmStr;
	}

	/**
	 * object类型int字符串转Integer
	 * 
	 * @return
	 */
	public static Integer objToInt(Object obj) {
		return Integer.valueOf(obj.toString());
	}

	/**
	 * object类型long字符串转Long
	 * 
	 * @return
	 */
	public static Long objToLong(Object obj) {
		return Long.valueOf(obj.toString());
	}

	/**
	 * object类型float字符串转Float
	 * 
	 * @return
	 */
	public static Float objToFloat(Object obj) {
		return Float.valueOf(obj.toString());
	}

	/**
	 * Object转String
	 * 
	 * @param obj
	 * @return
	 */
	public static String objToString(Object obj) {
		if (obj != null) {
			return obj.toString();
		} else {
			return "";
		}
	}

	/**
	 * 获取水控时间段hex
	 * 
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	public static String getWaterRateTime(String beginTime, String endTime) {
		String hex = "";
		String[] time = beginTime.split(":");
		hex += StringUtil.hexLeftPad(Integer.valueOf(time[0]), 2);
		hex += StringUtil.hexLeftPad(Integer.valueOf(time[1]), 2);

		time = endTime.split(":");
		hex += StringUtil.hexLeftPad(Integer.valueOf(time[0]), 2);
		hex += StringUtil.hexLeftPad(Integer.valueOf(time[1]), 2);
		return hex;
	}

	/**
	 * 返回扣费周期或水量
	 * 
	 * @param w
	 * @param cycle
	 * @param water
	 * @return
	 */
	public static String getWaterDeduceCycle(WaterRateGroup w, Integer cycle, Integer water) {
		if (w.getConsumeType() == 33) {
			return StringUtil.hexLeftPad(water, 4);
		} else {
			return StringUtil.hexLeftPad(cycle, 4);
		}
	}

	/**
	 * 水控授权16个卡类型转hex字符串2字节
	 * 
	 * @param str
	 * @return
	 */
	public static String getWaterCardTypesHexStr(String str) {
		String result = "";
		for (int i = 7; i >= 0; i--) {
			if (str.indexOf("," + i + ",") == -1) {
				result += "0";
			} else {
				result += "1";
			}
		}
		for (int i = 15; i >= 8; i--) {
			if (str.indexOf("," + i + ",") == -1) {
				result += "0";
			} else {
				result += "1";
			}
		}
		return StringUtil.strLeftPadWithChar(StringUtil.binaryHexStr(result), 4, "0");
	}

	/**
	 * 消费机授权16个卡类型转hex字符串2字节
	 * 
	 * @param str
	 * @return
	 */
	public static String getPosCardTypesHexStr(String str) {
		String result = "";
		for (int i = 15; i >= 8; i--) {
			if (str.indexOf("," + i + ",") == -1) {
				result += "0";
			} else {
				result += "1";
			}
		}
		for (int i = 7; i >= 0; i--) {
			if (str.indexOf("," + i + ",") == -1) {
				result += "0";
			} else {
				result += "1";
			}
		}
		return StringUtil.strLeftPadWithChar(StringUtil.binaryHexStr(result), 4, "0");
	}

	public static void main(String[] args) {
		byte[] b = StringUtil.strTobytes("00000000000000000000000000000059 00 00 00 59 00 00 00 00 00 00 02 02 00 0a 01 01 00 00 00 00 cd 33".replaceAll(" ", ""));
		// byte[] b = StringUtil.strTobytes("41 59 A9 6E 83 8E 4D F5 BD EC D4 E2
		// D8 E9 40 F1 00 BC 61 4E 00 00 00 00 00 00 02 02 00 1A 04 0A 00 00 00
		// 00 00000000000000000000000000002002 70 54".replaceAll(" ", ""));
		CRC16.generate(b);
		StringUtil.print(Integer.toHexString(b[b.length - 2]).replace("ffffff", "") + " ");
		StringUtil.println(Integer.toHexString(b[b.length - 1]).replace("ffffff", ""));
	}

	public static void print(Object obj) {
		System.out.print(obj);
	}

	public static void println(Object obj) {
		System.out.println(obj);
	}
}
