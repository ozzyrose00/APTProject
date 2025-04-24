package com.oz.aptproject.web.controller.mm.sm;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.HttpClients;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.net.URLEncoder;

import java.io.File;
import java.nio.charset.Charset;
import java.util.*;
import java.io.InputStreamReader;
import java.io.BufferedReader;

@Controller
public class MmSmController {

	@RequestMapping("/mm/sm/sms_sendPage")
	public String MmSmSmsSend() {
		return "mm/sm/sms_sendPage";
	}
	
	@RequestMapping("/mm/sm/sms_send")
	public String MmSmSmsSend(@RequestParam Map prms) {
		
		try{
		
			String sms_receive_tel = prms.get("sms_receive_tel")+"";
			String sms_send_tel = prms.get("sms_send_tel")+"";
			String sms_content= prms.get("sms_content")+"";
			
			
			final String encodingType = "utf-8";
			final String boundary = "____boundary____";
			final String sms_user_id = "ozzyrose00";
			final String sms_user_key = "je03q3571c1xckod45lq56r61j0wb6k1";
			
			String sms_url = "https://apis.aligo.in/send/"; // 전송요청 URL
			
			Map<String, String> sms = new HashMap<String, String>();
			
			sms.put("user_id", sms_user_id); // SMS 아이디
			sms.put("key", sms_user_key); //인증키
			
			/******************** 인증정보 ********************/
			
			/******************** 전송정보 ********************/
			sms.put("msg", "%고객명%님. 안녕하세요. API TEST SEND"); // 메세지 내용
			sms.put("receiver", "01062702168,01062712168"); // 수신번호
			sms.put("destination", "01062702168|담당자,01062712168|홍길동"); // 수신인 %고객명% 치환
			sms.put("sender", "0442034476"); // 발신번호
			sms.put("rdate", ""); // 예약일자 - 20161004 : 2016-10-04일기준
			sms.put("rtime", ""); // 예약시간 - 1930 : 오후 7시30분
			sms.put("testmode_yn", "Y"); // Y 인경우 실제문자 전송X , 자동취소(환불) 처리
			sms.put("title", "알리고테스트"); //  LMS, MMS 제목 (미입력시 본문중 44Byte 또는 엔터 구분자 첫라인)
			
			String image = "";
			//image = "/tmp/pic_57f358af08cf7_sms_.jpg"; // MMS 이미지 파일 위치
			
			/******************** 전송정보 ********************/
			System.out.println("1");
			System.out.println("1");
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			
			builder.setBoundary(boundary);
			builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
			builder.setCharset(Charset.forName(encodingType));
			
			System.out.println("2");
			System.out.println("2");
			for(Iterator<String> i = sms.keySet().iterator(); i.hasNext();){
				String key = i.next();
				builder.addTextBody(key, sms.get(key)
						, ContentType.create("Multipart/related", encodingType));
			}	
			
			System.out.println("3");
			System.out.println("3");
			File imageFile = new File(image);
			if(image!=null && image.length()>0 && imageFile.exists()){
		
				builder.addPart("image",
						new FileBody(imageFile, ContentType.create("application/octet-stream"),
								URLEncoder.encode(imageFile.getName(), encodingType)));
			}
			
			HttpEntity entity = builder.build();
			
			HttpClient client = HttpClients.createDefault();
			HttpPost post = new HttpPost(sms_url);
			post.setEntity(entity);
			
			System.out.println("4");
			System.out.println("4");
			HttpResponse res = client.execute(post);
			
			String result = "";
			if(res != null){
				BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
				String buffer = null;
				while((buffer = in.readLine())!=null){
					result += buffer;
				}
				in.close();
			}			
			
			System.out.println("5");
			System.out.println("5");
			System.out.println(result);
		}catch(Exception e){
			e.getMessage();
		}		
		
		return "mm/sm/sms_send";
	}

	@RequestMapping("/mm/sm/sms_list")
	public String MmSmSmsList() {
		return "mm/sm/sms_send";
	}
		
}
