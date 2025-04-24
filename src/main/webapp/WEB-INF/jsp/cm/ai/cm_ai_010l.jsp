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
		System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
	
	List cmei010lList = (ArrayList)request.getAttribute("cmei010lList");
	System.out.println("cmei010lList size:::"+ cmei010lList.size());
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
	        gid : "cmai010l",
	        width : "100%",
	        colNames:["아파트아이디","행사아이디","신청자아이디","동","호수","이름",
	        	      "전화번호","전화번호1","전화번호2","전화번호3","신청인원","당첨여부","신청일"],
	        colModel:[
	                  {name:"apt_id",           index:"apt_id",         width:40,      align:"center", editable:true, edittype:"text"},
	                  {name:"event_id",         index:"event_id",       width:40,     align:"center", editable:true, edittype:"text"},
	                  {name:"apply_id",         index:"apply_id",       width:40,     align:"center", editable:true, edittype:"text"},
	                  {name:"dong",         	index:"dong",      		width:150,  align:"center", editable:true, edittype:"text"},
	                  {name:"ho",       		index:"ho",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"nm",       		index:"nm",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"tel",  			index:"tel",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"tel1",  			index:"tel1",  			width:100, align:"center", editable:true, edittype:"text",	 hidden:true},
	                  {name:"tel2",  			index:"tel2",  			width:100, align:"center", editable:true, edittype:"text",	 hidden:true},
	                  {name:"tel3",  			index:"tel3",  			width:100, align:"center", editable:true, edittype:"text", 	 hidden:true},
	                  {name:"apply_cnt",   		index:"apply_cnt", 		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"win_yn",   		index:"win_yn",   		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"cre_dt",		    index:"cre_dt", 		width:120, align:"center", editable:true, edittype:"text"}
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "cm.cmai010l"},
			onSelectRow : function(rid) {
				var _rd = $("#"+_opt.gid).getRowData(rid);
				var dia_apt_id = _rd.apt_id
				var dia_event_id = _rd.event_id
				var dia_apply_id = _rd.apply_id
				var dia_dong = _rd.dong
				var dia_ho = _rd.ho
				var dia_nm = _rd.nm
				var dia_tel1 = _rd.tel1
				var dia_tel2 = _rd.tel2
				var dia_tel3 = _rd.tel3
				var dia_apply_cnt = _rd.apply_cnt
				var dia_win_yn = _rd.win_yn
				
				$("#dia_apt_id").val(dia_apt_id);
				$("#dia_event_id").val(dia_event_id);
				$("#dia_apply_id").val(dia_apply_id);
				$("#dia_dong").val(dia_dong);
				$("#dia_ho").val(dia_ho);
				$("#dia_nm").val(dia_nm);
				$("#dia_tel1").val(dia_tel1);
				$("#dia_tel2").val(dia_tel2);
				$("#dia_tel3").val(dia_tel3);
				$("#dia_apply_cnt").val(dia_apply_cnt);
				$("#dia_win_yn").val(dia_win_yn);
				
				$("#cmai010ldia").dialog({
				      title: '다이얼로그 제목을 넣자',
				      modal: true,
				      width: '600',
				      height: '400'
				});				
				
				//frm.action = "/aa/ai/010r"
				//frm.submit();
	 		},
	        pager: '#pager',
	        multiselect : true,
	        viewrecords:true		
	}
	
	$(document).ready(function(){
		
		$("input:text[id$=_dt]").datepicker({
			dataeFormat : "yy-mm-dd"
		})    	
		
		_opt.postData = setPostData(_opt); 
	    $("#cmai010l").jqGrid(_opt);
	});	
	
	function setPostData(opt){
		var _post_data = new Object();
		_post_data.sql = opt.sqls.lst;
		_post_data.title = opt.sqls.title;
		_post_data.apt_id = $("#apt_id").val();
		return _post_data;
	}	
	
	function js_search(){
		
		var paramObj = new Object();
		paramObj.apt_id = $("#apt_id").val();
		paramObj.event_id = $("#event_id option:selected").val()	
		
        $("#cmai010l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");		
	}
	
    function js_update(){
    	
    	if(!confirm("정말로 수정하시겠습니까?")){
    		return;
    	}
    	
    	var param = new Object();
    	
    	param.sql = "cm.cmai010u"
    	param.apt_id 	 =	$("#dia_apt_id").val();
    	param.event_id =	$("#dia_event_id").val();
    	param.apply_id =	$("#dia_apply_id").val();
    	param.dong     =	$("#dia_dong").val();
    	param.ho       =	$("#dia_ho").val();
    	param.nm 		 =	$("#dia_nm").val();
    	param.tel1 	 =	$("#dia_tel1").val();
    	param.tel2 	 =	$("#dia_tel2").val();
    	param.tel3 	 =	$("#dia_tel3").val();
    	param.apply_cnt = $("#dia_apply_cnt").val();
    	param.win_yn    = $("#dia_win_yn").val();    	
    	DwrHelper.update(param,{callback:function(data){
    		alert("수정이 완료되었습니다.")
    		$("#cmai010ldia").dialog("close")
    		$("#cmai010l").trigger("reloadGrid");
    	},async:false})
    }
    
    function js_delete(){
    	var param = new Object();
    	param.sql = "cm.cmai010u"
    	param.apt_id 	 =	$("#dia_apt_id").val();
    	param.event_id =	$("#dia_event_id").val();
    	param.apply_id =	$("#dia_apply_id").val(); 
    	DwrHelper.remove(param,{callback:function(data){
    		alert("수정이 완료되었습니다.")
    		$("#cmai010ldia").dialog("close")
    		$("#cmai010l").trigger("reloadGrid");
    	},async:false})    	
    }
    
    function js_move_ins(){
		$($("#"+_opt.gid+" input:checkbox:checked")).each(function(){
			var id = $(this).attr("id");
			var idx = id.replace("jqg_"+_opt.gid+"_","");
		})    	
    	location.href = "/cm/ai/010i"    	
    }
	
	
	
	
