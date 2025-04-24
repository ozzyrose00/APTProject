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
		//System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
	
	List comClaCdLst = (ArrayList)request.getAttribute("comClaCdLst");
%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	var _opt1_grd_id;
	
	var _opt1 = {
			url:"/grid_list.do", //ajax 요청주소
	        datatype:"json", //결과물 받을 데이터 타입
	        caption:"아파트목록",
	        mtype : "POST",
	        height:"auto",
	        rowNum:10,
	        gid : "aaar010_1l",
	        width : "100%",
	        colNames:["아파트아이디","동","호수","이름","주거타입코드", "주거타입",
	        	      "전화번호","전화번호1","전화번호2","전화번호3","전입일","전출일",
	        	      "소유자명","소유자전화번호1","소유자전화번호2","소유자전화번호3"],
	        colModel:[
	                  {name:"apt_id",           index:"apt_id",         width:40,      align:"center", editable:true, edittype:"text"},
	                  {name:"dong",         	index:"dong",      		width:150,  align:"center", editable:true, edittype:"text"},
	                  {name:"ho",       		index:"ho",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"nm",       		index:"nm",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"resi_type",       	index:"resi_type", 		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"resi_type_nm",     index:"resi_type_nm",	width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"tel",  			index:"tel",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"tel1",  			index:"tel1",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"tel2",  			index:"tel2",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"tel3",  			index:"tel3",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"mvi_dt",   		index:"mvi_dt", 		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"mvo_dt",   		index:"mvo_dt",   		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"own_nm",      		index:"own_nm",     		width:40, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"own_tel1",    		index:"own_tel1",     		width:40, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"own_tel2",   		index:"own_tel2",     		width:40, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"own_tel3",   		index:"own_tel3",     		width:40, align:"center", editable:true, edittype:"text", hidden:true},
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "aa.aaar010_1l"},
			onSelectRow : _onSelectRow,
	 		ondblClickRow : _ondblClickRow1,
	        pager: '#pager1',
	        multiselect : true,
	        viewrecords:true		
	}
	
	function _onSelectRow(rid){
		var _rd = $("#"+_opt1.gid).getRowData(rid);
		var dong = _rd.dong;
		var ho = _rd.ho

		var paramObj = new Object();
		paramObj.sql = _opt2.sqls.lst;
		paramObj.title = _opt2.sqls.title;
		paramObj.apt_id = $("#apt_id").val();	
		paramObj.dong = dong;
		paramObj.ho = ho
		
        $("#aaar010_2l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");	
		
		_opt1_grd_id = rid;
	}
	
	function _ondblClickRow1(rid) {
		var _rd = $("#"+_opt1.gid).getRowData(rid);
		var dia_apt_id = _rd.apt_id
		var dia_dong = _rd.dong
		var dia_ho = _rd.ho
		var dia_resi_type = _rd.resi_type
		var dia_nm = _rd.nm
		var dia_tel1 = _rd.tel1
		var dia_tel2 = _rd.tel2
		var dia_tel3 = _rd.tel3
		var dia_mvi_dt = _rd.mvi_dt
		var dia_mvo_dt = _rd.mvo_dt

		var dia_own_nm = _rd.own_nm
		var dia_own_tel1 = _rd.own_tel1
		var dia_own_tel2 = _rd.own_tel2
		var dia_own_tel3 = _rd.own_tel3
		
		$("#dia_apt_id").val(dia_apt_id);
		$("#dia_dong").val(dia_dong);
		$("#dia_ho").val(dia_ho);
		$("#dia_nm").val(dia_nm);
		$("#dia_resi_type").val(dia_resi_type);
		$("#dia_tel1").val(dia_tel1);
		$("#dia_tel2").val(dia_tel2);
		$("#dia_tel3").val(dia_tel3);
		$("#dia_mvi_dt").val(dia_mvi_dt);
		$("#dia_mvo_dt").val(dia_mvo_dt);
		
		
		$("#dia_own_nm").val(dia_own_nm);
		$("#dia_own_tel1").val(dia_own_tel1);
		$("#dia_own_tel2").val(dia_own_tel2);
		$("#dia_own_tel3").val(dia_own_tel3);
		
		$("#aaar010_1ldia").dialog({
		      title: '다이얼로그 제목을 넣자',
		      modal: true,
		      width: '600',
		      height: '400'
		});		
		
		
		if(dia_resi_type=="02"||dia_resi_type=="03"){
				$("#dia_own_info_area").css("display","");
		}		
	}
	
	var _opt2 = {
			url:"/grid_list.do", //ajax 요청주소
	        datatype:"json", //결과물 받을 데이터 타입
	        caption:"아파트목록",
	        mtype : "POST",
	        height:"auto",
	        rowNum:10,
	        gid : "aaar010_2l",
	        width : "100%",
	        colNames:["아파트아이디","동","호수","순차","이름","주거타입코드", "주거타입",
	        	      "전화번호","전화번호1","전화번호2","전화번호3","전입일","전출일","등록구분"],
	        colModel:[
	                  {name:"apt_id",           index:"apt_id",         width:40,      align:"center", editable:true, edittype:"text"},
	                  {name:"dong",         	index:"dong",      		width:150,  align:"center", editable:true, edittype:"text"},
	                  {name:"ho",       		index:"ho",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"rank_no",       		index:"rank_no",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"nm",       		index:"nm",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"resi_type",       	index:"resi_type", 		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"resi_type_nm",     index:"resi_type_nm",	width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"tel",  			index:"tel",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"tel1",  			index:"tel1",  			width:100, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"tel2",  			index:"tel2",  			width:100, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"tel3",  			index:"tel3",  			width:100, align:"center", editable:true, edittype:"text", hidden:true},
	                  {name:"mvi_dt",   		index:"mvi_dt", 		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"mvo_dt",   		index:"mvo_dt",   		width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"cud_gbn",   		index:"cud_gbn",   		width:120, align:"center", editable:true, edittype:"text"}
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "aa.aaar010_2l"},
			onSelectRow : function(rid) {
				
	 		},
	        pager: '#pager2',
	        multiselect : true,
	        viewrecords:true		
	}	
	
	$(document).ready(function(){
		
		$("input:text[id$=_dt]").datepicker({
			dataeFormat : "yy-mm-dd"
		})
		
		
		$("#dia_resi_type").change(function(){
			if($(this).val()=="02"||$(this).val()=="03"){
				$("#dia_own_info_area").css("display","");
			}else{
				$("#dia_own_info_area").find(":text").val("");
				$("#dia_own_info_area").css("display","none");
			}
		})		
		
		
		_opt1.postData = setPostData(_opt1); 
	    $("#aaar010_1l").jqGrid(_opt1);

	    //_opt2.postData = setPostData(_opt2); 
	    $("#aaar010_2l").jqGrid(_opt2);
	    
	    
	    
	    
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
		
		var col_nm="";
		var col_val="";
		$(".gs").each(function(i){
			col_nm = $(this).attr("name")
			col_val = $(this).val()
			if(col_val != ""){
				console.log(col_nm+"::::"+col_val)
				paramObj[col_nm] = col_val
			}
		})
        $("#aaar010_1l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");		
	}	
	
	
	function js_move_ins(){
		document.location.href = "/aa/ar/010i"
	}
	
	
	function js_update(){
		
		if(!confirm("수정하시겠습니까?")){
			return;
		}
		
		var param = new Object();
		param.sqls = "aa.aaar010upd|aa.aaar010hins";
		param.crud = "U|C";
		param.apt_id = $("#apt_id").val();
		param.dong = $("#dia_dong").val();
		param.ho = $("#dia_ho").val();
		param.resi_type = $("#dia_resi_type option:selected").val();
		param.nm = $("#dia_nm").val();
		param.tel1 = $("#dia_tel1").val();
		param.tel2 = $("#dia_tel2").val();
		param.tel3 = $("#dia_tel3").val();
		param.mvi_dt = $("#dia_mvi_dt").val();
		param.mvo_dt = $("#dia_mvo_dt").val();
		param.cud_gbn = "U";
		
		param.own_nm = $("#dia_own_nm").val();
		param.own_tel1 = $("#dia_own_tel1").val();
		param.own_tel2 = $("#dia_own_tel2").val();
		param.own_tel3 = $("#dia_own_tel3").val();

		DwrHelper.serialExecute(param,{callback:function(){
			alert("수정이 완료되었습니다.")
			$("#aaar010_1ldia").dialog("close")
			js_search();	
			_onSelectRow(_opt1_grd_id)
			_opt1_grd_id = "";
		},async:false
		
		})
	}

	function js_delete(){
		
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		
		var param = new Object();
		param.sqls = "aa.aaar010del|aa.aaar010hins";
		param.crud = "D|C";
		param.apt_id = $("#apt_id").val();
		param.dong = $("#dia_dong").val();
		param.ho = $("#dia_ho").val();
		param.nm = $("#dia_nm").val();
		param.resi_type = $("#dia_resi_type option:selected").val();
		param.tel1 = $("#dia_tel1").val();
		param.tel2 = $("#dia_tel2").val();
		param.tel3 = $("#dia_tel3").val();
		param.mvi_dt = $("#dia_mvi_dt").val();
		param.mvo_dt = $("#dia_mvo_dt").val();
		param.cud_gbn = "D";
		
		DwrHelper.serialExecute(param,{callback:function(){
			alert("삭제가 완료되었습니다.")
			$("#aaar010_1ldia").dialog("close")
			
			js_search();
			
			param.sql = _opt2.sqls.lst;
			param.title = _opt2.sqls.title;
			
	        $("#aaar010_2l").setGridParam({
		    	postData : {"param" : JSON.stringify(param)},
	            loadComplete : function(data) {
	            	var gridList = data.gridList
	            },
	            gridComplete : function() {
	            }
	        }).trigger("reloadGrid");				
			
		},async:false
		
		})
	}
</script>
</head>
<body>
<input type="hidden" id="apt_id" name="apt_id" value="<%=_s_apt_id %>">

<div>
	동 : <input type="text" id="dong" name="dong" class="gs">
	호 : <input type="text" id="ho" name="ho" class="gs">
	이름 : <input type="text" id="nm" name="nm" class="gs">
	전화번호 : <input type="text" id="tel" name="tel" class="gs">
	주거타입 : 
	<select id="resi_type" name="resi_type" class="gs">
		<option value="">선택</option>
		<c:forEach var="data" items="${comClaCdLst}" varStatus="status">
			<option value="${data.COM_CD }">${data.COM_CD_NM }</option>
		</c:forEach>
	</select>
	전입일(시작일) : <input type="text" id="s_mvi_dt" name="s_mvi_dt" class="gs">
	전입일(종료일) : <input type="text" id="e_mvi_dt" name="e_mvi_dt" class="gs">
	전출일(시작일) : <input type="text" id="s_mvo_dt" name="s_mvo_dt" class="gs">
	전출일(종료일) : <input type="text" id="e_mvo_dt" name="e_mvo_dt" class="gs">
</div>
<div>
	<input type="button" value="홈" onclick="js_home()">
	<input type="button" value="등록" onclick="js_move_ins()">
	<input type="button" value="검색" onclick="js_search()">
</div>

<div>

<div id="aaar010_1ldia" style="display:none">
	
	<input type="hidden" id="dia_apt_id" name="dia_apt_id" value="" readonly>
	동:
	<input type="text" id="dia_dong" name="dia_dong" value="" readonly>
	</br>
	호수:
	<input type="text" id="dia_ho" name="dia_ho" value="">
	</br>
	이름:	
	<input type="text" id="dia_nm" name="dia_nm" value="">
	</br>
	주거타입 : 
	<select id="dia_resi_type" name="dia_resi_type" class="gs">
		<option value="">선택</option>
		<c:forEach var="data" items="${comClaCdLst}" varStatus="status">
			<option value="${data.COM_CD }">${data.COM_CD_NM }</option>
		</c:forEach>
	</select>
	</br>	
	전화번호
	<input type="text" id="dia_tel1" name="dia_tel1" value=""> - 
	<input type="text" id="dia_tel2" name="dia_tel2" value=""> - 
	<input type="text" id="dia_tel3" name="dia_tel3" value="">
	</br>
	전입일:	
	<input type="text" id="dia_mvi_dt" name="dia_mvi_dt" value="">	
	</br>
	전출일:	
	<input type="text" id="dia_mvo_dt" name="dia_mvo_dt" value="">	
	
	
	<div id="dia_own_info_area" style="display:none">
		소유자이름:	
		<input type="text" id="dia_own_nm" name="own_nm" value="">
		</br>
		소유자전화번호
		<input type="text" id="dia_own_tel1" name="dia_own_tel1" value=""> - 
		<input type="text" id="dia_own_tel2" name="dia_own_tel2" value=""> - 
		<input type="text" id="dia_own_tel3" name="dia_own_tel3" value="">	
	</div>	

	<div>
		<input type="button" onclick="js_update()" value="수정">
		<input type="button" onclick="js_delete()" value="삭제">
	</div>
</div>

<table id="aaar010_1l">
<div id="pager1"></div>
</table>

<table id="aaar010_2l">
<div id="pager2"></div>
</table>
</body>
</html>