package com.oz.aptproject.web.controller.test;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oz.aptproject.web.service.ActionHelper;

@Controller
public class TestController extends ActionHelper{
	
	@RequestMapping("/test/reg")
	public String testReg(HttpServletRequest request, MultipartFile _file) {
		try {
			requestData(request);
			//reqPrms
			if (!_file.isEmpty()) {
					fileUpload(_file, reqPrms, request);
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "test"; 
	}

}
