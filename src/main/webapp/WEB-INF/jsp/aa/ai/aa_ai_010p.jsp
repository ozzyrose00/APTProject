<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		alert("1")
	})
	
	function js_pop_addr(){
		$("#ifr").attr("src","")
	}
	
</script>
</head>
<body>
<form name="frm" method="post">
	아파트 이름: <input type="text" id="apt_nm" name="apt_nm"></br> 
	우편번호: <input type="text" id="apt_zip_no" name="apt_zip_no">
	<input type="button" value="우편번호" onclick="js_pop_addr()"></br> 
	주소1: <input type="text" id="apt_addr1" name="apt_addr1"></br> 
	주소2: <input type="text" id="apt_addr2" name="apt_addr2"></br> 
</form>
<iframe id="ifr" src="" frameborder="0" width="600" height="300" marginwidth="0" marginheight="0" scrolling="yes">
</body>
</html>