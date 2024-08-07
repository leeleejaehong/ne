package com.example.neoheulge.product.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.neoheulge.product.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/Product")
public class ProductController {

		@Autowired
		ProductService productService;
		
		@GetMapping("/dd")
		public String product(HttpServletRequest req) {
			return "";
		}

}
