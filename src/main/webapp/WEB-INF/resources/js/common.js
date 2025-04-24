
/**
 * 로그인 페이지 오픈
 * @return
 */
function getOpenLogin() {
	var url = "login.mis?returnPage=" + window.location.href;
	openWin( url, "login", 505, 335 );
}


function getMinwonLogin( link ) {
	//var path = XecurePath(link.pathname);
	var path = link.pathname
	var p;
	
	p = link.search;
	if ( p.length > 1 ) {
		p = "&" + link.search.substring(1);
	}
	
	var url = "gwangup.motie.go.kr/login.mis?returnPage=gwangup.motie.go.kr" + path + p;
	
	openWin( url, "login", 505, 400 );
	//XecureNavigate(url,"login","width=505,height=335,scrollbars=yes,resizable=yes");
}

/**
 * 팝업창 오픈
 * @param url
 * @param target
 * @param width
 * @param height
 * @return
 */
function openWin( url, target, width, height ) {
	var returnVal;
    var windowX = Math.ceil( (window.screen.width  - width) / 2 );
    var windowY = Math.ceil( (window.screen.height - height) / 2 );
    returnVal = window.open(url, target, "scrollbars=yes, status=no, toolbar=no, menubar=no, resizable=no, directories=no, width=" + width +",height=" + height+",left="+windowX+",top="+windowY );
    
    return returnVal;
	//var openNm = window.open( url, target, "width=" + width + ",height=" + height + ", scrollbars=yes, status=no, toolbar=no, menubar=no, resizable=no, directories=no" );
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

/**
 * 숫자에서 콤마를 빼고 반환.
 * @param n - 문자열
 * @return 
 */
function rtnnumber(n){
	n=n.replace(/,/g,"");
	if(isNaN(n)){return 0;} else{return n;}
}

/**
 * 숫자 백단위마다 콤마 추가
 * @param n
 * @return
 */
function addComma(n) {
 if(isNaN(n)){return 0;}
  var reg = /(^[+-]?\d+)(\d{3})/;   
  n += '';
  while (reg.test(n))
    n = n.replace(reg, '$1' + ',' + '$2');
  return n;
}

//정수값 검사 : IsInteger()
function IsInteger(st) {
	alert("st:::"+st)
    if (!IsEmpty(st)) {
        for (j = 0; j < st.length; j++) {
            if(((st.substring(j, j+1) < "0") || (st.substring(j, j+1) > "9")))
                return false;                    
        }
    }
    else
    {
        return false;
    }
    return true;
}

//공백검사
function IsEmpty(toCheck) {
    var chkstr = toCheck + "";
    var is_Space = true;
    if ((chkstr == "") || (chkstr == null)) {
        return false;
        for (j = 0; is_Space && (j < chkstr.length); j++) {
            if (chkstr.substring(j, j + 1) != " ")
                is_Space = false;
        }
        return (is_Space);
    }
}

/**
 * 주민번호 체크
 * @param obj1
 * @param obj2
 * @return
 */
function jumin_check(obj1, obj2) {
    str1 = obj1;
    str2 = obj2;
    var li_lastid, li_mod, li_minus, li_last;
    var value0, value1, value2, value3, value4, value5, value6;
    var value7, value8, value9, value10, value11, value12;
    if (IsInteger(str1) && IsInteger(str2)) {
        li_lastid = parseFloat(str2.substring(6, 7));
        value0 = parseFloat(str1.substring(0, 1)) * 2;
        value1 = parseFloat(str1.substring(1, 2)) * 3;
        value2 = parseFloat(str1.substring(2, 3)) * 4;
        value3 = parseFloat(str1.substring(3, 4)) * 5;
        value4 = parseFloat(str1.substring(4, 5)) * 6;
        value5 = parseFloat(str1.substring(5, 6)) * 7;
        value6 = parseFloat(str2.substring(0, 1)) * 8;
        value7 = parseFloat(str2.substring(1, 2)) * 9;
        value8 = parseFloat(str2.substring(2, 3)) * 2;
        value9 = parseFloat(str2.substring(3, 4)) * 3;
        value10 = parseFloat(str2.substring(4, 5)) * 4;
        value11 = parseFloat(str2.substring(5, 6)) * 5;
        value12 = 0;
        value12 = value0 + value1 + value2 + value3 + value4 + value5 + value6 + value7 + value8 + value9 + value10 + value11;
        li_mod = value12 % 11;
        li_minus = 11 - li_mod;
        li_last = li_minus % 10;
        
        if (li_last != li_lastid) {
            //obj2.select();
            //obj2.focus();
            return false;
        } else {
            return true;
        }
    } else {
        //obj2.select();
        //obj2.focus();
    }
    return false;
}


/**
 * 팝업창 닫기
 * @return
 */
function doClose() {
	window.close();
}

/*
 * byte계산
 */
function calBytes(str){
	var tcount = 0;
	var tmpStr = new String(str);
	var temp = tmpStr.length;
	var onechar;
	
	for ( k=0; k<temp; k++ ){
		onechar = tmpStr.charAt(k);
			if(escape(onechar).length > 4){
 					tcount += 2;
			}else{
 					tcount += 1;
			}
	}
	return tcount;
}

/*
 *외국인 등록번호 체크
 */
function isFrgNo(fgnno) { 
     var sum = 0; 
     var odd = 0; 
     buf = new Array(13); 
     
     for(i=0; i<13; i++) buf[i] = parseInt(fgnno.charAt(i)); 
      odd = buf[7]*10 + buf[8]; 
	      if(odd%2 != 0) return false; 
		      if((buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9)) return false; 
      multipliers = [2,3,4,5,6,7,8,9,2,3,4,5]; 

     for(i=0, sum=0; i<12; i++) sum += (buf[i] *= multipliers[i]); 
      sum = 11 - (sum%11); 
	      if(sum >= 10) sum -= 10; 
     			sum += 2; 
     		  if(sum >= 10) sum -= 10; 
     		  if(sum != buf[12]) return false;
     return true; 
 } 



/*
 *이메일 체크
 */
function ID_Duplicate()
{
 
  if(document.joinFrm.email.value == "") {
    alert("이메일 주소를 입력하시기 바랍니다.");
    document.joinFrm.email.focus();
    return;
  }

  var email = document.joinFrm.email.value;
  var emailEx1 = /^([A-Za-z0-9_-]{1,15})(@{1})([A-Za-z0-9_]{1,15})(.{1})([A-Za-z0-9_]{2,10})(.{1}[A-Za-z]{2,10})?(.{1}[A-Za-z]{2,10})?$/;
  if ( email != "" && email.search(emailEx1) == -1 ) {
    alert("이메일 주소를 제대로 입력하여 주십시요!!");
    document.joinFrm.email.focus();
    return;
  }

  /*
  if (CheckEmailAddr(email) == false) return;
  chk_no  = email.split("@");
  chk_no2 = "@"+chk_no[1].toLowerCase()+".";
  chk_no3 = chk_no2.indexOf("@hanmail.");
  chk_no4 = chk_no2.indexOf("@daum.");
  if(chk_no3 != '-1' || chk_no4 != '-1') {
      alert("hanmail은 등록하실수 없습니다.");
      document.joinFrm.email.focus();
      return; 
  }
  */
	  return true;
}


function CheckEmailAddr(strAddr) {
  var arrAddr;
  var arrMatch;
  var strEmail;

  if(strAddr.length == 0) return true;
  arrAddr = strAddr.replace(/,/, ",").split(",");

  for (var i = 0; i < arrAddr.length; i++) {
    arrMatch = arrAddr[i].match(/^([^<>]*)<([^<>]+)>$/);
    if (arrMatch == null) strEmail = arrAddr[i];
    else strEmail = arrMatch[2];

    if (strEmail != "") {
      if (checkEmail(strEmail) == false) {
        alert(arrAddr[i] + "는 잘못된 이메일주소입니다.");
        return false;
      }
    }
  }
  return true;
}

function checkEmail(strEmail) {
  var arrMatch = strEmail.match(/^(\".*\"|[A-Za-z0-9_-]([A-Za-z0-9_-]|[\+\.])*)@(\[\d{1,3}(\.\d{1,3}){3}]|[A-Za-z0-9][A-Za-z0-9_-]*(\.[A-Za-z0-9][A-Za-z0-9_-]*)+)$/);
  if(arrMatch == null) return false;

  return true;
}

function onlyNum() {
    e = window.event;
    if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 96 && e.keyCode <= 105 
             || e.keyCode == 8 || e.keyCode == 46 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 9 
             || e.keyCode == 109 || e.keyCode == 189 || e.keyCode == 110 || e.keyCode == 190
             || e.keyCode == 17 || e.keyCode == 35 || e.keyCode == 36) {

        if(e.keyCode == 48 || e.keyCode == 96 || e.keyCode == 109 || e.keyCode == 189 || e.keyCode == 13 
        		|| e.keyCode == 110 || e.keyCode == 190 ) { // 0, -, .
            // 0인 경우, -인 경우
        } else //0이 아닌숫자
            return; //-->입력시킨다.
        }
    else //숫자가 아니면 넣을수 없다.
        e.returnValue=false;
}	


/**
 * 입력받은 자릿수만큼 알아서 "0" 채워주기
 * @param objValue	Object 이름 (예) frm.reg_no
 * @param len	자릿수	(예) 5
 * @return
 */

function fillNo( getObj, len ) {
	if ( $.trim( getObj.val() ).length != 0 ) {
		getObj.val( lpad( getObj.val(), len, "0") );
	}
}

/**
 * Left 빈자리 만큼 padStr 을 붙인다.
 * @param src
 * @param len
 * @param padStr
 * @return
 */
function lpad(src, len, padStr){
    var retStr = "";
    var padCnt = Number(len) - String(src).length;
    for(var i=0;i<padCnt;i++) retStr += String(padStr);
    return retStr+src;
}

/******************************************************************************************
 * 함수명 : String검사 
 * 설 명 : input text의 String을 검사한다. 
 ******************************************************************************************/
 
$.checkAllInputString = function()
{
// 필수 입력값 확인하기
// 모든 input text가 필수 입력이다.
var inputs = $("input[type=text]").not("[id$=dt]");
 
// 부분만 일때
// var inputs = [];
// inputs[0] = form1.title;
// inputs[1] = form1.cntnt;
 
for ( var i = 0; i < inputs.length; i++)
{
 
// 보안 취약점을 검사한다.
if (!$.checkXSS(inputs[i].value))
{
alert("보안상 다음 문자열은 값으로 넘기실 수 없습니다.\n(cookie, script, document, 특수문자 ...)");
inputs[i].focus();
return false;
}
}
return true;
};
 
 
/****************************************************************************************** 
 * 함수명 : checkXSS() 
 * 설 명 : XSS 취약점 해결 
 ******************************************************************************************/
$.checkXSS = function(val)
{
 
// cookie, script, html 필터링
if (val.toLowerCase().indexOf("cookie") > -1 || val.toLowerCase().indexOf("script") > -1 || val.toLowerCase().indexOf("document") > -1) return false;
 
// 특수문자 필터링
if (val.indexOf("'") > -1 || val.indexOf("*") > -1 || val.indexOf("-") > -1 || val.indexOf("\"") > -1 || val.indexOf(";") > -1 || val.indexOf(":") > -1 || val.indexOf("+") > -1) return false;
 
// <, >, & 치환
val = val.replace("<", "&lt;");
val = val.replace(">", "&gt;");
val = val.replace("&", "&amp;");
val = val.replace("\"", "&quot");
val = val.replace("'", "&#39");
val = val.replace("/", "&frasl;");
val = val.replace("(", "&#40;");
val = val.replace(")", "&#41;");
 
return true;
};

/**
 * 인터넷 익스플로러 버전 확인
 * @return
 */
function getInternetExplorerVersion() {    
    var rv = -1; // Return value assumes failure.    
    if (navigator.appName == 'Microsoft Internet Explorer') {        
         var ua = navigator.userAgent;        
         var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");        
         if (re.exec(ua) != null)            
             rv = parseFloat(RegExp.$1);    
        }    
    return rv; 
}

/**
 * 팝업 공통 모듈
 * @param url
 * @param title
 * @param width
 * @param height
 * @return
 */
function popUpOpen(url, title, width, height) {
	if (title == '')
		title = 'Popup_Open';
	if (width == '')
		width = 540;
	if (height == '')
		height = 500;
	var left = "";
	var top = "";

	//화면 가운데로 배치
	var dim = new Array(2);

	dim = CenterWindow(height, width);
	top = dim[0];
	left = dim[1];

	var toolbar = 'no';
	var menubar = 'no';
    var status = 'no';
    var scrollbars = 'no';
    var resizable = 'no';
	var code_search = window.open(url, title, 'left=' + left + ', top='
			+ top + ',width=' + width + ',height=' + height + ', toolbar='
			+ toolbar + ', menubar=' + menubar + ', status=' + status
			+ ', scrollbars=' + scrollbars + ', resizable=' + resizable);
    code_search.focus();
	return code_search;
}

function CenterWindow(height, width) {
	var outx = screen.height;
	var outy = screen.width;
	var x = (outx - height) / 2;
	var y = (outy - width) / 2;
	dim = new Array(2);
	dim[0] = x;
	dim[1] = y;

	return dim;
}


/*
 * 20151201 추가
 */

//탑레이어
function js_headDiv(){
	if($("#notOpen").is(":checked")==true) {
		_setCookie("head-pop","head",1);
	}
	
	$("#head-pop").toggle();
}	

function _setCookie(name, value, expiredays) {
	var today = new Date();
	today.setDate(today.getDate()+expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + today.toGMTString() + ";"
}

function getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while( x <= document.cookie.length) {
		var y = (x+nameOfCookie.length);
		if(document.cookie.substring(x,y) == nameOfCookie) {
			if((endOfCookie=document.cookie.indexOf( ";", y )) == -1) {
				endOfCookie = document.cookie.length;
			}
			return false;
		} 
		x = document.cookie.indexOf(" ", x ) + 1;
		if( x == 0) break;

	}
	return true;
}	


//모든태그제거 
function removeTag( txt ) {
	txt = txt.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "")
	txt = txt.replace(/</ig, "");
	txt = txt.replace(/>/ig, "");	
	return txt;
}

function js_050l_pop(){
    var scr_width = ( screen.width - 10 );
    var scr_height = ( screen.height - 60 );
    var url = "https://branch.motie.go.kr/appeal/appeal05_1.jsp";
    var p = window.open(url, "popup_post", "top=0, left=0, width=" + scr_width + ", height=" + scr_height + ", resizable= yes,scrollbars=1");	
}

//GA-LSJ 메인 JS 추가
/* Main Banner */
$(document).ready(function(){
	var $careNum=0;
	var $theSize=$(".main_area .m_box").size();

	$(".main_area .m_box").hide();
	$(".main_area .m_box").eq(0).show();

	$(".leftBtn").click(function(){
		$careNum--;
		if($careNum<0) $careNum=$theSize-1;
		$(".main_area .m_box").hide();
		$(".main_area .m_box").eq($careNum).show();
	})

	$(".rightBtn").click(function(){
		$careNum++;
		if($careNum>=$theSize) $careNum=0;
		$(this).parent().children("div");
		$(".main_area .m_box").hide();
		$(".main_area .m_box").eq($careNum).show();
	})
});

/* Radio */
$(function(){
 $(".bene_radio img").click(function(){
  $(".bene_radio img").toggle();
 });
});

/* FAQ accodion
$(document).ready(function(){
    $("#faq dd").hide();
    $("#faq>dt>a").click(function(){
        //2.dd 요소 전부 숨긴다.
        //$("#faq dd").slideUp();
        $(this).parent().next().siblings("dd").slideUp("fast");
        //3. 해당하는 dd요소만 보인다.
        $(this).parent().next().slideDown("normal");

        $("#faq dt").removeClass("faq_active");
        $(this).parent().addClass("faq_active");
    })
})*/

/* Join Tab */
$(document).ready(function(){
    $("#join_tab div").hide();
    $("#join_tab div:eq(0)").show();

    $("#join_tab h3 a").bind("mouseover focus",function(){
        $("#join_tab div").hide();
        $(this).parent().next().show();
        $("#join_tab h3 img").each(function(){
            $(this).attr("src",$(this).attr("src").replace("on.png","off.png"));
        })
    $(this).children().attr("src",
    $(this).children().attr("src").replace("off.png","on.png"));
    })
})

/* Family */
jQuery(function($){
    var family = $('div.familysite');
    var fm_list = family.find('.family_list>li');

    $('.family_list').hide();
    // family show hide

    function over_fs(){$('.family_list').show();}

    function out_fs(){$('.family_list').hide();}

    family.find('a.fm_open').mouseover(over_fs).focus(over_fs);family.mouseleave(out_fs);
    family.find('>ul').mouseleave(out_fs);
    $('*:not(".familysite *")').focus(out_fs);
    // Over Out Menu
});

/*CEO*/
$(function(){
	$(".li01").click(function(){
		$("#company01").css("display","block");
		$("#company02").css("display","none");
		$("#company03").css("display","none");
	})
})

$(function(){
	$(".li02").click(function(){
		$("#company01").css("display","none");
		$("#company02").css("display","block");
		$("#company03").css("display","none");
	})
})

$(function(){
	$(".li03").click(function(){
		$("#company01").css("display","none");
		$("#company02").css("display","none");
		$("#company03").css("display","block");
	})
})
/*FAQ*/
$(function(){
	$(".dt01").click(function(){
	$(".dd01").css("display","block")
	$(".dd02").css("display","none")
	$(".dd03").css("display","none")
	$(".dd04").css("display","none")
	$(".dd05").css("display","none")
	$(".dd06").css("display","none")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt02").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","block")
	$(".dd03").css("display","none")
	$(".dd04").css("display","none")
	$(".dd05").css("display","none")
	$(".dd06").css("display","none")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt03").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","none")
	$(".dd03").css("display","block")
	$(".dd04").css("display","none")
	$(".dd05").css("display","none")
	$(".dd06").css("display","none")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt04").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","none")
	$(".dd03").css("display","none")
	$(".dd04").css("display","block")
	$(".dd05").css("display","none")
	$(".dd06").css("display","none")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt05").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","none")
	$(".dd03").css("display","none")
	$(".dd04").css("display","none")
	$(".dd05").css("display","block")
	$(".dd06").css("display","none")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt06").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","none")
	$(".dd03").css("display","none")
	$(".dd04").css("display","none")
	$(".dd05").css("display","none")
	$(".dd06").css("display","block")
	$(".dd07").css("display","none")
	})
})

