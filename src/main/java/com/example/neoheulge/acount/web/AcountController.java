package com.example.neoheulge.acount.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.neoheulge.acount.service.AcountService;
import com.example.neoheulge.dto.NeAcountDTO;
import com.example.neoheulge.dto.NePreSavProdDTO;
import com.example.neoheulge.product.service.ProductService;
import com.example.neoheulge.purproduct.service.PurproductService;

@Controller
@RequestMapping("/acount")
public class AcountController {
	@Autowired
	AcountService acountService;
	
	@Autowired
	PurproductService purproductService;
	
	@PostMapping("/add.do")
	public String addAcount(NeAcountDTO dto, NePreSavProdDTO pdto) {
		
		dto.setAcount_number("");
		dto.setMember_id("");
		dto.setAcount_status("");
		acountService.addAccount(dto);
		return "";
	}
}