</script>
</head>
<body>
<input type="hidden" id="apt_id" name="apt_id" value="<%=_s_apt_id %>">
<div  style="width:920px;text-align:right">

<select id="event_id" name="event_id">
	<option value="">선택</option>
	<c:forEach var="data" items="${cmei010lList}" varStatus="status">
		<option value="${data.EVENT_ID }">${data.EVENT_NM }</option>
	</c:forEach>
</select>

<input type="button" value="검색" onclick="js_search()">
<input type="button" value="등록" onclick="js_move_ins()">
</div>

<div id="cmai010ldia" style="display:none">
	
	<input type="hidden" id="dia_apt_id" name="dia_apt_id" value="">
	<input type="hidden" id="dia_event_id" name="dia_event_id" value="">
	<input type="hidden" id="dia_apply_id" name="dia_apply_id" value="">

	동:
	<input type="text" id="dia_dong" name="dia_dong" value="">
	</br>
	호수:
	<input type="text" id="dia_ho" name="dia_ho" value="">
	</br>
	이름:	
	<input type="text" id="dia_nm" name="dia_nm" value="">
	</br>
	전화번호
	<input type="text" id="dia_tel1" name="dia_tel1" value=""> - 
	<input type="text" id="dia_tel2" name="dia_tel2" value=""> - 
	<input type="text" id="dia_tel3" name="dia_tel3" value="">
	</br>
	신청인원
	<input type="text" id="dia_apply_cnt" name="dia_apply_cnt" value="">명
	</br>
	당첨여부
	<select id="dia_win_yn" name="win_yn">
		<option value="">선택</option>
		<option value="N">N</option>
		<option value="Y">Y</option>
	</select>

	<div>
		<input type="button" onclick="js_update()" value="수정">
		<input type="button" onclick="js_delete()" value="삭제">
	</div>
</div>


<table id="cmai010l">
<div id="pager"></div>
</table>	
</body>
</html>