$(function(){
	$(".dt07").click(function(){
	$(".dd01").css("display","none")
	$(".dd02").css("display","none")
	$(".dd03").css("display","none")
	$(".dd04").css("display","none")
	$(".dd05").css("display","none")
	$(".dd06").css("display","none")
	$(".dd07").css("display","block")
	})
})
/* allMenu */
function active_item() {
    var obj = document.getElementById("all_item");
    var btn = document.getElementById("all_item_close");

    if(obj.style.display == "" || obj.style.display=="none"){
        obj.style.display="block";
        btn.style.display="block";
        }else {
        obj.style.display="none";
        btn.style.display="none";
    }
    //obj.style.display="block";
}
function active_menu() {
    var obj01 = document.getElementById("m_depth_wrap");
    var btn01 = document.getElementById("m_menu_close");

    if(obj01.style.display == "" || obj01.style.display=="none"){
        obj01.style.display="block";
        btn01.style.display="block";
    }else {
        obj01.style.display="none";
        btn01.style.display="none";
    }
//obj.style.display="block";
}

 /* Gnb */
$(function(){
	$("#navi, #navi_bg").bind('mouseover focusin',function(){
		$( "#navi li div" ).css( 'display','block' );
		$( "#navi_bg" ).css( 'display','block' );
	});

	$("#lnb, #logo, #container").bind('mouseover focusin',function(){
		$( "#navi li div" ).css( 'display','none' );
		$( "#navi_bg" ).css( 'display','none' );
	});
});

