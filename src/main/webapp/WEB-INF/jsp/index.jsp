<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>
<%@ page import = "javax.servlet.http.HttpSession" %>  
<%@page import="java.util.Enumeration"%>
<%
	
	System.out.println("++++++++++++++jsp++++++++++++++++++++");
	String _isLogin = session.getAttribute("_isLogin")+"";
	String _s_usr_type = session.getAttribute("_s_usr_type")+"";
	String _s_usr_nm = session.getAttribute("_s_usr_nm")+"";
	
	Enumeration eu = session.getAttributeNames();
	String _s_key;
	String _s_val;
	while(eu.hasMoreElements()){
		_s_key = eu.nextElement()+"";
		_s_val = session.getAttribute(_s_key)+"";
		System.out.println("_s_key:::"+_s_key+"::::::_s_val:::"+_s_val);
	}
	
	System.out.println("++++++++++++++jsp++++++++++++++++++++");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function js_logIn(){
		if($("#usr_id").val()==""){
			alert("아이디를 입력하여 주십시오");
			return;
		}
		if($("#usr_pw").val()==""){
			alert("비밀번호를 입력하여 주십시오");
			return;
		}
		$("#usr_pw").val(hex_sha512( $("#usr_pw").val()))
		frm.action="/MISLoginAuth";
		frm.submit()
	}
	
	function js_logOut(){
		frm.action="/MISLogOutAuth";
		frm.submit()		
	}
	
	var _opt = {
			url:"/grid_list.do", //ajax 요청주소
            datatype:"json" , //결과물 받을 데이터 타입
            caption:"list",
            mtype : "POST",
            height:"auto",
            rowNum:10,
            colNames:["순번","제목","작성자","작성일","조회수"],
            colModel:[
                      {name:"seq_no", index:"seq_no", align:"center", editable:true, edittype:"text"},
                      {name:"title", index:"title", align:"center", editable:true, edittype:"text"},
                      {name:"name", index:"name", align:"center", editable:true, edittype:"text"},
                      {name:"make_ymd", index:"make_ymd", align:"center", editable:true, edittype:"text"},
                      {name:"srch_cnt", index:"srch_cnt", align:"center", editable:true, edittype:"text"}
                     ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "test.boardlist"},
            pager: '#pager',
            viewrecords:true 			
	}
	
	//그리드 데이터 형태
	//var gridData = [{name:"bbb", id:"aaa", email:"ccc@naver.com"}];
    $(document).ready(function(){
    	_opt.postData = setPostData(_opt); 
        $("#list").jqGrid(_opt);
    });	
    
    function setPostData(opt){
    	var _post_data = new Object();
    	_post_data.sql = opt.sqls.lst;
    	_post_data.title = opt.sqls.title;
    	return _post_data;
    }
    
    function search() {
        if($("#selectId").val() != "C") {
            //jsonObj.serviceImplYn = "T";
        }
		var paramObj = new Object();
		paramObj.serviceImplYn = "T";
		paramObj.abc = "abc";
		paramObj.sql = _opt.sqls.lst
		
    	$("#list").jqGrid("clearGridData", true);
        $("#list").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            //postData : {"param":paramObj}, 
            loadComplete : function(data) {
            	var gridList = data.gridList
            	//jsonReader 없이 데이터 뿌림
            	/*
				for(var i = 0 ; i < gridList.length ; i++){
					$(this).jqGrid('addRowData',i+1,gridList[i]);
				}
            	*/
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");
    }
    
    function js_move_ins(){
    	frm.action = "/aa/ai/010l"
    	frm.submit();
    }

    function js_usr_ins(){
    	frm.action = "/om/um/010i";
    	frm.submit();
    }
    
    function js_move_event(){
    	frm.action = "/cm/ei/010l";
    	frm.submit();
    }

    function js_move_event_apply(){
    	frm.action = "/cm/ai/010l";
    	frm.submit();
    }

    function js_move_resi(){
    	frm.action = "/aa/ar/010l";
    	frm.submit();
    }

    function js_move_calendar(){
    	frm.action = "/sc/he/010l";
    	frm.submit();
    }
    
    function js_com_cd_info(){
    	frm.action="/co/cd/010l"
    	frm.submit();
    }

    function js_sms_sendPage(){
    	frm.action="/mm/sm/sms_sendPage"
    	frm.submit();
    }

</script>
</head>
<body>
	<form name="frm" id="frm" method="post" >

<%
	if("Y".equals(_isLogin)){
%>
	<span><%=_s_usr_nm%>님 환영합니다.</span>
	<input type="button" onclick="js_logOut()" value="로그아웃">
<%		
	}else{
%>
		<div>
			아이디 : <input type="text" id="usr_id" name="usr_id" value=""></br> 
			비번    : <input type="text" id="usr_pw" name="usr_pw" value=""> 
		</div>
		<div >
			<input type="button" onclick="js_logIn()" value="로그인">
			<input type="button" onclick="js_usr_ins()" value="회원가입">
		</div>
<%		
	}
%>		
		
		<div>
			<input type="button" onclick="js_move_event()" value="강좌및행사관리">
			<input type="button" onclick="js_move_event_apply()" value="강좌및행사신청관리">
			<input type="button" onclick="js_move_resi()" value="입주민관리">
			<input type="button" onclick="js_move_calendar()" value="일정관리">
			<input type="button" onclick="js_com_cd_info()" value="공통코드관리">
			<input type="button" onclick="js_sms_sendPage()" value="문자전송">
			<input type="button" onclick="js_usr_ins()" value="회원가입">
		</div>
	</form>
<!-- <span><a href="#" onclick="javascript:search();">Search</a></span> -->
<input type="button" onclick="search()" value="검색">	
<input type="button" onclick="js_move_ins()" value="아파트관리">	
<table id="list"></table>
<div id="pager"></div>	
</body>
</html>