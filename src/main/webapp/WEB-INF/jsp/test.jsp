<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>
<script>
	window.onload=function(){
	}
	
	$(document).ready(function(){
		var param = new Object();
		param.sql = "test.noticedetail"
		param.id = "13"
		DwrHelper.getObject(param, {
			callback:function(data){
				//탐캣 경로 때문에 에러남. /Egov7 -> / 로 변경
				//alert(data.id)
			},async:false})		
	})
</script>
</head>
<body>
	<form action="/test/reg" method="post" enctype="multipart/form-data">
	<input type="text" name="file_dir_nm" id="file_dir_nm" value="mis3_file_dir">
	    <div class="margin-top first">
	        <h3 class="hidden">공지사항 입력</h3>
	        <table border="1px">
	            <tbody>
	                <tr>
	                    <th>제목</th>
	                    <td class="text-align-left text-indent text-strong text-orange" colspan="3">
	                        <input type="text" name="title" />
	                    </td>
	                </tr>
	                <tr>
	                    <th>카테고리</th>
	                    <td class="text-align-left text-indent text-strong text-orange" colspan="3">
	                        <select id="category" name="category">
	                        	<option value="1">카테고리1</option>
	                        	<option value="2">카테고리2</option>
	                        	<option value="3">카테고리3</option>
	                        	<option value="4">카테고리4</option>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <th>좋아하는 음식</th>
	                    <td class="text-align-left text-indent text-strong text-orange" colspan="3">
	                    	<input type="checkbox" id="ch1" name="ch" value="1">자장면
	                    	<input type="checkbox" id="ch2" name="ch" value="2">짬뽕
	                    	<input type="checkbox" id="ch3" name="ch" value="3">볶음밥
	                    	<input type="checkbox" id="ch4" name="ch" value="4">탕수육
	                    </td>
	                </tr>                                
	                <tr>
	                    <th>첨부파일</th>
	                    <td colspan="3" class="text-align-left text-indent">
	                    	<input type="file" name="_file" />
	                    </td>
	                </tr>
	                <tr class="content">
	                    <td colspan="4"><textarea class="content" name="content"></textarea></td>
	                </tr>
	                <tr>
	                    <td colspan="4" class="text-align-right"><input class="vertical-align" type="checkbox" id="open" name="open" value="true"><label for="open" class="margin-left">바로공개</label> </td>
	                </tr>
	            </tbody>
	        </table>
	    </div>
	    <div class="margin-top text-align-center">
	        <input class="btn-text btn-default" type="submit" value="등록" />
	        <a class="btn-text btn-cancel" href="/index">메인</a>
	    </div>	
	</form>	
</body>
</html>