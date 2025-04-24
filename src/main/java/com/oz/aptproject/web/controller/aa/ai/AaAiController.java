package com.oz.aptproject.web.controller.aa.ai;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;

@Controller
public class AaAiController extends ActionHelper{
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/aa/ai/010i")
	public String aaAi010i() {  
		return "aa/ai/aa_ai_010i";
	}
	@RequestMapping("/aa/ai/011i")
	public String aaAi011i(@RequestParam Map prms) {
		System.out.println(prms.get("apt_nm")+"");
		prms.put("sql","aa.aaAi011i");
		try {
			ibatisHelper.insert(prms);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/aa/ai/010l";
	}
	@RequestMapping("/aa/ai/010p")
	public String aaAi010p() {  
		return "aa/ai/aa_ai_010p";
	}
	
	
	@RequestMapping("/aa/ai/010l")
	public String aaAi010l() {  
		return "aa/ai/aa_ai_010l";
	}
	
	
}
