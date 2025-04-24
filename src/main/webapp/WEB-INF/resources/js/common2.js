var mobileFlag = false;
var webFlag = false;
AgentFlag = set_ui();
IEFlag = (navigator.appVersion.indexOf("MSIE 7") > -1 || navigator.appVersion.indexOf("MSIE 8") > -1)?true:false;
IE7Flag = (navigator.appVersion.indexOf("MSIE 7") > -1)?true:false;
ReponList = [];
$(document).ready(function(){
	npos = $(window).scrollTop();
	SW	=	$(window).width();
	SH	=	$(window).height();		
	$('#lnb').find('.lnb_con > ul > li > a').click(function(){		
		lnbMenuAlign($(this).parent().index());
	});	
	$('.gnb').find('> ul').bind('mouseenter mouseleave',function(e){
		if(e.type == 'mouseenter'){
			$(this).find('.snb').show();
		}else{
			$(this).find('.snb').hide();
		}
	});
	$('.btn_m_request').click(function(){
		if($('#header').find('.request_list').hasClass('open')){
			$('#header').find('.request_list').removeClass('open');
		}else{
			$('#header').find('.request_list').addClass('open');
		}
	});

	gnbCheck();


	/* List Reponsive Height */
	if(!IE7Flag){
		if($('.list').length > 0){
			$('.list').each(function(){
				var list = new ReponsiveList($(this));
				ReponList.push(list);
			});
		}
	}

	$('.top_search_wrap').mouseleave(function(){
		$('.top_search').removeClass('open');
		$(this).hide();
	});
	
});//end ready

$(window).load(function(){
	$('#container').css({'visibility':'visible'})	
});//window end

$(window).scroll(function() {			
	npos = $(window).scrollTop();
	SW	=	$(window).width();
	SH	=	$(window).height();
	gnbCheck();

});//end scroll

$(window).resize(function(){
	npos = $(window).scrollTop();
	SW	=	$(window).width();
	SH	=	$(window).height();	
	gnbCheck();
	if(!IE7Flag)ReponsiveListResize();
});//end resize

function gnbCheck(){
	if(SW > 1023 && npos > 40){		
		$('#header').addClass('on');
	}else{		
		$('#header').removeClass('on');
	}
	if(SW > 1023){
		$('#wrap').removeClass('lnbOpen');
		$('#lnb').find('.lnb_wrap').removeClass('open').addClass('default');
		lnbFlag = false;
		$('#lnb').hide();
	}
}


function McheckLnb(){
	if($('#lnb').find('.lnb_wrap').hasClass('open')){
		//close
		lnbFlag = false;
		$('#lnb').find('.lnb_wrap').removeClass('open').addClass('default');
		setTimeout(function(){
			$('#lnb').hide();
		},300);
		$('#wrap').removeClass('lnbOpen');		
	}else{
		//open
		$('#lnb').stop(true).fadeIn(300,function(){
			$('#lnb').find('.lnb_wrap').removeClass('default').addClass('open');
			$('#wrap').addClass('lnbOpen');
			lnbFlag = true;
		});			
	}		
}

function lnbMenuAlign(_c){
	$('#lnb').find('.lnb_con > ul > li').each(function(){
		if($(this).index() == _c){
			$(this).addClass('actived');
			$(this).find('.snb').stop(true).fadeIn(300);
		}else{
			$(this).removeClass('actived');
			$(this).find('.snb').stop(true).hide();
		}
	});
}



//parameter
function getParameter(key) 
{ 
    var url = location.href; 
    var spoint = url.indexOf("?"); 
    var query = url.substring(spoint,url.length); 
    var keys = new Array; 
    var values = new Array; 
    var nextStartPoint = 0; 
    while(query.indexOf("&",(nextStartPoint+1) ) >-1 ){ 
        var item = query.substring(nextStartPoint, query.indexOf("&",(nextStartPoint+1) ) ); 
        var p = item.indexOf("="); 
        keys[keys.length] = item.substring(1,p); 
        values[values.length] = item.substring(p+1,item.length); 
        nextStartPoint = query.indexOf("&", (nextStartPoint+1) ); 
    } 
    item = query.substring(nextStartPoint, query.length); 
    p = item.indexOf("="); 
    keys[keys.length] = item.substring(1,p); 
    values[values.length] = item.substring(p+1,item.length); 
    var value = ""; 
    for(var i=0; i<keys.length; i++){ 
        if(keys[i]==key){ 
            value = values[i]; 
        } 
    } 
    return value; 
};//end getParameter

