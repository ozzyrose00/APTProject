package com.oz.aptproject.web.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.antlr.grammar.v3.ANTLRParser.action_return;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.DwrHelper;
import com.oz.aptproject.web.service.IbatisHelper;

import egovframework.rte.psl.orm.ibatis.SqlMapClientFactoryBean;

@Controller
public class MainController extends ActionHelper {
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@Autowired
	private DwrHelper dwrHelper;	
	
	@RequestMapping("/index")
	public String index()  throws Exception {
		Map prms = new HashMap();
		prms.put("sql", "test.noticelist");
		prms.put("page", 1);
		prms.put("field", "title");
		prms.put("query", "asd");
		//List list = (ArrayList)ibatisHelper.selectList(prms);
		//list = dwrHelper.getList(prms);
		return "index";
	}
	
	@RequestMapping("/test")
	public String test() {
		System.out.println("test");
		System.out.println("test");
		System.out.println("test");
		System.out.println("test");
		System.out.println("test");
		return "test";  
	}
	
	@RequestMapping("/MISLoginAuth")
	public String misLoginAuth(HttpSession session,HttpServletRequest request) {
		System.out.println("MISLoginAuth");
		requestData(request);

		String usr_id = reqPrms.get("usr_id")+"";
		String usr_pw = reqPrms.get("usr_pw")+"";
		
		reqPrms.put("sql", "test.loginInfo");
		Map loginMap;
		try {
			loginMap = (HashMap)ibatisHelper.select(reqPrms);
			if(loginMap!=null) {
				if ( session.getAttribute("_isLogin") != null ){
		            // 기존에 login이란 세션 값이 존재한다면
		            session.removeAttribute("_isLogin"); // 기존값을 제거해 준다.
		        }					
				loginMap = keyChangeLower(loginMap);
				System.out.println(loginMap.toString());
				setSessionData(loginMap, session, request.getRemoteHost());
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//redirect 안하면 웹 주소창에 이전 주소 표시
		return "redirect:index";
	}
	
	@RequestMapping("MISLogOutAuth")
	public String misLogOutAuth(HttpSession session,HttpServletRequest request) {
		requestData(request);
		session.invalidate();
		return "redirect:index";
	}
	
	@RequestMapping("/grid_update")
	@ResponseBody
	public String gridUpdate(@RequestParam Map<String,String> prms) throws Exception{
		Iterator itr = prms.keySet().iterator();
		String key="";
		String val="";
		while(itr.hasNext()) {
			key = itr.next()+"";
			val = prms.get(key)+"";
			System.out.println("key::::"+key+"  val::::"+val);
		}
		ibatisHelper.update(prms);
		return "success";
	}
		
	
	
	@RequestMapping("grid_list.do")
	@ResponseBody
	public Map gridList(
			@RequestParam Map<String,String> prms
			) throws JsonMappingException, JsonProcessingException {
		//requestData(request);
		//System.out.println(param.toString());
		/*
		 * jqgrid 파라미터 설정
		 * 1) @RequestParam을 통해 map으로 받는다
		 * 2) @RequestParam을 통해 map을 받고 이 안에 json형태의 데이터가 있을수 있기때문에
		 *     iterator를 이용해  풀어헤쳐 gridSearchMap 다시 담는다 
		 * 3) 이때 JSON은  ObjectMapper를 이용해  map으로 변환하여 gridSearchMap 에 담는다.
		 *     
		 */
		String key = "";
		String val = "";
		Iterator itrs = prms.keySet().iterator();
		ObjectMapper mapper = new ObjectMapper();
		Map gridSearchMap = new HashMap();
		while(itrs.hasNext()) {
			key = itrs.next()+"";
			val = prms.get(key)+"";
			if("param".equals(key)) {
				Map<String, String> param = mapper.readValue(val, Map.class);
				if(param!=null) {
					Iterator paramItr = param.keySet().iterator();
					String paramKey = "";
					String paramVal = "";
					while(paramItr.hasNext()) {
						paramKey = paramItr.next()+"";
						paramVal = param.get(paramKey);
						System.out.println("paramKey:::"+paramKey+":::paramVal:::"+paramVal);
						gridSearchMap.put(paramKey,paramVal);
					}
				}
			}else {
				System.out.println("key:::"+key+":::val:::"+val);
				gridSearchMap.put(key,val);
				
			}
			
		}
		List gridList = new ArrayList();
		/*
		Map map = new HashMap();
		map.put("seq_no","1");
		map.put("title","bbb");
		map.put("name","bbb");
		map.put("make_ymd","2022-02-02");
		map.put("srch_cnt","5");
		gridList.add(map);
		*/
		int tcnt = 0;
		try {
			gridList = (ArrayList)ibatisHelper.selectList(gridSearchMap);
			String sql = gridSearchMap.get("sql")+"_tcnt";
			gridSearchMap.put("sql", sql);
			tcnt = Integer.parseInt(ibatisHelper.select(gridSearchMap)+"");
		} catch (Exception e) { 
			
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		int page = Integer.parseInt(gridSearchMap.get("page")+"");
		
		System.out.println("tcnt:::"+tcnt);
		System.out.println("Math.ceil(tcnt/10):::"+Math.ceil((double)tcnt/10));
		int total = (int)Math.ceil((double)tcnt/10);
		Map gridMap = new HashMap();
		gridMap.put("page", page+"");
		gridMap.put("total", total+"");
		gridMap.put("records", tcnt+"");
		gridMap.put("gridList", keyChangeLower(gridList));
		
		//System.out.println(gridMap.toString());
		return gridMap;
	}
	
	
	
	
	protected void setSessionData(Map data, HttpSession session, String ip) {
		
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData!!!!!!!!!");
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData!!!!!!!!!");
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData!!!!!!!!!");
		session.setAttribute("_isLogin","Y");
		session.setAttribute("_ip_addr", ip);
		
		Calendar calendar = Calendar.getInstance(); 
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss"); 
		session.setAttribute("_s_login_time", sdf.format( calendar.getTime() ) );
		
		sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		session.setAttribute("_s_full_login_time", sdf.format( calendar.getTime() ) );
		
		Set         keySet  = data.keySet();
		Iterator    itr     = keySet.iterator();
		String      key     = "";
		String      value   = "";
		while(itr.hasNext()) {
			key   = ""+itr.next();
			value = ""+data.get(key);
			System.out.println("_s_"+key+"::::::::::"+value);
			session.setAttribute("_s_"+key, value);
		}
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData종료!!!!!!!!!");
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData종료!!!!!!!!!");
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!setSessionData종료!!!!!!!!!");
		/** 복호화를 위해 KEY를 세션에 저장 */
		//session.setAttribute("_s_db_encrypt_KEY", AppProperty.getProp("db_encrypt_KEY") );
	}	
}
