<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%> 

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
	        colNames:["아파트아이디","아파트이름","우편번호","주소"],
	        colModel:[
	                  {name:"apt_id",     index:"apt_id", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_nm",     index:"apt_nm", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_zip_no", index:"apt_zip_no", align:"center", editable:true, edittype:"text"},
	                  {name:"apt_addr_dtl", index:"apt_addr_dtl", align:"center", editable:true, edittype:"text"},
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			ondblClickRow  :  function(rid, iRow, iCol){
				var _rd = $("#"+_opt.gid).getRowData(rid);
				opener.document.getElementById("apt_id").value = _rd.apt_id
				opener.document.getElementById("apt_nm").value = _rd.apt_nm 
				window.close();
			},			
			sqls :  {"lst" : "aa.aaAi010l"},
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
    
    function js_set_prm_field(){
    	var prm = new Object();
   		var type = "";
   		var name = "";
   		var value = "";
    	$(".gs").each(function(i){
    		type = $(this).attr("type")
    		name = $(this).attr("name")
    		if(type=="text"){
    			value = $(this).val();
    		}
    		prm[name] = value;
    	})    	
    	return prm;
    }
    
    function js_move_ins(){
    	var a1 =  setPostData(_opt)
    	var a2 =  js_set_prm_field()
    	var params = Object.assign({},a1,a2)
    	$("#aaai010l").jqGrid("setGridParam",{postData : params})
        $("#aaai010l").jqGrid("clearGridData",true).trigger("reloadGrid");    	
    }
</script>
</head>
<body>
<div  style="width:500px;text-align:right">
<input type="text" id="apt_nm" name="apt_nm" class="gs">
<input type="button" value="검색" onclick="js_move_ins()">
</div>
<table id="aaai010l">
<div id="pager"></div>
</table>
</body>
</html>