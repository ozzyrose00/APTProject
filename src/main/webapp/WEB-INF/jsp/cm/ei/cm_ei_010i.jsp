<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>
<%@ page import = "javax.servlet.http.HttpSession" %>  
<%@page import="java.util.*"%>

<%
	
	System.out.println("++++++++++++++jsp++++++++++++++++++++");
	String _isLogin = session.getAttribute("_isLogin")+"";
	String _s_usr_type = session.getAttribute("_s_usr_type")+"";
	
	Enumeration eu = session.getAttributeNames();
	String _s_key;
	String _s_val;
	while(eu.hasMoreElements()){
		_s_key = eu.nextElement()+"";
		_s_val = session.getAttribute(_s_key)+"";
		//System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	String apt_id = session.getAttribute("_s_apt_id")+"";
	System.out.println(apt_id);
	
	
	List com_A1_list = (ArrayList)request.getAttribute("com_A1_list");
	System.out.println("com_A1_list:::::"+com_A1_list.size());
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		$("input:text[id$=_dt]").datepicker({
			dataeFormat : "yy-mm-dd"
		})
	})
	
	function js_ins(){
		frm.action = "/cm/ei/010ins";
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="post">
<input type="hidden" id="apt_id" name="apt_id" value="<%=apt_id%>">
구분: 
<select id="event_type" name="event_type" >
	<option value="">선택</option>
	<c:forEach var="data" items="${com_A1_list}" varStatus="status">
	     <option value="<c:out value="${data.COM_CD}"/>">${status.count}.<c:out value="${data.COM_CD_NM}"/></option>
	</c:forEach>
</select>	
</br>
제목: <input type="text" id="event_nm" name="event_nm" value="" style="width:500px">
</br>
시작일 : <input type="text" id="event_start_dt" name="event_start_dt" value=""> 
</br>
종료일 : <input type="text" id="event_end_dt" name="event_end_dt" value="">
</br>
신청시작일: <input type="text" id="apply_start_dt" name="apply_start_dt" value="">
</br>
신청종료일: <input type="text" id="apply_end_dt" name="apply_end_dt" value="">
<div>
<input type="button" value="저장" onclick="js_ins();">
</div>
</form>
</body>
</html>