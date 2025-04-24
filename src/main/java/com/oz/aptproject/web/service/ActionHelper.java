package com.oz.aptproject.web.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;


public class ActionHelper {
	
	public Map reqPrms;
	
	public void requestData(HttpServletRequest request) {
		reqPrms = new HashMap();
		Enumeration reqPrmNames  = request.getParameterNames();
		String      reqPrmName   = "";
		String[]    reqPrmValues = null;
		String queryForStr = "?_pg=y";
		System.out.println("///////////////////requestData/////////////////////////");
		System.out.println("///////////////////requestData/////////////////////////");
		System.out.println("///////////////////requestData/////////////////////////");
		
		System.out.println("requesturi::::::::::"+request.getRequestURI());
		System.out.println("requesturl::::::::::"+request.getRequestURI());
		
		while(reqPrmNames.hasMoreElements()) {
			reqPrmName  = ""+reqPrmNames.nextElement();
			reqPrmValues = request.getParameterValues(reqPrmName);
			
			for(int i = 0 ; i < reqPrmValues.length ; i++){
				System.out.println("reqPrmName::::::"+ reqPrmName + "::::reqPrmValues["+i+"]::::::"+reqPrmValues[i]);
				reqPrmValues[i] = removeTag(reqPrmValues[i]);
			}
			
			
			if(reqPrmValues != null && reqPrmValues.length == 1) {
				this.reqPrms.put(reqPrmName, reqPrmValues[0]);
				if(reqPrmName.indexOf("sql")==-1 && 
						reqPrmName.indexOf("seqno") == -1 && 
							reqPrmName.indexOf("thisPage") == -1) {

					queryForStr += "&"+reqPrmName + "=" + reqPrmValues[0];
				}
			} else {
				this.reqPrms.put(reqPrmName, reqPrmValues);
			}			
		}
		this.reqPrms.put("queryStr", queryForStr);
		System.out.println("====================================================");
		Iterator<String> itr = reqPrms.keySet().iterator();
		while(itr.hasNext()) {
			String k = itr.next()+"";
			String v = reqPrms.get(k)+"";
			System.out.println("key:::"+k+"   v:::"+v);
		}
		System.out.println("====================================================");
		
		HttpSession session = request.getSession();
		
		if(session != null) {
			Enumeration e = session.getAttributeNames();
			
			System.out.println("::::::::::::::::세션담기 reqPrms:::::::::::::::::::");
			while(e.hasMoreElements()) {
				String skey = e.nextElement()+"";
				String sval = session.getAttribute(skey)+"";
				System.out.println("key:::"+skey + "  val:::"+sval);
				reqPrms.put(skey, sval);
			}
		}
		
		System.out.println("///////////////////requestDat종료/////////////////////////");			
		System.out.println("///////////////////requestDat종료/////////////////////////");			
		System.out.println("///////////////////requestDat종료/////////////////////////");			
	}
	
	
	public static List keyChangeLower(List<Map> list) {
		List<Map> newList = new LinkedList<Map>();
		for (int i = 0; i < list.size(); i++) {
			HashMap<String, Integer> tm = new HashMap<String, Integer>(list.get(i));
			Iterator<String> iteratorKey = tm.keySet().iterator(); // 키값 오름차순
 		    Map  newMap = new HashMap();
			// //키값 내림차순 정렬
			while (iteratorKey.hasNext()) {
				String key = iteratorKey.next()+"";
				//System.out.println(key.toLowerCase() + ":::::" + tm.get(key));
				newMap.put(key.toLowerCase(), tm.get(key));
			}
			newList.add(newMap);
		}
		return newList;
	}	

	public static Map keyChangeLower(Map map) {
		Map newMap = new HashMap();
		Iterator itr = map.keySet().iterator();
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		while(itr.hasNext()) {
			String key = itr.next()+"";
			String value = map.get(key)+"";
			if("null".equals(value)) {
				//value = "";
			} 
			System.out.println(key.toLowerCase() +  "   " + value);
			newMap.put(key.toLowerCase(), value);
		}
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		
		return newMap;
	}
	
	/*
	 * 파일 업로드
	 */
	public void fileUpload(MultipartFile _file, Map reqPrms, HttpServletRequest request) throws Exception {

		String tf_originnm = _file.getOriginalFilename();
		String _fileExt = tf_originnm.substring(tf_originnm.lastIndexOf(".")+1, tf_originnm.length());
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		String tranfNm = sdf.format(date);
		String tf_storenm = tranfNm+"_"+tf_originnm.substring(0,tf_originnm.lastIndexOf("."));
		tf_storenm += "."+_fileExt;
		
		System.out.println("tf_storenm:::"+tf_storenm);
		/*
		 * 같은 폴더에서 같은 폴더로 이동하는 로직
		 */
		String realPath = AppProperty.getProperty("mis3_file_dir");
		String webPath = "/WEB-INF/resources/upload";
		//String realPath = request.getServletContext().getRealPath(webPath);
		System.out.println("realPath:::"+realPath);
		File savePath = new File(realPath);
		if(!savePath.exists()) {
			savePath.mkdirs();
		}
		realPath += File.separator + tf_originnm;
		System.out.println("realPath 파일 포함:::"+realPath);
		String file_dir_nm = reqPrms.get("file_dir_nm")+"";
		String new_realPath = AppProperty.getProperty(file_dir_nm);
		File new_savePath = new File(new_realPath);
		System.out.println("이동할 realPath::::"+new_realPath);
		if(!new_savePath.exists()) {
			new_savePath.mkdirs();
		}		
		new_realPath += File.separator + tf_storenm;
		
		System.out.println("이동할 realPath 파일 포함:::"+realPath);
		
		//File saveFile = new File(realPath);
		File new_saveFile = new File(new_realPath);
		_file.transferTo(new_saveFile);
		
		reqPrms.put("att_file_nm", tf_originnm);
		reqPrms.put("mng_file_nm", tf_storenm);
		System.out.println("file:::::::::::::::::::::reqPrms:::::::::"+reqPrms.toString());
		//IbatisHelper.insert(reqPrms);
	}	
	
	
	

	
	public void fileDelete(Map reqPrms) throws IOException {
		String tf_storenm = reqPrms.get("tf_storenm")+"";
		String file_dir_nm = reqPrms.get("file_dir_nm")+"";
		String realPath = AppProperty.getProperty("file_dir_nm");
		realPath += File.separator + tf_storenm;
		System.out.println("realPath::::"+realPath);
		File f = new File(realPath);
		if(f.exists()) {
			f.delete();
		}
	}	
	
	public String removeTag(String str){
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("\\\"", "&quot;");
		str = str.replaceAll("'", "&#x27;");
		return str;
	}	
	
	/**
	 * 공통 코드 조회
	 * @throws Exception 
	 */
	public List comClaCdLst(Map prms) throws Exception {
		List list = null;
		IbatisHelper ibatisHelper = new IbatisHelper();
		list = ibatisHelper.selectList(prms);
		return list;
	}
	
	public void mapKeyValueStr(Map map) {
		Iterator itr = map.keySet().iterator();
		String key="";
		String val="";
		while(itr.hasNext()) {
			key = itr.next()+"";
			val = map.get(key)+"";
			System.out.println("key:::::"+key  + "  val:::"+val);
		}
	}

}
