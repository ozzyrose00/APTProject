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
	var _opt2_grd_id;
	var mode1="";
	var mode2="";
	var _opt1 = {
			url:"/grid_list.do", //ajax 요청주소
	        datatype:"json", //결과물 받을 데이터 타입
	        caption:"아파트목록",
	        mtype : "POST",
	        height:"auto",
	        rowNum:10,
	        gid : "cocd010_1l",
	        width : "100%",
	        colNames:["분류코드","분류코드명","사용여부"],
	        colModel:[
	                  {name:"com_cla_cd",       index:"com_cla_cd",         width:80,      align:"center", editable:true, edittype:"text"},
	                  {name:"com_cla_cd_nm",  	index:"com_cla_cd_nm",		width:150,     align:"center", editable:true, edittype:"text"},
	                  {name:"use_yn",       	index:"use_yn",     		width:80,      align:"center", editable:true, edittype:"select",
	                	  editoptions:{value: 'Y:Y;N:N'},stype : 'select',searchoptions : {value: ':all;Y:Y;N:N'}}
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "co.cocd010_1l",
				     "udt" : "co.cocd010_1u"},
			onSelectRow : _onSelectRow1,
	 		ondblClickRow : _ondblClickRow1,
	        pager: '#pager1',
	        //multiselect : true,
	        viewrecords:true		
	}
	
	function _onSelectRow1(rid){
		var _rd = $("#"+_opt1.gid).getRowData(rid);
	 	var lastid = $("#rid").val()
	    if(lastid!=""){
	       	$("#"+_opt1.gid).restoreRow(lastid,true);
	   	}
	    
		$("#"+_opt1.gid).editRow(rid, true);
	   	$("#rid").val(rid)
	   	omAddUptIcon(_opt1,'수정', rid);    
		
		var com_cla_cd = _rd.com_cla_cd;

		var paramObj = new Object();
		paramObj.sql = _opt2.sqls.lst;
		paramObj.title = _opt2.sqls.title;
		paramObj.com_cla_cd = com_cla_cd;	
		
        $("#cocd010_2l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");	
        
		_opt1_grd_id = rid;
		
		$("#com_cla_cd").val(com_cla_cd)
		mode1 = "update";
		
	}
	
	
	/**
	 * 그리드에 수정 아이콘 추가 & 아이콘 클릭 시 데이터베이스 작업 수행
	 */
	function omAddUptIcon(opt,nm, rid){
	    var udt_sql = opt.sqls.udt;
	    if(udt_sql == undefined) { 
	        alert("Update 작업에 필요한 Sql Id가 존재하지 않습니다.");
	        return;
	    }
	    
	    
	    var rcount = $("#"+opt.gid).getGridParam("reccount");
	    
	    for(var i = 1 ; i <= $("#"+opt.gid).getGridParam("reccount") ; i++){
	    	if(i != rid){
	    		$("#"+opt.gid).restoreRow(i, true)
	    	}
	    }
	    
	    var ui_icon_pencil_len = $(".ui-icon-pencil").length;
	    if(ui_icon_pencil_len>0){
	    	return;
	    }
	    
	    
	
		$("#"+opt.gid).jqGrid('navGrid','#pager1',
		 {edit:false,add:false,del:false,search:false,refresh:false}
		)
		.navButtonAdd('#pager1',{
			caption:"",
			title:"수정",
			buttonicon:"ui-icon-pencil",
			onClickButton: function(){
			 	//$('#searchBox').show();
			 	//$('#searchBox').draggable();
			 	
				var editable = $("#"+opt.gid+" .editable");
	            var _checked = true;
	            if(editable.length == 0) return;
	            var regData = {};
	            var pNm     = '';
	            var pVa     = '';
	            var cNo     = '';
	            var bNo     = '';
	            var rNo     = 0;
	            
	            regData['sql'] = udt_sql;
	            
	            var _cols   = opt.colModel;
	            var key     = "";
	            
	            editable.each(function() {
	                pNm = $(this).attr("id");
	                console.log(pNm)
	                pVa = $(this).val();
	                cNo = Number(pNm.substring(0, pNm.indexOf("_")));  
	                console.log(cNo)
	                pNm = pNm.substring(pNm.indexOf("_")+1);
	                console.log(pNm)
	                
	                var _row = $("#"+opt.gid).getRowData(cNo);
	                
	                regData[key] = _row[key];
	                //----------------------------------------
	                
	                /*
	                var _cAry = getColModelByName(grid, pNm);
	                if(_cAry[1].editrules && _cAry[1].editrules.required) {
	                    if(pVa.trim() == '') {
	                        alert(grid.opt.colNames[_cAry[0]]+" 은 필수 항목입니다. ");
	                        $(grid).focus();
	                        _checked = false;
	                        return false;
	                    } else {
	                        if(_cAry[1].editoptions.maxlength && _cAry[1].editoptions.maxlength < pVa.bytes()) {
	                            alert(grid.opt.colNames[_cAry[0]]+" 은 최대 "+_cAry[1].editoptions.maxlength+"자까지 입력할 수 있습니다.");
	                            _checked = false;
	                            return false;   
	                        }
	                    }
	                } 
	                */
	                
	                //----------------------------------------
	                if(cNo != bNo) {
	                    if(rNo > 1) {
	                        updateRowData(regData);                                
	                    }
	                    rNo++;
	                }
	                regData[pNm] = pVa;
	                bNo = cNo;
	            });
	            
	            if(_checked) {
	                updateRowData(regData, opt, true);
	                $("#"+opt.gid).trigger("reloadGrid");
	                $("#grid_upt"+rid).remove(); 
	            }
			 	
		 },
		 position:"last"
		 })	    

	}	
	
	/**
	 * 수정된 행의 내용을 데이터베이스에 저장하고 그리드를 갱신한다.
	 */
	function updateRowData(data, opt, reload) {
	    //$.syncPost("/grid_cms_update.mis", data, function(data, textStatus, XMLHttpRequest){
	    /*
	    $.post("/grid_update", data, function(data, textStatus, XMLHttpRequest){
	    });
	    */
	    
		$.ajax({
		    type: 'post',
		    url: '/grid_update',
		    data: data,
		    async: false,
		    //dataType: 'Json',  //생략하면 알아서 설정
		    success: function (result) {
			alert(result)
		    }
		});	    
	}	
	
	function _ondblClickRow1(rid) {
		var _rd = $("#"+_opt1.gid).getRowData(rid);
				
		$("#cocd010_1ldia").dialog({
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
	        gid : "cocd010_2l",
	        width : "100%",
	        colNames:["분류코드","공통코드","공통코드명","사용여부"],
	        colModel:[
	                  {name:"com_cla_cd",       index:"com_cla_cd",     width:40,      align:"center", editable:true, edittype:"text"},
	                  {name:"com_cd",  			index:"com_cd",			width:150,     align:"center", editable:true, edittype:"text"},
	                  {name:"com_cd_nm",  		index:"com_cd_nm",		width:150,     align:"center", editable:true, edittype:"text"},
	                  {name:"use_yn",       	index:"use_yn",     	width:40,      align:"center", editable:true, edittype:"select",editoptions:{value: 'Y:Y;N:N'}}
	                  ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
 				repeatitems: false
			}, 
			sqls :  {"lst" : "co.cocd010_2l","udt" : "co.cocd010_2u"},
			onSelectRow : function(rid) {
				var _rd = $("#"+_opt2.gid).getRowData(rid);
			 	var lastid = $("#rid").val()
			    if(lastid!=""){
			       	$("#"+_opt2.gid).restoreRow(lastid,true);
			   	}
			    
				$("#"+_opt2.gid).editRow(rid, true);
			   	$("#rid").val(rid)
			   	omAddUptIcon(_opt2,'수정', rid);    
				
				var com_cla_cd = _rd.com_cla_cd;

				var paramObj = new Object();
				paramObj.sql = _opt2.sqls.lst;
				paramObj.title = _opt2.sqls.title;
				paramObj.com_cla_cd = com_cla_cd;	
				
				_opt2_grd_id = rid;
				
				$("#cocd010_2l").find("[id$=_com_cla_cd]").attr("readonly",true)
				$("#cocd010_2l").find("[id$=_com_cd]").attr("readonly",true)
				
				mode2 = "update";
	 		},
	        pager: '#pager2',
	        //multiselect : true,
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
	    $("#cocd010_1l").jqGrid(_opt1)
		.jqGrid('navGrid','#pager1',
			{
		  	edit:false,
		    add:false,
		    del:false,
		    search:false,
		    refresh:false})	    
	    .jqGrid('navButtonAdd','#pager1',
	    		{
	      	caption:"Toggle",
	        title:"Toggle Search Toolbar",
	        buttonicon :'ui-icon-pin-s',
	        onClickButton:function(){
	          this.toggleToolbar() // $("#list")[0].toggleToolbar 같음
	        }})
	    //_opt2.postData = setPostData(_opt2);
	    
        $('#cocd010_1l').jqGrid('filterToolbar',{
			searchOnEnter: true
        });	    
	    
	    $("#cocd010_2l").jqGrid(_opt2);
	    
	    //$("#gs_com_cla_cd").parent().hide()
	    
	    
	    
	    
	     
	    
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
		/*
        $("#cocd010_1l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");
		*/
		//$("#cocd010_1l").trigger("reloadGrid");
	}	
	
	
	function js_move_ins(){
		document.location.href = "/aa/ar/010i"
	}
	
	
	
	function js_addrow(gbn){
		$("#cocd010_1l").find("tr").each(function(){
			console.log($(this).html())
		})
		return;
		if(gbn=="1"){
		}else{
			if($("#com_cla_cd").val()==""){
				alert("분류코드를 먼저 선택해주세요")
				return;
			}
		}		
		var opt = gbn=="1"?_opt1:_opt2
        var rcnt = Number($("#"+opt.gid).jqGrid("getGridParam", "records"));
        var nrowid = rcnt+1;
        var _newRow = {};
        $("#"+opt.gid).jqGrid('addRowData'  , nrowid, _newRow,"first");
        $("#"+opt.gid).jqGrid('setSelection', nrowid);
        $("#"+opt.gid).jqGrid('editRow'     , nrowid, true);		
		if(gbn=="1"){
			mode1 = "insert";
		}else{
			$("#"+opt.gid).find("[id*=com_cla_cd]").val($("#com_cla_cd").val())
			mode2 = "insert";
		}
	}
	
	var gridParam = function(opt){
		var rid = $("#"+opt.gid).jqGrid("getGridParam","selrow");
		var param = new Object();
		var id;
		var val;
		$("#"+opt.gid).find("select,:text").each(function(){
			id = $(this).attr("id")
			val = $(this).val()
			id = id.replace(rid+"_","");
			param[id] = val;
		})
		return param;
	}
	
	function js_save(gbn){
		var msg = "";	
		var sql = "";
		var modeStr = gbn=="1"?mode1:mode2
		if(modeStr=="insert"){
			msg = "정말로 저장 하시겠습니까?";
			sql = gbn=="1"?"co.cocd010_1i":"co.cocd010_2i";
		}else if(modeStr=="update"){
			msg = "정말로 수정 하시겠습니까?";
			sql = gbn=="1"?"co.cocd010_1u":"co.cocd010_2u";
		}else if(modeStr=="delete"){
			msg = "정말로 삭제 하시겠습니까?";
			sql = gbn=="1"?"co.cocd010_1d":"co.cocd010_2d";
		}else{
			msg = "";
		}
		
		if(!confirm(msg)){
			return;
		}
		
		var opt = gbn=="1"?_opt1:_opt2
		
		var param = gridParam(opt)
		param.sql = sql;
		DwrHelper.insert(param, {
			callback:function(data){
				alert("적용하였습니다.")
			},async:false})
		$("#"+opt.gid).trigger("reloadGrid")
		
		if(gbn=="1"){
			mode1 = "";
		}else{
			mode2 = "";
		}		
 	}
	
	function js_delete(gbn){
		if(!confirm("정말로 삭제 하시겠습니까?")){
			return;
		}
		var opt = gbn=="1"?_opt1:_opt2
		var param = gridParam(opt)
		
		var sql = gbn=="1"?"co.cocd010_1d":"co.cocd010_2d";
		param.sql = sql;
		DwrHelper.insert(param, {
			callback:function(data){
				alert("적용하였습니다.")
			},async:false})
		$("#"+opt.gid).trigger("reloadGrid")
		
		if(gbn=="1"){
			mode1 = "";
		}else{
			mode2 = "";
		}			
	}
</script>
</head>
<body>
<input type="hidden" id="apt_id" name="apt_id" value="<%=_s_apt_id %>">
<input type="hidden" id="rid" name="rid" value="">
<input type="hidden" id="com_cla_cd" name="com_cla_cd" value="">

<div style="text-align:left">
	<input type="button" value="홈" onclick="js_home()">
</div>


<div>
	<input type="button" value="추가" onclick="js_addrow('1')">
	<input type="button" value="삭제" onclick="js_delete('1')">
	<input type="button" value="적용" onclick="js_save('1')">
</div>

<table id="cocd010_1l">
<div id="pager1"></div>
</table>
</br>
<div>
	<input type="button" value="추가" onclick="js_addrow('2')">
	<input type="button" value="삭제" onclick="js_delete('2')">
	<input type="button" value="적용" onclick="js_save('2')">
</div>
<table id="cocd010_2l">
<div id="pager2"></div>
</table>
</body>
</html>