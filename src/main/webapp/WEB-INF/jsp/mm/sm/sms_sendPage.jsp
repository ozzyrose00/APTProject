<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function js_send(){
		frm.action="/mm/sm/sms_send";
		frm.submit();
	}
</script>
</head>
<body>
<form name="frm" method="post">
	<div>
		<span>수신번호</span>
		<span><input type="text" id="sms_receive_tel" name="sms_receive_tel" value=""></span>
	</div>
	<div>
		<span>발신번호</span>
		<span><input type="text" id="sms_send_tel" name="sms_send_tel" value=""></span>
	</div>
	<div>
		<span>발신내용</span>
		<span><textarea id="sms_content" name="sms_content" rows="5" height="10"></textarea></span>
	</div>
	<div>
		<span><input type="button" value="전송" onclick="js_send()"></span>
	</div>
</form>
</body>
</html>