package com.oz.aptproject.web.controller.cm.ei;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;

import java.util.*;

@Controller
public class CmEiController extends ActionHelper{
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/cm/ei/010i")
	public String cmEi010i(Model model) throws Exception {
		Map prms = new HashMap();
		prms.put("sql", "test.comclacdLst");
		prms.put("com_cla_cd", "A1");
		List com_A1_list = (ArrayList)ibatisHelper.selectList(prms);
		System.out.println("서버 com_A1_list ::::"+com_A1_list.size());
		model.addAttribute("com_A1_list", com_A1_list);
		return "cm/ei/cm_ei_010i";
	}
	
	@RequestMapping("/cm/ei/010ins")
	public String CmEi010ins(@RequestParam Map prms) throws Exception {
		prms.put("sql", "cm.cmei010ins");
		ibatisHelper.insert(prms);
		return "redirect:/cm/ei/010l";
	}
	
	@RequestMapping("/cm/ei/010l")
	public String CmEi010l(@RequestParam Map prms,Model model) throws Exception {
		Map cdprms = new HashMap();
		cdprms.put("sql", "test.comclacdLst");
		cdprms.put("com_cla_cd", "A1");
		List com_A1_list = (ArrayList)ibatisHelper.selectList(cdprms);
		System.out.println("서버 com_A1_list ::::"+com_A1_list.size());
		model.addAttribute("com_A1_list", com_A1_list);
		return "cm/ei/cm_ei_010l";		
	}
}
