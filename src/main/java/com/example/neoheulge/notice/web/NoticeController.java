package com.example.neoheulge.notice.web;

import com.example.neoheulge.dto.CommuDTO;
import com.example.neoheulge.dto.NoticeDTO;
import com.example.neoheulge.notice.service.NoticeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @GetMapping("/noticeList.do")
    public String noticeList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search,
                            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType) {

        int pageSize = 5; // 한 페이지당 보여줄 게시물 수
        String pageNumStr = req.getParameter("pageNum"); // 현재 페이지 번호를 파라미터로 받아옴

        int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr); // 현재 페이지 번호, 기본값은 1

        List<NoticeDTO> list = noticeService.noticeList();
        int totalCount;

        if (search != null && !search.isEmpty()) {
            list = noticeService.searchNoticeList(searchType, search);
            totalCount = list.size(); // 검색 결과의 전체 게시물 수
        } else {
            list = noticeService.noticeList();
            totalCount = list.size(); // 전체 게시물 수
        }

        int start = (pageNum - 1) * pageSize;
        int end = Math.min(start + pageSize, totalCount);
        List<NoticeDTO> paginatedList = list.subList(start, end);

        int pageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수
        int pageBlock = 5; // 페이지 블록 사이즈
        int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
        int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

        // 결과를 request에 저장
        req.setAttribute("count", totalCount);
        req.setAttribute("noticeList", paginatedList); // 현재 페이지에 해당하는 게시판 목록
        req.setAttribute("pageNum", pageNum); // 현재 페이지 번호
        req.setAttribute("pageCount", pageCount); // 전체 페이지 수
        req.setAttribute("startPage", startPage); // 시작 페이지 번호
        req.setAttribute("endPage", endPage); // 끝 페이지 번호
        req.setAttribute("search", search);
        req.setAttribute("searchType", searchType);
        return "notice/noticeList";
    }
    @GetMapping("/noticeInsert.do")
    public String noticeInsertForm(HttpServletRequest req,
                                 @RequestParam(value = "id", required = false, defaultValue = "0") Integer id) {

        NoticeDTO dto = new NoticeDTO();
        if(id !=0) {
            dto = noticeService.getNotice(id);
        }
        req.setAttribute("getNotice",dto);
        return "notice/notice";
    }
    @PostMapping("/noticeInsert.do")
    public String noticeInsert(HttpServletRequest req, NoticeDTO dto) {

        if (dto.getId() == 0) {    // 새 글인 경우
        }
        int res = noticeService.noticeInsert(dto);
        return "redirect:noticeList.do";
    }
    @GetMapping("/noticeView.do")
    public String content(HttpServletRequest req, int id) {
        int res = noticeService.noticeViews(id);
        NoticeDTO dto = noticeService.getNotice(id);
        req.setAttribute("getNotice",dto);

        return "notice/noticeView";
    }

    @RequestMapping("/noticeDelete.do")
    public String noticeDelete(HttpServletRequest req, int id) {
        int res = noticeService.noticeDelete(id);
        return "redirect:noticeList.do";
    }
    @GetMapping("/noticeEdit.do")
    public String NoticeEditForm(HttpServletRequest req, int id) {
        NoticeDTO dto = noticeService.getNotice(id);
        req.setAttribute("getNotice", dto);
        return "notice/noticeEdit";
    }

    @PostMapping("/noticeEdit.do")
    public String noticeEdit(@ModelAttribute NoticeDTO dto, BindingResult result) {
        if (result.hasErrors()) {
            dto.setId(0);
        }
        int res = noticeService.noticeEdit(dto);
        return "redirect:noticeList.do";

    }
}
