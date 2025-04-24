<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
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
	        gid : "cmei010l",
	        width : "100%",
	        colNames:["아파트아이디","행사아이디","행사명","행사타입","행사타입명","행사시작일",
	        	      "행사종료일","신청시작일","신청종료일","종료여부"],
	        colModel:[
	                  {name:"apt_id",           index:"apt_id",         width:40,      align:"center", editable:true, edittype:"text"},
	                  {name:"event_id",         index:"event_id",       width:40,     align:"center", editable:true, edittype:"text"},
	                  {name:"event_nm",         index:"event_nm",       width:150,  align:"center", editable:true, edittype:"text"},
	                  {name:"event_type",       index:"event_type",     width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"event_type_nm",    index:"event_type_nm",  width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"event_start_dt",   index:"event_start_dt", width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"event_end_dt",     index:"event_end_dt",   width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"apply_start_dt",   index:"apply_start_dt", width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"apply_end_dt",     index:"apply_end_dt",   width:120, align:"center", editable:true, edittype:"text"},
	                  {name:"apply_end_yn",     index:"apply_end_yn",   width:120, align:"center", editable:true, edittype:"text"}
	                 ],
			//jsonReader 가 있어야 데이터를 뿌려줌                
			jsonReader : { 
				page: "page", 
				total: "total", 
				root: "gridList", 
				records: function(obj){return obj.length;},
				repeatitems: false
			}, 
			sqls :  {"lst" : "cm.cmei010l"},
			onSelectRow : function(rid) {
				var _rd = $("#"+_opt.gid).getRowData(rid);
				var dia_apt_id = _rd.apt_id
				var dia_event_id = _rd.event_id
				var dia_event_nm = _rd.event_nm
				var dia_event_type = _rd.event_type
				var dia_event_start_dt = _rd.event_start_dt
				var dia_event_end_dt = _rd.event_end_dt
				var dia_apply_start_dt = _rd.apply_start_dt
				var dia_apply_end_dt = _rd.apply_end_dt
				var dia_apply_end_yn = _rd.apply_end_yn
				
				$("#dia_apt_id").val(dia_apt_id);
				$("#dia_event_id").val(dia_event_id);
				$("#dia_event_nm").val(dia_event_nm);
				$("#dia_event_type").val(dia_event_type);
				$("#dia_event_start_dt").val(dia_event_start_dt);
				$("#dia_event_end_dt").val(dia_event_end_dt);
				$("#dia_apply_start_dt").val(dia_apply_start_dt);
				$("#dia_apply_end_dt").val(dia_apply_end_dt);
				$("#dia_apply_end_yn").val(dia_apply_end_yn);
				
				$("#cmei010ldia").dialog({
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
    	
		$('ul.tabs li').click(function(){							//선택자를 통해 tabs 메뉴를 클릭 이벤트를 지정해줍니다.
			var tab_id = $(this).attr('data-tab');
			//모든 탭의 current 요소를 지운다
			$('ul.tabs li').removeClass('current');			//선택 되있던 탭의 current css를 제거하고 
			$('.tab-content').removeClass('current');		
			//선택한 탭의 current를 적용
			$(this).addClass('current');								////선택된 탭에 current class를 삽입해줍니다.
			$("#" + tab_id).addClass('current');
		})    	
    	
		$("input:text[id$=_dt]").datepicker({
			dataeFormat : "yy-mm-dd"
		})    	
    	
    	_opt.postData = setPostData(_opt); 
        $("#cmei010l").jqGrid(_opt);
        
		//_opt2.postData = setPostData(_opt2); 
	    $("#cmai010l").jqGrid(_opt2);        
    });	
	
    function setPostData(opt){
    	var _post_data = new Object();
    	_post_data.sql = opt.sqls.lst;
    	_post_data.title = opt.sqls.title;
    	_post_data.apt_id = $("#apt_id").val();
    	return _post_data;
    }	
    
    function js_move_ins(){
    	
    	//alert($("#"+_opt.gid+" input:checkbox:checked").length)
		$($("#"+_opt.gid+" input:checkbox:checked")).each(function(){
			var id = $(this).attr("id");
			var idx = id.replace("jqg_"+_opt.gid+"_","");
			
		})    	
    	location.href = "/cm/ei/010i"
    }
    
    function js_update(){
    	
    	if(!confirm("정말로 수정하시겠습니까?")){
    		return;
    	}
    	
    	var param = new Object();
    	
    	param.sql = "cm.cmei010u"
    	param.apt_id = $("#dia_apt_id").val();
    	param.event_id = $("#dia_event_id").val();
    	param.event_nm = $("#dia_event_nm").val();
    	param.event_type = $("#dia_event_type option:selected").val();
    	param.event_start_dt = $("#dia_event_start_dt").val();
    	param.event_end_dt = $("#dia_event_end_dt").val();
    	param.apply_start_dt = $("#dia_apply_start_dt").val();
    	param.apply_end_dt = $("#dia_apply_end_dt").val();
    	param.apply_end_yn = $("#dia_apply_end_yn").val();  
    	
    	DwrHelper.update(param,{callback:function(data){
    		alert("수정이 완료되었습니다.")
    		$("#cmei010ldia").dialog("close")
    		$("#cmei010l").trigger("reloadGrid");
    	},async:false})
    }

    function js_delete(){
    	
    	if(!confirm("정말로 삭제하시겠습니까?")){
    		return;
    	}    	
    	
    	var param = new Object();
    	
    	param.sql = "cm.cmei010d"
    	param.apt_id = $("#dia_apt_id").val();
    	param.event_id = $("#dia_event_id").val();
    	
    	DwrHelper.remove(param,{callback:function(data){
    		alert("삭제가 완료되었습니다.")
    		$("#cmei010ldia").dialog("close")
    		$("#cmei010l").trigger("reloadGrid");
    	},async:false})
    }
    
    function js_win(){
    	if(!confirm("정말로 추첨하시겠습니까?")){
    		return;
    	}
    	//신청자 목록 가져오기
    	var param = new Object();
    	param.sql = "cm.cmai010l"
    	param.apt_id = $("#dia_apt_id").val();
    	param.event_id = $("#dia_event_id").val();    	
    	param.win_yn = "N";
    	
    	var win_cnt = Number($("#win_cnt").val());
    	var t_cnt = 0;
    	
    	
    	console.log(param)
    	var apply_id;
    	var apply_cnt
    	var arr_apply_info;
    	
    	var arr_win_id = new Array();
    	var result_id = 0;
    	
    	
		var arr_win_id_last_val; 
		var win_apply_id;
		var win_apply_cnt;
		/**
		* 추첨원리 : 5명 추첨일 경우
		
		처음에 조건에 맞는 추첨대상을 모두 불러옴
		
		정렬 순서로 순번을 정하고 
		
		* while 무한루프 돌면서 난수를 발생시켜 값을 push.
		*  
		* 배열값 비교를 통해 중복인 경우는 지우고 다시 난수 발생시켜 push
		* 
		* 배열의 마지막 값만 update 를 반복
		*
		*/
		var while_cnt = 0
		DwrHelper.getList(param,{callback:function(data){
			if(data!=null){
				while(true){
					//1. 0부터 (전체 리스트 갯수) -1 숫자 사이의 정수를 고름
	    			t_cnt = data.length;
	    			console.log("t_cnt::::"+t_cnt)
	    			var random = Math.random();
	    			//0이 포함되어야함
	    			result_id = Math.floor(random*t_cnt)
	    			//2. 선택한 정수 를  배열에 다음. 단 arr_win_id 배열은 중복되어선 안된다.
	    			arr_win_id.push(result_id)
	    			
	    			var arr_win_id_len = arr_win_id.length;
	    			
	    			/**
	    			* 배열중복제거
	    			var arr = ['A', 'B', 'C', 'A', 'B'];
					var newArr = Array.from(new Set(arr));
					console.log(newArr)
	    			*/
	    			// arr_win_id 배열 중복 제거
	    			
	    			if(arr_win_id_len > 1){
	    				
						var new_arr_win_id = Array.from(new Set(arr_win_id));
						var new_arr_win_id_len = new_arr_win_id.length
		    			console.log("arr_win_id:::"+arr_win_id)
		    			console.log("new_arr_win_id_len:::"+new_arr_win_id)
		    			
						if(arr_win_id_len>new_arr_win_id_len){
							arr_win_id = new_arr_win_id
							console.log("처음으로")
							continue;	
						}
	    			}
	    			
	    			console.log("########################")
	    			console.log(result_id)
	    			console.log("########################")
	    			
	    			arr_apply_info = new Array(data.length)
	    			
		    		for(var i = 0 ; i < data.length; i++){
		    			arr_apply_info[i] = new Array(3)
		    			apply_id = data[i].APPLY_ID;
		    			apply_cnt = data[i].APPLY_CNT;
		    			
		    			arr_apply_info[i][0] = i;
		    			arr_apply_info[i][1] = apply_id;
		    			arr_apply_info[i][2] = apply_cnt;
		    		}
	    			
	    			console.log("arr_apply_info:::"+arr_apply_info)
	    			
	    			/**
	    			* 배열중복제거를 했기때문에 배열 마지막 값만 이용하면 된다
	    			*/
		    		//배열 마지막 값 가져오기 -> 마지막 배열 자체 arr_win_id.slice(-1) -> 마지막 배열 값 arr_win_id.slice(-1)[0]
		    		arr_win_id_last_val = arr_win_id.slice(-1)[0] 
		    		
		    		win_apply_id = arr_apply_info[arr_win_id_last_val][1];
		    		win_apply_cnt = arr_apply_info[arr_win_id_last_val][2];
		    		
					var cal_cnt =	Number(win_cnt - win_apply_cnt);	
					console.log("cal_cnt:::"+cal_cnt)
					
					if(cal_cnt<0){
		    			continue;
					}else{
			    		win_cnt = win_cnt - win_apply_cnt;
						var win_param = new Object();
						win_param.sql = "cm.apt_event_apply_info_win_yn_upd"
						win_param.apt_id = $("#dia_apt_id").val();
						win_param.event_id = $("#dia_event_id").val();    	
						win_param.apply_id = win_apply_id;    	
						win_param.win_yn = "Y";
						
						console.log("win_param:"+win_param)
						
						DwrHelper.update(win_param,{callback:function(win_data){
							
						},async:false})
						if(cal_cnt == 0){
							break;
						}
					}
					console.log("win_cnt:::"+win_cnt)
					/*
		    		if(cal_cnt > 0){
			    		win_cnt = win_cnt - win_apply_cnt;
		    		}else if(cal_cnt == 0){
			    		win_cnt = win_cnt - win_apply_cnt;
		    			break;
		    		}else{
		    			continue;
		    		}//if else
		    		*/
		    		if(while_cnt > 30){
		    			break;
		    		}
					while_cnt++
				}//while
			}//if data null
		},async:false}) 
		alert("추첨이 완료되었습니다.")
    }
    
    function js_win_apply_info_lst(){
    	$("#div_cmai010l").attr("style","")
    	
    	
		var paramObj = new Object();
		paramObj.sql = "cm.cmai010l";
		paramObj.apt_id = $("#dia_apt_id").val();
		paramObj.event_id = $("#dia_event_id").val()	
		paramObj.win_yn = "Y";	
		
        $("#cmai010l").setGridParam({
	    	postData : {"param" : JSON.stringify(paramObj)},
            loadComplete : function(data) {
            	var gridList = data.gridList
            },
            gridComplete : function() {
            }
        }).trigger("reloadGrid");	    	
    }
    
    
    var _opt2 = {
			url:"/grid_list.do", //ajax 요청주소
	        datatype:"json", //결과물 받을 데이터 타입
	        caption:"당첨자목록",
	        mtype : "POST",
	        height:"auto",
	        rowNum:10,
	        gid : "cmai010l",
	        width : "100%",
	        colNames:["동","호수","이름",
	        	      "전화번호","신청인원","당첨여부","신청일"],
	        colModel:[
	                  {name:"dong",         	index:"dong",      		width:40,  align:"center", editable:true, edittype:"text"},
	                  {name:"ho",       		index:"ho",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"nm",       		index:"nm",     		width:40, align:"center", editable:true, edittype:"text"},
	                  {name:"tel",  			index:"tel",  			width:100, align:"center", editable:true, edittype:"text"},
	                  {name:"apply_cnt",   		index:"apply_cnt", 		width:70, align:"center", editable:true, edittype:"text"},
	                  {name:"win_yn",   		index:"win_yn",   		width:70, align:"center", editable:true, edittype:"text"},
	                  {name:"cre_dt",		    index:"cre_dt", 		width:100, align:"center", editable:true, edittype:"text"}
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
	 		},
	        pager: '#pager2',
	        multiselect : true,
	        viewrecords:true		
	}    
    
    
</script>
<style>
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}

