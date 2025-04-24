<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>  
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.*"%>
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
			
			
	List sche010List = (ArrayList)request.getAttribute("sche010List");
	//System.out.println("sche010List::::::::::"+sche010List.size());
	
	JSONArray sche010ListJsonArr = JSONArray.fromObject(sche010List);
	System.out.println("제이슨 결과 = " + sche010ListJsonArr.toString());
	
	String sche010ListJsonStr = sche010ListJsonArr.toString();
	
	
	System.out.println("++++++++++++++index.jsp++++++++++++++++++++");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
  <script>
  
  	var calendar;
  
	  //$(function(){
	$(document).ready(function(){		  
	
		var today = new Date();
		console.log(today.getFullYear())
		console.log(today.getMonth() + 1)
		console.log(today.getDate())
		var yy = today.getFullYear();
		var mm = lpad(today.getMonth() + 1, 2, "0");
		var dd = lpad(today.getDate(), 2, "0");
		var todayStr = yy + "-" + mm + "-" + dd
		
		$("input:text[id$=_dt]").datepicker({
			dataeFormat : "yy-mm-dd"
		})
		
		// 드래그 박스 취득
		var containerEl = $('#external-events-list')[0];
		// 설정하기
		new FullCalendar.Draggable(containerEl, {
			itemSelector : '.fc-event',
			eventData : function(eventEl) {
				return {
					title : eventEl.innerText.trim()
				}
			}
		});
		// 드래그 아이템 추가하기
		for (var i = 1; i <= 5; i++) {
			var $div = $("<div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'></div>");
			$event = $("<div class='fc-event-main'></div>").text(
					"Event " + i);
			$('#external-events-list').append($div.append($event));
		}
		// calendar element 취득
		var calendarEl = $('#calendar1')[0];
		// full-calendar 생성하기
		calendar = new FullCalendar.Calendar(
				calendarEl,
				{
					// 해더에 표시할 툴바
					headerToolbar : {
						left : 'prev,next today',
						center : 'title',
						right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
					},
					// initialDate: '', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
					locale : 'ko', // 한국어 설정
					editable : true, // 수정 가능
					droppable : true, // 드래그 가능
					drop : function(arg) { // 드래그 엔 드롭 성공시
						// 드래그 박스에서 아이템을 삭제한다.
						arg.draggedEl.parentNode
								.removeChild(arg.draggedEl);
					},
	                /* events: [
	                    {
	                    title: 'All Day Event',
	                    start: '2023-02-01'
	                    },
	                    {
	                    title: 'Long Event',
	                    start: '2023-02-07',
	                    end: '2023-02-10'
	                    }	                    
	                ], */

					//date 클릭 이벤트  dateClick : 날짜 셀을 클릭할 때 발생하는 이벤트, 
					//eventClick : 일정을 클릭할 때 발생하는 이벤트
					dateClick : function() {
						//일정 추가하기
						/*
						var sc_obj = new Object();
						sc_obj.title = "일정테스트"
						sc_obj.start = todayStr
						sc_obj.end = todayStr
						calendar.addEvent(sc_obj);
						*/
		
						$("#sche010dia").dialog({
							title : '다이얼로그 제목을 넣자',
							modal : true,
							width : '600',
							height : '400'
						});
						
						$("#sche010dia").find(":text,select").val("")
						
						$("#dia_btn1").css("display","");						
						$("#dia_btn2").css("display","none");						
						$("#dia_btn2").css("display","none");						
					},
					  eventClick: function(info) {
						    console.log(info.event)
						    
						    //alert('Event: ' + info.event.title);
						    //alert('start: ' + info.event.start);
						    //alert('start: ' + info.event.startStr);
						    //alert('id: ' + info.event.id);
						    info.el.style.borderColor = 'red';
						    
						    var param = new Object();
						    param.sql = "sc.sche010r";
						    param.sch_id = info.event.id
						    param.apt_id = "<%=_s_apt_id%>"
						    
						    DwrHelper.getObject(param, {callback:function(data){
								$("#dia_sch_id").val(data.sch_id)
								$("#dia_sch_title").val(data.sch_title)
								$("#dia_sch_content").val(data.sch_content)
								$("#dia_sch_start_dt").val(data.sch_start_dt)
								$("#dia_sch_end_dt").val(data.sch_end_dt)
								$("#dia_sch_complete_yn").val(data.sch_complete_yn)
								$("#dia_sch_approve_yn").val(data.sch_approve_yn)
						    },async:false})
						    
							$("#sche010dia").dialog({
								title : '다이얼로그 제목을 넣자',
								modal : true,
								width : '600',
								height : '400'
							});		
						    
							$("#dia_btn1").css("display","none");						
							$("#dia_btn2").css("display","");						
							$("#dia_btn2").css("display","");												    
					  }						    
				});
		var sc_obj = new Object();
		<%
		Map sche010Map = null;
		String title="";
		String start="";
		String end="";
		String sch_id="";
		if(sche010List != null){
			for(int i = 0; i < sche010List.size() ; i++){
				sche010Map = (HashMap)sche010List.get(i);
				title = sche010Map.get("SCH_TITLE")+"";
				start = sche010Map.get("SCH_START_DT")+"";
				end = sche010Map.get("SCH_END_DT")+"";
				sch_id = sche010Map.get("SCH_ID")+"";
		%>
			sc_obj.title="<%=title%>"
			sc_obj.start="<%=start%>"
			sc_obj.end="<%=end%>"
			sc_obj.id="<%=sch_id%>"
			calendar.addEvent(sc_obj);		
		<%
			}
		}
		%>
		// 캘린더 랜더링
		calendar.render();
	})
  
	function js_insert(){  
		if(!confirm("등록하시겠습니까?")){
			return;
		}
		frm.action="/sc/he/010ins"
		frm.submit();
	}  

	function js_delete(){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}
		frm.action="/sc/he/010d"
		frm.submit(); 
	}  

	function js_update(){
		if(!confirm("수정하시겠습니까?")){
			return;
		}
		frm.action="/sc/he/010u"
		frm.submit(); 
	}  
