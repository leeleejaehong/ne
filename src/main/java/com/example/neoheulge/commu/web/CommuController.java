package com.example.neoheulge.commu.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.neoheulge.commu.service.CommuService;
import com.example.neoheulge.dto.CommuDTO;
import com.example.neoheulge.dto.NoticeDTO;
import com.example.neoheulge.notice.service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/commu")
public class CommuController {

	@Autowired
	CommuService commuService;
	@Autowired
    private NoticeService noticeService;
	
	
	@GetMapping("/commuList.do")
	public String commuList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType) {
		
		int pageSize = 5; // 한 페이지당 보여줄 게시물 수
	    String pageNumStr = req.getParameter("pageNum"); // 현재 페이지 번호를 파라미터로 받아옴

	    int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr); // 현재 페이지 번호, 기본값은 1
	    
	    List<CommuDTO> list = commuService.commuList();
	    int totalCount;
	    
	    if (search != null && !search.isEmpty()) {
	    	list = commuService.searchCommuList(searchType, search);
            totalCount = list.size(); // 검색 결과의 전체 게시물 수
        } else {
            list = commuService.commuList();
            totalCount = list.size(); // 전체 게시물 수
        }
		
	    int start = (pageNum - 1) * pageSize;
	    int end = Math.min(start + pageSize, totalCount);
	    List<CommuDTO> paginatedList = list.subList(start, end);
	    
	    int pageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수
	    int pageBlock = 5; // 페이지 블록 사이즈
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
	    int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

	    
		List<NoticeDTO> noticelist = noticeService.noticeList();
		req.setAttribute("noticeList", noticelist);
	    
	    // 결과를 request에 저장
	    req.setAttribute("count", totalCount);
	    req.setAttribute("commuList", paginatedList); // 현재 페이지에 해당하는 게시판 목록
	    req.setAttribute("pageNum", pageNum); // 현재 페이지 번호
	    req.setAttribute("pageCount", pageCount); // 전체 페이지 수
	    req.setAttribute("startPage", startPage); // 시작 페이지 번호
	    req.setAttribute("endPage", endPage); // 끝 페이지 번호
	    req.setAttribute("search", search);
	    req.setAttribute("searchType", searchType);
		return "commu/commuList";
	}
	
	@GetMapping("/commuWrite.do")
	public String commuWriteForm(HttpServletRequest req, 
			@RequestParam(value = "id", required = false, defaultValue = "0") Integer id) {
		
		 CommuDTO dto = new CommuDTO();
			if(id !=0) {
			 dto = commuService.getCommu(id);
			}else{
				dto.setId(0);
		        dto.setRe_step(0);
		        dto.setRe_level(0);
			}
			
			List<NoticeDTO> noticelist = noticeService.noticeList();
			req.setAttribute("noticeList", noticelist);
			
			List<CommuDTO> commulist = commuService.commuList();
			req.setAttribute("commuList", commulist);
			
			req.setAttribute("getCommu",dto);
			return "commu/commuWrite";
		
	}
	
	@PostMapping("/commuWrite.do")
	public String commuWrite(HttpServletRequest req, CommuDTO dto) {
		
		 if (dto.getId() == 0) {    // 새 글인 경우
			 commuService.commuNewSetp(dto.getId());
		        dto.setRe_step(0);
		        dto.setRe_level(0);
		    } else {                    // 답글인 경우
		    	commuService.commuReStep(dto.getRe_step());
		        dto.setRe_step(dto.getRe_step() + 1);
		        dto.setRe_level(dto.getRe_level() + 1);
		    }

		
		int res = commuService.commuWrite(dto);
		return "redirect:commuList.do";
	}
	
	@GetMapping("/commuContent.do")
	public String content(HttpServletRequest req, int id) {
		int res = commuService.commuViews(id);
		CommuDTO dto = commuService.getCommu(id);
		req.setAttribute("getCommu",dto);
		
		List<NoticeDTO> noticelist = noticeService.noticeList();
		req.setAttribute("noticeList", noticelist);
		
		List<CommuDTO> commulist = commuService.commuList();
		req.setAttribute("commuList", commulist);

		return "commu/commuContent";
	}
	
	@RequestMapping("/commuDelete.do")
	public String commuDelete(HttpServletRequest req, int id) {
		int res = commuService.commuDelete(id);
		return "redirect:commuList.do";
	}

	@GetMapping("/commuUpdate.do")
	public String commuUpdateForm(HttpServletRequest req, int id) {
		CommuDTO dto = commuService.getCommu(id);
		req.setAttribute("getCommu", dto);
		
		List<NoticeDTO> noticelist = noticeService.noticeList();
		req.setAttribute("noticeList", noticelist);
		
		List<CommuDTO> commulist = commuService.commuList();
		req.setAttribute("commuList", commulist);
		return "commu/commuUpdate";
	}
	
	@PostMapping("/commuUpdate.do")
	public String commuUpdate(@ModelAttribute CommuDTO dto, BindingResult result) {
		if (result.hasErrors()) {	//만약에 dto객체를 만드는 중 오류가 발생했다면.. 
			//여기는 오류를 내가 알아서 해결하는 코드
			dto.setId(0);
		}
		int res = commuService.commuUpdate(dto);
		return "redirect:commuList.do";

	}
}