ul.tabs li{
  display: inline-block;
	background: #898989;
	color: white;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #e0e0e0;
	color: #222;
}

.tab-content{
  display: none;
	background: #e0e0e0;
	padding: 12px;
}

.tab-content.current{
	display: inherit;
}
</style>
</head>
<body>
<input type="hidden" id="apt_id" name="apt_id" value="<%=_s_apt_id %>">
<div  style="width:920px;text-align:right">
	<input type="button" value="홈" onclick="js_home()">
<input type="button" value="등록" onclick="js_move_ins()">
</div>
<div id="cmei010ldia" style="display:none" class="container">
	
	<input type="hidden" id="dia_apt_id" name="dia_apt_id" value="">
	<input type="hidden" id="dia_event_id" name="dia_event_id" value="">
	
<!-- 탭 메뉴 상단 시작 -->
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">상세보기</li>
		<li class="tab-link" data-tab="tab-2">추첨</li>
	</ul>
<!-- 탭 메뉴 상단 끝 -->	
	
	<div id="tab-1" class="tab-content current">
    <h1></h1>
	    <div>
			구분: 
			<select id="dia_event_type" name="dia_event_type" >
				<option value="">선택</option>
				<c:forEach var="data" items="${com_A1_list}" varStatus="status">
				     <option value="<c:out value="${data.COM_CD}"/>">${status.count}.<c:out value="${data.COM_CD_NM}"/></option>
				</c:forEach>
			</select>	
			</br>
			제목: <input type="text" id="dia_event_nm" name="dia_event_nm" value="" style="width:500px">
			</br>
			시작일 : <input type="text" id="dia_event_start_dt" name="dia_event_start_dt" value=""> 
			</br>
			종료일 : <input type="text" id="dia_event_end_dt" name="dia_event_end_dt" value="">
			</br>
			신청시작일: <input type="text" id="dia_apply_start_dt" name="dia_apply_start_dt" value="">
			</br>
			신청종료일: <input type="text" id="dia_apply_end_dt" name="dia_apply_end_dt" value="">
			</br>
			신청종료여부:
			<select id="dia_apply_end_yn" name="dia_apply_end_yn">
				<option value="">선택</option>
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select>
			<div>
				<input type="button" onclick="js_update()" value="수정">
				<input type="button" onclick="js_delete()" value="삭제">
			</div>
		</div>
	</div>
	
	<div id="tab-2" class="tab-content">
	    <div>
	    	<input type="text" name="win_cnt" id="win_cnt">
	    </div>
	    <div>
	    	<input type="button" onclick="js_win()" value="추첨">
	    	<input type="button" onclick="js_win_apply_info_lst()" value="결과보기">
	    </div>
	    
	    <div id="div_cmai010l" style="display:none">
		<table id="cmai010l">
		<div id="pager2"></div>
		</table>		    
	    </div>
    </div>
</div>
<table id="cmei010l">
<div id="pager"></div>
</table>
</body>
</html>