$(function(){
	$("#navi, #snavi_bg").bind('mouseover focusin',function(){
		$( "#navi li div" ).css( 'display','block' );
		$( "#snavi_bg" ).css( 'display','block' );
	});

	$("#lnb, #logo, #container").bind('mouseover focusin',function(){
		$( "#navi li div" ).css( 'display','none' );
		$( "#snavi_bg" ).css( 'display','none' );
	});
});

/* Flag */
var m_bn_count=0;
var m_bn_p_click_check= 0;

function m_bn_init(){
    var $j=jQuery;

    m_bn_count = $j("#flag_wrap > ul > li").size();
    $j("#flag_wrap").css({"height":"100%","overflow":"hidden"})
    $j(".dir_prev").click(function(){m_bn_l_click();return false;});
    $j(".dir_next").click(function(){m_bn_r_click();return false;});

}

function m_bn_s_click(){
    var $j=jQuery;
    var count = $j("#flag_wrap > ul > li").size();

    m_bn_p_click_check = 0;
    $j("#flag_wrap > ul").stop();
    $j("#flag_wrap > ul").css({"left":"0px"});
    if(m_bn_count < count){
        $j("#flag_wrap > ul > li:last").remove();
    }
}
function m_bn_r_click(){
    var $j=jQuery;

    m_bn_s_click();
    $j("#flag_wrap > ul > li").eq(0).clone().appendTo($j("#flag_wrap > ul"));
    $j("#flag_wrap > ul > li").eq(0).remove();
}
function m_bn_l_click(){
    var $j=jQuery;

    m_bn_s_click();
    $j("#flag_wrap > ul > li:last").clone().prependTo($j("#flag_wrap > ul"));
    $j("#flag_wrap > ul > li:last").remove();
}

