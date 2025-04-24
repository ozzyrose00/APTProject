<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.*"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%> 

<%
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
	String _isLogin = session.getAttribute("_isLogin")+"";
	String _s_usr_type = session.getAttribute("_s_usr_type")+"";
	String _s_apt_id = session.getAttribute("_s_apt_id")+"";
	_s_apt_id = "null".equals(_s_apt_id)?"": _s_apt_id;
	
	System.out.println("_isLogin::::"+_isLogin);
	System.out.println("_isLogin::::"+_isLogin);
	System.out.println("_isLogin::::"+_isLogin);
	
	
	if(!"Y".equals(_isLogin)){
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('로그인 해주세요')");
		writer.println("document.location.href='/index'");
		writer.println("</script>");
		//response.sendRedirect("/index");
	}
	
	System.out.println("_s_apt_id::::"+_s_apt_id);
			
			
	Enumeration eu = session.getAttributeNames();
	String _s_key;
	String _s_val;
	while(eu.hasMoreElements()){
		_s_key = eu.nextElement()+"";
		_s_val = session.getAttribute(_s_key)+"";
		//System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
	
	List comClaCdLst = (ArrayList)request.getAttribute("comClaCdLst");
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++comClaCdLst"+comClaCdLst.size());
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
		
		$("#resi_type").change(function(){
			if($(this).val()=="02"||$(this).val()=="03"){
				$("#own_info_area").css("display","");
			}else{
				$("#own_info_area").find(":text").val("");
				$("#own_info_area").css("display","none");
			}
		})
	})

	function js_move_ins(){
		frm.action = "/aa/ar/010ins";
		frm.submit();
	}
</script>
</head>
<body>
<form id="frm" name="frm" method="post">
<input type="hidden" id="apt_id" name="apt_id" value="<%=_s_apt_id %>">
<input type="hidden" id="cud_gbn" name="cud_gbn" value="C">
동:
<input type="text" id="dong" name="dong" value="">
</br>
호수:
<input type="text" id="ho" name="ho" value="">
</br>
이름:	
<input type="text" id="nm" name="nm" value="">
</br>
주거타입:	
<select id="resi_type" name="resi_type">
	<option value="">선택</option>
	<c:forEach var="data" items="${comClaCdLst}" varStatus="status">
		<option value="${data.COM_CD}">${data.COM_CD_NM}</option>
	</c:forEach>
</select>
</br>
전화번호
<input type="text" id="tel1" name="tel1" value=""> - 
<input type="text" id="tel2" name="tel2" value=""> - 
<input type="text" id="tel3" name="tel3" value="">
</br>
전입일:	
<input type="text" id="mvi_dt" name="mvi_dt" value="">
</br>
전출일:	
<input type="text" id="mvo_dt" name="mvo_dt" value="">

<div id="own_info_area" style="display:none">
	소유자이름:	
	<input type="text" id="own_nm" name="own_nm" value="">
	</br>
	소유자전화번호
	<input type="text" id="own_tel1" name="own_tel1" value=""> - 
	<input type="text" id="own_tel2" name="own_tel2" value=""> - 
	<input type="text" id="own_tel3" name="own_tel3" value="">	
</div>

<div>
<input type="button" onclick="js_move_ins()" value="등록">
</div>
</form>

</body>
</html>