package com.example.neoheulge;

import java.util.List;

import com.example.neoheulge.dto.NoticeDTO;
import com.example.neoheulge.notice.service.NoticeService;
import com.example.neoheulge.product.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.neoheulge.commu.service.CommuService;
import com.example.neoheulge.dto.CommuDTO;
import com.example.neoheulge.dto.NeSavProdDTO;

import jakarta.servlet.http.HttpServletRequest;



@Controller
public class HomeController {

	@Autowired
	CommuService commuService;
	
    @Autowired
    private NoticeService noticeService;
    
    @Autowired
    ProductService productService;

	@GetMapping(value = {"/", "/index.do"})
	public String home(HttpServletRequest req) {
		
		List<NoticeDTO> noticelist = noticeService.noticeList();
		req.setAttribute("noticeList", noticelist);
		
		List<CommuDTO> commulist = commuService.commuList();
		req.setAttribute("commuList", commulist);
		
		List<NeSavProdDTO> prodList = productService.selectAllProducts();
		req.setAttribute("prodList", prodList);
		
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        String username = authentication.getName();
//        System.out.println(username);

		boolean hasNotice = !noticelist.isEmpty();
		req.setAttribute("hasNotice", hasNotice);

		// 가장 최근 공지사항 정보 전달 (있는 경우)
		if (hasNotice) {
			req.setAttribute("latestNotice", noticelist.get(0));
		}

		return "index";
	}

	@GetMapping("/viewNotice.do")
	public String content(HttpServletRequest req) {
		NoticeDTO dto = noticeService.lastNotice();
		req.setAttribute("getNotice",dto);
		return "viewNotice";
	}

}
