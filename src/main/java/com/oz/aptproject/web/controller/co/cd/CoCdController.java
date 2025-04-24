package com.oz.aptproject.web.controller.co.cd;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oz.aptproject.web.service.ActionHelper;

@Controller
public class CoCdController extends ActionHelper{

	@RequestMapping("/co/cd/010l")
	public String CoCd010l() {
		return "/co/cd/co_cd_010l";
	}
	
}
