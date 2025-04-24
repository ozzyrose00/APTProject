package com.oz.aptproject.web.controller.sc.he;

import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;

@Controller
public class ScHeController extends ActionHelper{
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/sc/he/010l")
	public String scHe010l(Model model) throws Exception {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String sch_start_dt = sdf.format(today);
		String sch_end_dt = sdf.format(today);
		Map prms = new HashMap();
		prms.put("sch_start_dt", sch_start_dt);
		prms.put("sch_end_dt", sch_end_dt);
		System.out.println("sch_start_dt::::::"+sch_start_dt);
		prms.put("sql", "sc.sche010l");
		List sche010List = (ArrayList)ibatisHelper.selectList(prms);
		model.addAttribute("sche010List", sche010List);
		return "sc/he/sc_he_010l";
	}
	
	@RequestMapping("/sc/he/010ins")
	public String scHe010ins(@RequestParam Map prms) throws Exception {
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(prms.toString());
		System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!");
		prms.put("sql","sc.sche010ins");
		ibatisHelper.insert(prms);
		return "redirect:/sc/he/010l";
	}
	
	@RequestMapping("/sc/he/010d")
	public String scHe010d(@RequestParam Map prms) throws Exception {
		prms.put("sql","sc.sche010d");
		ibatisHelper.delete(prms);
		return "redirect:/sc/he/010l";
	}

	@RequestMapping("/sc/he/010u")
	public String scHe010u(@RequestParam Map prms) throws Exception {
		prms.put("sql","sc.sche010u");
		ibatisHelper.update(prms);
		return "redirect:/sc/he/010l";
	}

}
