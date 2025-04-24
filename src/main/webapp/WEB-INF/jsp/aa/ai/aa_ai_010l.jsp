<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%> 

<%
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
	String _isLogin = session.getAttribute("_isLogin")+"";
	String _s_usr_type = session.getAttribute("_s_usr_type")+"";
	
	Enumeration eu = session.getAttributeNames();
	String _s_key;
	String _s_val;
	while(eu.hasMoreElements()){
		_s_key = eu.nextElement()+"";
		_s_val = session.getAttribute(_s_key)+"";
		System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
%>

   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var _opt = {
			url:"/grid_list.do", //ajax 요청주소
	        datatype:"json", //결과물 받을 데이터 타입
	        caption:"아파트목록",
	        mtype : "POST",
	        height:"auto",
	        rowNum:10,
	        gid : "aaai010l",
	        colNames:["아파트아이디","아파트이름","우편번호","주소","생성자","생성일"],
	        colModel:[
	                  {name:"apt_id",     index:"apt_id", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_nm",     index:"apt_nm", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_zip_no", index:"apt_zip_no", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_addr_dtl", index:"apt_addr_dtl", align:"center", editable:true, edittype:"text"},
	                  {name:"cre_id",      index:"cre_id", align:"center", editable:true, edittype:"text"},
	                  {name:"cre_dt",      index:"cre_dt", align:"center", editable:true, edittype:"text"}
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "aa.aaAi010l"},
			onSelectRow : function(rid) {
				var _rd = $("#"+_opt.gid).getRowData(rid);
				var dia_apt_id = _rd.apt_id
				var dia_apt_nm = _rd.apt_nm
				var dia_apt_zip_no = _rd.apt_zip_no
				var dia_apt_addr_dtl = _rd.apt_addr_dtl
				
				$("#dia_apt_id").val(dia_apt_id);
				$("#dia_apt_nm").val(dia_apt_nm);
				$("#dia_apt_zip_no").val(dia_apt_zip_no);
				$("#dia_apt_addr_dtl").val(dia_apt_addr_dtl);
				
				$("#aaai010ldia").dialog({
				      title: '다이얼로그 제목을 넣자',
				      modal: true,
				      width: '600',
				      height: '400'
				});				
				
				//frm.action = "/aa/ai/010r"
				//frm.submit();
			},
	        pager: '#pager',
	        viewrecords:true		
	}
	
    $(document).ready(function(){
    	_opt.postData = setPostData(_opt); 
        $("#aaai010l").jqGrid(_opt);
    });	
	
    function setPostData(opt){
    	var _post_data = new Object();
    	_post_data.sql = opt.sqls.lst;
    	_post_data.title = opt.sqls.title;
    	return _post_data;
    }	
    
    function js_move_ins(){
    	location.href = "/aa/ai/010i"
    }
</script>
</head>
<body>
<div  style="width:920px;text-align:right">
<input type="button" value="등록" onclick="js_move_ins()">
</div>
<div id="aaai010ldia" style="display:none">
	<input type="hidden" id="dia_apt_id" name="dia_apt_id">
	아파트 이름: <input type="text" id="dia_apt_nm" name="dia_apt_nm"></br> 
	<input type="text" id="dia_apt_zip_no" name="dia_apt_zip_no" placeholder="우편번호">
	<input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="dia_apt_addr_dtl" name="dia_apt_addr_dtl" style="width:400px" placeholder="주소"><br>
	<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
	<div>
		<input type="button" onclick="js_save()" value="저장">
		<input type="button" onclick="js_delete()" value="삭제">
	</div>
</div>
<table id="aaai010l">
<div id="pager"></div>
</table>
</body>
</html>