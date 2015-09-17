package com.singbon.device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;


/**
 * jdbc直连操作数据库类
 * 
 * @author 郝威
 * 
 */
public class JdbcDao {

	private static Map<Integer, Connection> connList = new HashMap<Integer, Connection>();

	/**
	 * 执行sql语句
	 * 
	 * @param sn
	 *            序列号
	 * @param sql
	 * @return
	 * @throws Exception
	 */
	public static int save(String sn, String sql) throws Exception {
		if (!TerminalManager.SNToCompanyList.containsKey(sn)) {
			return -1;
		}
		int userId = TerminalManager.SNToCompanyList.get(sn);
		Connection conn = null; // 定义一个MYSQL链接对象
		if (connList.containsKey(userId)) {
			conn = connList.get(userId);
		} else {
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/db_data" + userId, "root", "root"); // 链接本地MYSQL
			connList.put(userId, conn);
		}
		int result = conn.prepareStatement(sql).executeUpdate();
		return result;
	}

	public static void main(String[] args) throws Exception {
		Connection conn = null; // 定义一个MYSQL链接对象

		Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/db_data1", "root", "root"); // 链接本地MYSQL
		for (int i = 0; i < 10000; i++) {
			conn.prepareStatement("insert into consume (money,uploadTime) values ('" + i + "',now())").executeUpdate();
		}
	}
}
