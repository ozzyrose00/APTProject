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
	
	
	List cmei010lList = (ArrayList)request.getAttribute("cmei010lList");
	System.out.println("cmei010lList:::::"+cmei010lList.size());
	
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
		var event_id = $("#eventlst option:selected").val();
		$("#event_id").val(event_id);
		frm.action = "/cm/ai/010ins";
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="post">
<input type="hidden" id="apt_id" name="apt_id" value="<%=apt_id%>">
<input type="hidden" id="event_id" name="event_id" value="<%=apt_id%>">
<input type="hidden" id="win_yn" name="win_yn" value="N">
행사명:
<select id="eventlst" name="eventlst">
	<option value="">선택</option>
	<c:forEach var="data" items="${cmei010lList}" varStatus="status">
		<option value='<c:out value="${data.EVENT_ID}"/>'><c:out value="${data.EVENT_NM}"/></option>
	</c:forEach>
</select>
</br>
동:
<input type="text" id="dong" name="dong" value="">
</br>
호수:
<input type="text" id="ho" name="ho" value="">
</br>
이름:	
<input type="text" id="nm" name="nm" value="">
</br>
전화번호
<input type="text" id="tel1" name="tel1" value=""> - 
<input type="text" id="tel2" name="tel2" value=""> - 
<input type="text" id="tel3" name="tel3" value="">
</br>
신청인원
<input type="text" id="apply_cnt" name="apply_cnt" value="">명
<div>
<input type="button" value="저장" onclick="js_ins();">
</div>
</form>
</body>
</html>