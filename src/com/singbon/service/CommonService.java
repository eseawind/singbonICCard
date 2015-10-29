package com.singbon.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.singbon.dao.BaseDAO;
import com.singbon.entity.Pagination;

/**
 * 公共通用业务层
 * 
 * @author 郝威
 * 
 */
@Service
public class CommonService extends BaseService {

	@Autowired
	public BaseDAO baseDAO;

	@Override
	public BaseDAO getBaseDAO() {
		return baseDAO;
	}

	@SuppressWarnings("rawtypes")
	public List<Map> selectBySql(String sql) {
		return this.getBaseDAO().selectBySql(sql);
	}

	@SuppressWarnings("rawtypes")
	public List<Map> selectByPage(String[] columns, String fromSql, String whereSql, Pagination pagination) {
		String selectCountSql = "";
		String selectSql = "";
		int i = 0;
		for (String col : columns) {
			selectSql += col + ",";
			int dotIndex = col.indexOf(".");
			if (dotIndex != -1) {
				col = col.substring(dotIndex + 1);
			}
			if (i == 0) {
				selectCountSql += "count(*) " + col + ",";
			}else{
				selectCountSql += "null " + col + ",";				
			}
			i++;
		}
		selectCountSql = selectCountSql.substring(0, selectCountSql.length() - 1);
		selectSql = selectSql.substring(0, selectSql.length() - 1);
		String fullSql = String.format("select %s from %s where %s union (select %s from %s where %s limit %s,%s)", selectCountSql, fromSql, whereSql, selectSql, fromSql, whereSql,
				pagination.getOffset(), pagination.getNumPerPage());
		return this.getBaseDAO().selectBySql(fullSql);
	}

}
