package com.oz.aptproject.web.controller.aa.ar;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;

@Controller
public class AaArController extends ActionHelper{
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/aa/ar/010l")
	public String aaAr010l(Model model) throws Exception {
		Map prms = new HashMap(); 
		prms.put("sql", "test.comclacdLst");
		prms.put("com_cla_cd", "A3");
		List comClaCdLst = comClaCdLst(prms); 
		model.addAttribute("comClaCdLst", comClaCdLst);
		return "aa/ar/aa_ar_010l";
	}	

	@RequestMapping("/aa/ar/010i")
	public String aaAr010i(Model model) throws Exception {
		Map prms = new HashMap(); 
		prms.put("sql", "test.comclacdLst");
		prms.put("com_cla_cd", "A3");
		List comClaCdLst = comClaCdLst(prms); 
		model.addAttribute("comClaCdLst", comClaCdLst);
		return "aa/ar/aa_ar_010i";
	}
	
	@RequestMapping("/aa/ar/010ins")
	public String aaAr010ins(@RequestParam Map map) {
		System.out.println(map.toString());
		mapKeyValueStr(map);
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		try {
			map.put("sql","aa.aaar010_1d");
			IbatisHelper.delete(map);
			map.put("sql","aa.aaar010ins");
			ibatisHelper.insert(map);
			map.put("sql","aa.aaar010hins");
			ibatisHelper.insert(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/aa/ar/010l";
	}
}
