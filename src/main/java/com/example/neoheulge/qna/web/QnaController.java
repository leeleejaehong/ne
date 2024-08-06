package com.example.neoheulge.qna.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.neoheulge.dto.QnaDTO;
import com.example.neoheulge.qna.service.QnaService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@Autowired
	QnaService qnaService;
	
	@GetMapping("/qnaList.do")
	public String qnaList(HttpServletRequest req,@RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType) {
		int pageSize = 5; // 한 페이지당 보여줄 게시물 수
	    String pageNumStr = req.getParameter("pageNum"); // 현재 페이지 번호를 파라미터로 받아옴

	    int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr); // 현재 페이지 번호, 기본값은 1
		
		List<QnaDTO> list = qnaService.qnaList();
		int totalCount;
	    
	    if (search != null && !search.isEmpty()) {
	    	list = qnaService.searchQnaList(searchType, search);
            totalCount = list.size(); // 검색 결과의 전체 게시물 수
        } else {
            list = qnaService.qnaList();
            totalCount = list.size(); // 전체 게시물 수
        }
		
	    int start = (pageNum - 1) * pageSize;
	    int end = Math.min(start + pageSize, totalCount);
	    List<QnaDTO> paginatedList = list.subList(start, end);
	    
	    int pageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수
	    int pageBlock = 5; // 페이지 블록 사이즈
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
	    int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

	    req.setAttribute("count", totalCount);
	    req.setAttribute("qnaList", paginatedList); // 현재 페이지에 해당하는 게시판 목록
	    req.setAttribute("pageNum", pageNum); // 현재 페이지 번호
	    req.setAttribute("pageCount", pageCount); // 전체 페이지 수
	    req.setAttribute("startPage", startPage); // 시작 페이지 번호
	    req.setAttribute("endPage", endPage); // 끝 페이지 번호
	    req.setAttribute("search", search);
	    req.setAttribute("searchType", searchType);
		return "qna/qnaList";
	}
	
	@GetMapping("/qnaWrite.do")
	public String qnaWriteForm(HttpServletRequest req, 
			@RequestParam(value = "id", required = false, defaultValue = "0") Integer id) {
		
		 QnaDTO dto = new QnaDTO();
			if(id !=0) {
			 dto = qnaService.getQna(id);
			}else{
				dto.setId(0);
		        dto.setRe_step(0);
		        dto.setRe_level(0);
			}
			req.setAttribute("getQna",dto);
			return "qna/qnaWrite";
		
	}
	
	@PostMapping("/qnaWrite.do")
	public String qnaWrite(HttpServletRequest req, QnaDTO dto) {
		
		 if (dto.getId() == 0) {    // 새 글인 경우
			 qnaService.qnaNewSetp(dto.getId());
		        dto.setRe_step(0);
		        dto.setRe_level(0);
		    } else {                    // 답글인 경우
		    	qnaService.qnaReStep(dto.getRe_step());
		        dto.setRe_step(dto.getRe_step() + 1);
		        dto.setRe_level(dto.getRe_level() + 1);
		    }

		
		int res = qnaService.qnaWrite(dto);
		return "redirect:qnaList.do";
	}
	
	@GetMapping("/qnaContent.do")
	public String content(HttpServletRequest req, int id) {
		int res = qnaService.qnaViews(id);
		QnaDTO dto = qnaService.getQna(id);
		req.setAttribute("getQna",dto);

		return "qna/qnaContent";
	}
	
	@RequestMapping("/qnaDelete.do")
	public String qnaDelete(HttpServletRequest req, int id) {
		int res = qnaService.qnaDelete(id);
		return "redirect:qnaList.do";
	}

	@GetMapping("/qnaUpdate.do")
	public String qnaUpdateForm(HttpServletRequest req, int id) {
		QnaDTO dto = qnaService.getQna(id);
		req.setAttribute("getQna", dto);
		return "qna/qnaUpdate";
	}
	
	@PostMapping("/qnaUpdate.do")
	public String qnaUpdate(@ModelAttribute QnaDTO dto, BindingResult result) {
		if (result.hasErrors()) {	//만약에 dto객체를 만드는 중 오류가 발생했다면.. 
			//여기는 오류를 내가 알아서 해결하는 코드
			dto.setId(0);
		}
		int res = qnaService.qnaUpdate(dto);
		return "redirect:qnaList.do";

	}
}
