package com.example.neoheulge.product.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.neoheulge.dto.NeSavProdDTO;
import com.example.neoheulge.product.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/product")
public class ProductController {

		@Autowired
		ProductService productService;
		
		@GetMapping("/dd.do")
		public String product(HttpServletRequest req,@RequestParam String product_code) {
			List<NeSavProdDTO> prodList = productService.selectProductByCode(product_code);
			req.setAttribute("product", prodList); 
			System.out.println(prodList);
			return "product/imsi";
		}

}
