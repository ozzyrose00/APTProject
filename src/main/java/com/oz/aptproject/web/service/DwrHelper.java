package com.oz.aptproject.web.service;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.ibatis.sqlmap.client.SqlMapClient;


public class DwrHelper {
	
	/**
	 * SINGLE ROW SELECT 수행 후 결과 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.lang.Object
	 * @throws Exception
	 */
	
	private DwrHelper dwr;
	
	@Autowired
	public void setDwr(DwrHelper dwr) {
		this.dwr = dwr;
	}

	public Object getObject(Map<String, String> prms) throws Exception {
		System.out.println("dwr getObject 실행");
		if(prms!=null) {
			Iterator itrs = prms.keySet().iterator();
			while(itrs.hasNext()) {
				String key = itrs.next()+"";
				String value =prms.get(key)+"";
				//System.out.println("key:::"+key + "  value:::"+value);
			}
		}		
		
		Map rtnObj = (HashMap)IbatisHelper.select(prms);
		Map rtnMap = null;
		if(rtnObj!=null) {
			rtnMap = new HashMap();
			Iterator itrs = rtnObj.keySet().iterator();
			while(itrs.hasNext()) {
				String key = itrs.next()+"";
				String value =rtnObj.get(key)+"";
				rtnMap.put(key.toLowerCase(), value);
				System.out.println("key:::"+key.toLowerCase() + "  value:::"+value);
			}
		}
		return rtnMap;
		
	}

	/*
	 * 
	public Object getClobObject(Map<String, String> prms) throws Exception {
		System.out.println("dwr getObject Clob 실행");
		
		Map rtnObj = (HashMap)IbatisHelper.selectClob(prms);
		Map rtnMap = null;
		if(rtnObj!=null) {
			rtnMap = new HashMap();
			Iterator itrs = rtnObj.keySet().iterator();
			while(itrs.hasNext()) {
				String key = itrs.next()+"";
				String value =rtnObj.get(key)+"";
				rtnMap.put(key.toLowerCase(), value);
			}
		}
		return rtnMap;
		
	}
	 */
	
	/**
	 * MULTI ROW SELECT 수행 후 결과 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.util.List
	 * @throws Exception
	 */
	public List getList(Map<String,String> prms) throws Exception {
		return IbatisHelper.selectList(prms);
	}
	
	/**
	 * INSERT 수행 후 결과 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.util.List
	 * @throws Exception
	 */
	public Object insert(Map<String,String> prms) throws Exception {
		return IbatisHelper.insert(prms);
	}
	
	/**
	 * INSERT 수행 후 SELECT KEY 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.util.List
	 * @throws Exception
	 */
	public Object insertBySeq(Map<String,String> prms) throws Exception {
		return IbatisHelper.insert(prms);
	}
	
	/**
	 * UPDATE 수행 후 결과 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.util.List
	 * @throws Exception
	 */
	public Object update(Map<String,String> prms) throws Exception {
		return IbatisHelper.update(prms);
	}
	
	/**
	 * DELETE 수행 후 결과 값 반환
	 * 
	 * @param  java.util.Map prms
	 * @return java.util.List
	 * @throws Exception
	 */
	public Object delete(Map<String,String> prms) throws Exception {
		return IbatisHelper.delete(prms);
	}

	public Object remove(Map<String,String> prms) throws Exception {
		return IbatisHelper.delete(prms);
	}
	
	
	public Object delt(Map<String,String> prms) throws Exception {
		return IbatisHelper.delete(prms);
	}
	
	
	
	
	
	/**
	 * 한번에 여러개의 CRUD 작업을 수행해야 하는 경우 
	 * 
	 * @param  java.util.Map prms
	 * @return java.lang.Object
	 * @throws Exception
	 */
	public Map serialExecute(Map<String,String> prms) throws Exception {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		String[] crud = prms.get("crud").split("\\|");
		System.out.println("111");
		System.out.println(crud.length+""+crud[0]);
		
		System.out.println("222");
		String[] sqls = prms.get("sqls").split("\\|");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(sqls.length+""+sqls[0]);
		System.out.println("333");
		
		if(crud.length != sqls.length) {
			throw new RuntimeException("작업유형 갯수와 SQL문 아이디 갯수가 일치하지 않습니다.");
		}
		
		Map resultMap = new HashMap(crud.length);
		System.out.println("DDDDDDDDDDDDDDDDDDDDDD");
		for(int i = 0 ; i < crud.length ; i++) {
			System.out.println("sqls[i]:::"+sqls[i]);
			System.out.println("crud[i]:::"+crud[i]);
			prms.put("sql", sqls[i]);
			
			if("S".equals(crud[i])) {
				resultMap.put(sqls[i], IbatisHelper.select(prms));
			} else if("SL".equals(crud[i])) {
				resultMap.put(sqls[i], IbatisHelper.selectList(prms));
			} else if("SPL".equals(crud[i])) {
				resultMap.put(sqls[i], IbatisHelper.selectPagingList(prms));
			} else if("C".equals(crud[i])) {
				resultMap.put(sqls[i], IbatisHelper.insert(prms));
			} else if("U".equals(crud[i])) {
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
				resultMap.put(sqls[i], IbatisHelper.update(prms));
			} else if("D".equals(crud[i])) {
				resultMap.put(sqls[i], IbatisHelper.delete(prms));
			}
		}
		
		return resultMap;
	}
	
	
	/**
	 * 단순 CRUD 작업이 아니고 복잡한 비즈니스 로직을 처리해야 하는 경우
	 * 별도의 JAVA CLASS를 통해 처리 후 결과값을 리턴한다.
	 * 
	 * @param  java.util.Map prms
	 * @return java.lang.Object
	 * @throws Exception
	 */
	public Object invokeHandler(Map<String,String> prms) throws Exception {
		Class  cls    = Class.forName(prms.get("handler"));
		Object obj    = cls.newInstance();
		Method method = cls.getMethod("process", Map.class);
		return method.invoke(obj, prms);
	}
	
	 
}
