package com.oz.aptproject.web.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.psl.orm.ibatis.SqlMapClientTemplate;

@Service
public class IbatisHelper {

	
	private static SqlMapClientTemplate sqlMapClientTemplate;

	@Autowired
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	
	/**
	 * SINGLE ROW SELECT SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Object select(Map<String, String> prms) throws Exception {
		return sqlMapClientTemplate.queryForObject(prms.get("sql"), prms);
	}
	
	/**
	 * MULTI ROW SELECT SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static List selectList(Map<String, String> prms) throws Exception {
		return sqlMapClientTemplate.queryForList(prms.get("sql"), prms);
	}
	
	/**
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Map selectMultiList(Map<String, String> prms) {
		Map returnMap = new HashMap();
		Map paramMap = prms;
		String[] arrSql = ( prms.get("sql")+"" ).split("\\|");
		
		List list = null;
		
		Map sqlMap = new HashMap(); 
		
		for ( int i = 0; i < arrSql.length; i++ ) {
			paramMap.put("sql", arrSql[ i ] );
			try {
				list = IbatisHelper.selectList( paramMap );
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			sqlMap.put( arrSql[ i ], list );
		}
		
		returnMap.put( "info_multi" , sqlMap );
		
		return returnMap;
	}
	
	
	/**
	 * MULTI ROW SELECT SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Map selectPagingList(Map<String, String> prms) throws Exception {
		Map pagingMap = new HashMap(2);
		
		pagingMap.put("totalCount", sqlMapClientTemplate.queryForObject(prms.get("sql")+"_tc", prms));
		pagingMap.put("selectList", sqlMapClientTemplate.queryForList(prms.get("sql"), prms));
		return pagingMap;
	}
	
	
	/**
	 * INSERT SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Object insert(Map<String, String> prms) throws Exception {
		return sqlMapClientTemplate.insert(prms.get("sql"), prms);
	}
	
	/**
	 * UPDATE SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Object update(Map<String, String> prms) throws Exception {
		System.out.println(prms.toString());
		return sqlMapClientTemplate.update(prms.get("sql"), prms);
	}
	
	/**
	 * DELETE SQL 
	 * @param prms
	 * @return
	 * @throws Exception
	 */
	public static Object delete(Map<String, String> prms) throws Exception {
		return sqlMapClientTemplate.delete(prms.get("sql"), prms);
	}	
	
	

}
