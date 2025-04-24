package com.oz.aptproject.web.controller.om.um;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oz.aptproject.web.service.ActionHelper;
import com.oz.aptproject.web.service.IbatisHelper;


@Controller
public class OmUmController extends ActionHelper{
	
	@Autowired
	private IbatisHelper ibatisHelper;
	
	@RequestMapping("/om/um/010i")
	public String omUm010i() {
		return "/om/um/om_um_010i";
	}
	@RequestMapping("/om/um/020i")
	public String omUm020i() {
		return "/om/um/om_um_020i";
	}

	@RequestMapping("/om/um/020ins")
	public String omUm020ins(
			@RequestParam Map prms 
			) {
		prms.put("sql", "om.omum020ins");
		try {
			ibatisHelper.insert(prms);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/index";
	}
	
	@RequestMapping("/om/um/020p")
	public String omUm020p() {
		return "/om/um/om_um_020p";
	}	
}
