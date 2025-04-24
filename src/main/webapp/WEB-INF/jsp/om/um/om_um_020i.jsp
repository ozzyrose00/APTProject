<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.oz.aptproject.web.service.IbatisHelper"%>
<%@ include file='/WEB-INF/jspf/inc_script.jspf'%>
<%
	Map prms = new HashMap();
	prms.put("sql","test.comclacdLst");
	prms.put("com_cla_cd","A2");
	List usr_type_list = (ArrayList)IbatisHelper.selectList(prms);
	//System.out.println("usr_type_list:::"+usr_type_list);

%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function js_apt_find(){
		
	}
	
	function js_id_dup_chk(){
		var usr_id = $("#usr_id").val()
		if(usr_id==""){
			alert("아이디를 입력해주세요");
		}
		var param = new Object();
		param.sql = "om.js_id_dup_chk";
		param.usr_id = usr_id

		DwrHelper.getObject(param, {
			callback:function(data){
				var cnt = data.cnt
				if(cnt > 0){
					alert("중복된 아이디 입니다.")
					$("#usr_id").val("");
				}else{
					alert("사용 가능한 아이디 입니다.")
					$("#js_id_dup_chk_txt").val(cnt)	
				}
			},async:false})	
			
			
  	}
	
	function js_usr_ins(){
		var js_id_dup_chk_txt = $("#js_id_dup_chk_txt").val();
		if(js_id_dup_chk_txt == ""){
			alert("중복확인을 해주세요");
			return;
		}

		if(js_id_dup_chk_txt!="0"){
			alert("중복된 아이디 입니다.");
			$("#js_id_dup_chk_txt").val("");
			document.getElementById("usr_id").focus(); 
		}
		
		$("#enc_usr_pw").val(hex_sha512( $("#usr_pw").val()))
		
		frm.action="/om/um/020ins";
		frm.submit();
	}
	
	function js_apt_info_srh(){
		var url = "/om/um/020p";
		var name="js_apt_info_srh";
		var option="width=500, height=500, top=100, left=200, scroll=yes"
		window.open(url, name, option)
	}
	
	
	
</script>
</head>
<body>
<form name="frm" method="post">
<input type="hidden" id="js_id_dup_chk_txt" name="js_id_dup_chk_txt" value="">
<input type="hidden" id="enc_usr_pw" name="enc_usr_pw" value="">
	아이디 : <input type="text" id="usr_id" name="usr_id" value="">
	<input type="button" value="중복확인" onclick="js_id_dup_chk()"></br>
	비밀번호 : <input type="text" id="usr_pw" name="usr_pw" value=""></br>
	비밀번호확인: <input type="text" id="usr_pw_cfr" name="usr_pw_cfr" value=""></br>
	이름 : <input type="text" id="usr_nm" name="usr_nm" value=""></br>	
	구분: 
	<select id="usr_type" name="usr_type">
		<option value="">선택</option>
<%
Map usr_type_map = null;
if(usr_type_list!=null){
	for(int i = 0 ; i < usr_type_list.size() ; i++){
		usr_type_map = (HashMap)usr_type_list.get(i);
		String cd = usr_type_map.get("COM_CD")+"";
		String cdnm = usr_type_map.get("COM_CD_NM")+"";
%>
		<option value="<%=cd%>"><%=cdnm %></option>
<%		
	};
};
%>		
	</select>
</br>	
<div>
	<input type="hidden" id="apt_id" name="apt_id" value=""> 
	<input type="text" id="apt_nm" name="apt_nm" value="" readonly> 
	<input type="button" value="아파트검색" onclick="js_apt_info_srh()"></br>
</div>
<input type="button" value="저장" onclick="js_usr_ins()">	
</form>
</body>
</html>