</script> 
  
  
<title>Insert title here</title>
<style>
  /* body 스타일 */
  body {
    margin-top: 40px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }
  /* 드래그 박스의 스타일 */
  #external-events {
    position: fixed;
    left: 20px;
    top: 20px;
    width: 100px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #eee;
    text-align: left;
  }
  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }
  #external-events .fc-event {
    margin: 3px 0;
    cursor: move;
  }
 
  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }
 
  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }
 
  #calendar-wrap {
    margin-left: 200px;
  }
 
  #calendar1 {
    max-width: 1100px;
    margin: 0 auto;
  }
</style>
</head>
<body>
  <div id='wrap'>
    <!-- 드래그 박스 -->
    <div id='external-events'>
      <h4>Draggable Events</h4>
      <div id='external-events-list'></div>
    </div>
    
    
    <div id="sche010dia" style="display:none">
    <form name="frm" method="post">
	<input type="hidden" id="dia_apt_id" name="dia_apt_id" value="<%=_s_apt_id%>" style="width:500px">    
	<input type="hidden" id="dia_sch_id" name="dia_sch_id" value="">    
		제목: <input type="text" id="dia_sch_title" name="dia_sch_title" value="" style="width:500px">
		</br>
		내용: <input type="text" id="dia_sch_content" name="dia_sch_content" value="" style="width:500px">
		</br>
		시작일 : <input type="text" id="dia_sch_start_dt" name="dia_sch_start_dt" value=""> 
		</br>
		종료일 : <input type="text" id="dia_sch_end_dt" name="dia_sch_end_dt" value="">
		</br>
		일정완료여부:
		<select id="dia_sch_complete_yn" name="dia_sch_complete_yn">
			<option value="N">N</option>
			<option value="Y">Y</option>
		</select>
		일정승인여부:
		<select id="dia_sch_approve_yn" name="dia_sch_approve_yn">
			<option value="N">N</option>
			<option value="Y">Y</option>
		</select>
    </form>   
		<div>
			<input type="button" id="dia_btn1" onclick="js_insert()" value="등록" style="display:none">
			<input type="button" id="dia_btn2" onclick="js_update()" value="수정" style="display:none">
			<input type="button" id="dia_btn3" onclick="js_delete()" value="삭제" style="display:none">
		</div>
	</div>    
    
    
    <!-- calendar 태그 -->
    <div id='calendar-wrap'>
      <div id='calendar1'></div>
    </div>
  </div>
</body>
</html>