function set_ui(){
	var UserAgent = navigator.userAgent;
	var UserFlag	=	true;
	if (UserAgent.match(/iPhone|iPad|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
	{
		//mobile!!
		UserFlag = false;
	}
	return UserFlag
};//end set_ui



function ReponsiveListResize(){
	if(!IE7Flag){
		if($('.list').length > 0){
			var _i = 0;
			$('.list').each(function(){			
				ReponList[_i].setHeight();
				_i++;
			});
		}
	}
}


function ReponsiveList(_list){
	var _this = this;
	var $list = _list;
	var $items = $list.find( '.list__item__inner' );
	this.setHeight = function(){
		$items.css( 'height', 'auto' );
		var perRow = Math.floor( $list.width() / $items.width() );
		if( perRow == null || perRow < 2 ) return true;

		for( var i = 0, j = $items.length; i < j; i += perRow )
		{
			var maxHeight	= 0,
				$row		= $items.slice( i, i + perRow );

			$row.each( function()
			{
				var itemHeight = parseInt( $( this ).outerHeight() );
				if ( itemHeight > maxHeight ) maxHeight = itemHeight;
			});
			$row.css( 'height', maxHeight );
		}
	}
	_this.setHeight();
	$list.find( 'img' ).on( 'load', _this.setHeight );
}



function list_view(_t,_url){	
	view_slide = null;
	var __p =  $(_t);
	//$('#gallery_view').html('');
	if(!__p.hasClass('open')){
		//ajax 로드
		$.ajax({
			type:"post",
			dataType:"html",
			url:_url,
			cache: false,
			success: function(data)
			{
				$('#gallery_view').html(data);

				if(!AgentFlag){
					$('#gallery_view').stop(true).hide();
					var _link = $('#gallery_view').find('.btn_detail_view a').attr('href');
					location.href = _link;
				}else{
					__p.addClass('open').siblings().removeClass('open');
					$('#gallery_view').insertAfter(__p);
					var scrollTop = __p.offset().top - $('#header').find('.gnb').height();
					$('html,body').stop().animate({scrollTop:scrollTop},600,'easeOutExpo');		
					$('#gallery_view').hide().stop(true).fadeIn(300,function(){
						view_slide = $('.view_slide').bxSlider({
							controls:true,			
							pager:false,
							minSlides:1,
							maxSlides:1,			
							moveSlides:1,
							nextText:"<img src='/images/content/btn_slide_next02.png' width='47'>",
							prevText:"<img src='/images/content/btn_slide_prev02.png' width='47'>",
							infiniteLoop:false,
							hideControlOnEnd: true
						});	
						var _h = $('.view_visual').innerHeight();
						$('.view_visual').find('.cell').height(_h);
						$('.view_visual').find('.bx-wrapper').height(_h);
						$('.view_visual').find('.bx-viewport').height(_h);												
					});
				}				
			}
		});
	}else{
		__p.removeClass('open');
		$('#gallery_view').stop(true).fadeOut(200);
	}

}




function bottomAgreeOpen(){
	$('#footer').find('.agree_data').show();
}

function bottomAgreeClose(){
	$('#footer').find('.agree_data').hide();
}

/*스크랩Layer*/
function scrapLayerShow(){	
	$(".scrap").find(".info").show();
	setTimeout(function(){ $(".scrap").find(".info").hide(); },3000);
};

function onLike(board,bno,target){
	$.ajax({
		type:"post",
		dataType:"html",
		url:"/data/"+board+"/like/"+bno,
		cache: false,
		success: function(data)
		{
			$('#'+target).text(data);
		}
	});
}

function clipboard(text)
{
	var IE=(document.all)?true:false;
	if (IE)
	{
		window.clipboardData.setData('Text',text);
		alert("클립보드에 복사되었습니다.");
	}	
	else
	{
		temp = prompt("Ctrl+C를 눌러 복사하세요", text);
	}
}

$(function(){
	/*login label*/
	$(".logtxt").bind("focusin click", function(){							
		$(this).parent().find("label").addClass("hide");
	}).focusout(function(){
		if ( $(this).parent().find("input").val() == "" ) {			
			$(this).parent().find("label").removeClass("hide");
		}		
	});
});


function openTopSearch(){
	if($('.top_search').hasClass('open')){
		$('.top_search').removeClass('open');
		$('.top_search_wrap').hide();
	}else{
		$('.top_search').addClass('open');
		$('.top_search_wrap').show();
	}
}

//pop data remove
function popDataRemove(){
	$('#modalPopCon').find('> div > div').html('');
}

//pop Close
function popClose(){
	popDataRemove();
	$('html').removeClass('fix');
	$('#modalPopCon').stop(true).fadeOut(300);
}



function openPopVideo(_url,_id) {   
	popDataRemove();
	$('html').addClass('fix');
	$('#modalPopCon').stop(true).fadeIn(300);	
	$.ajax({
		url:_url,
		type: "post",
		success: function (result){						
			$('#modalPopCon').find('> div > div').html(result);		
			$('#m_p_player').find('iframe').attr('src', "http://www.youtube.com/embed/" + _id + "?wmode=opaque&rel=0&autoplay=1");
		},
		error: function (result) {
		}
	});
    //
}
