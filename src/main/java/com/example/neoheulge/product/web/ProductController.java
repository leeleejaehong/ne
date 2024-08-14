package com.example.neoheulge.product.web;

import java.util.List;

import com.example.neoheulge.commu.service.CommuService;
import com.example.neoheulge.dto.CommuDTO;
import com.example.neoheulge.dto.NoticeDTO;
import com.example.neoheulge.notice.service.NoticeService;
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

		@Autowired
		CommuService commuService;

		@Autowired
		private NoticeService noticeService;
		
		@GetMapping("/productDetail.do")
		public String product(HttpServletRequest req,@RequestParam String product_code) {
			NeSavProdDTO prod = productService.selectProductByCode(product_code);
			req.setAttribute("product", prod); 
			System.out.println(prod);
			return "product/productDetail";
		}
		
		@GetMapping("/productList.do")
		public String productList(HttpServletRequest req) {
			List<NeSavProdDTO> prodList = productService.selectAllProducts();
			req.setAttribute("product", prodList);
			List<NoticeDTO> noticelist = noticeService.noticeList();
			req.setAttribute("noticeList", noticelist);

			List<CommuDTO> commulist = commuService.commuList();
			req.setAttribute("commuList", commulist);
			return "product/productList";
		}

}
