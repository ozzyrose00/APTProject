package com.oz.aptproject.web.controller.cm.ai;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class CmAiController extends ActionHelper{
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/cm/ai/010i")
	public String cmAi010i(HttpServletRequest request, Model model) {
		requestData(request);
		String apt_id = reqPrms.get("_s_apt_id")+"";
		Map prms = new HashMap();
		prms.put("apt_id", apt_id);
		prms.put("sql", "cm.cmei010l");
		List cmei010lList = null;
		try {
			cmei010lList = ibatisHelper.selectList(prms);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("cmei010lList", cmei010lList);
		return "cm/ai/cm_ai_010i";
	}
	
	@RequestMapping("/cm/ai/010ins")
	public String cmAi010ins(@RequestParam Map map) {
		System.out.println("@");
		System.out.println("@");
		System.out.println("@");
		System.out.println("@");
		System.out.println("@");
		map.put("sql", "cm.cmai010ins");
		System.out.println("########################################");
		System.out.println(map.toString());
		System.out.println("########################################");
		try {
			ibatisHelper.insert(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/cm/ai/010l";
	}
	
	
	@RequestMapping("/cm/ai/010l")
	public String CmAi010l(@RequestParam Map prms,Model model,HttpServletRequest request) throws Exception {
		requestData(request);
		String apt_id = reqPrms.get("_s_apt_id")+"";
		Map map = new HashMap();
		map.put("apt_id", apt_id);
		map.put("sql", "cm.cmei010l");
		List cmei010lList = null;
		try {
			cmei010lList = ibatisHelper.selectList(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("cmei010lList", cmei010lList);
		return "cm/ai/cm_ai_010l";		
	}	
}