/* Moblie GNB */
jQuery(function($){
	var menu_v = $('div#m_depth_wrap');
	var sItem = menu_v.find('>ul>li');
	var ssItem = menu_v.find('>ul>li>ul>li');
	var lastEvent = null;

	sItem.find('>ul').css('display','none');
	menu_v.find('>ul>li>ul>li[class=active]').parents('li').attr('class','active');
	menu_v.find('>ul>li[class=active]').find('>ul').css('display','block');

	function menu_vToggle(event){
		var t = $(this);

		if (this == lastEvent) return false;
		lastEvent = this;
		setTimeout(function(){ lastEvent=null }, 200);

		if (t.next('ul').is(':hidden')) {
			sItem.find('>ul').slideUp(100);
			t.next('ul').slideDown(100);
		} else if(!t.next('ul').length) {
			sItem.find('>ul').slideUp(100);
		} else {
			t.next('ul').slideUp(100);
		}

		if (t.parent('li').hasClass('active')){
			t.parent('li').removeClass('active');
		} else {
			sItem.removeClass('active');
			t.parent('li').addClass('active');
		}
	}
	sItem.find('>a').click(menu_vToggle).focus(menu_vToggle);

	function subMenuActive(){
		ssItem.removeClass('active');
		$(this).parent(ssItem).addClass('active');
	};
	ssItem.find('>a').click(subMenuActive).focus(subMenuActive);

	menu_v.find('>ul>li>ul').prev('a').append('<span class="i"></span>');
});
