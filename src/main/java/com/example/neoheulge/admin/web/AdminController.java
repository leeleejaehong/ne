package com.example.neoheulge.admin.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.neoheulge.admin.service.AdminDAO;
import com.example.neoheulge.admin.service.AdminService;
import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.util.UploadFile;


@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired 
	private AdminService adminservice;
	
	private UploadFile uploadFile;
	
    @GetMapping("/adminMember.do")
    public String adminMember() {
    	   
    	    return "admin/adminMember";
    	}
    @PostMapping("/searchMember.do")
    @ResponseBody
    public Map<String, Object> searchMember(
        @RequestParam(value = "searchType", defaultValue = "all") String searchType,
        @RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
        @RequestParam(value = "page", defaultValue = "1") int page, // 현재 페이지
        @RequestParam(value = "size", defaultValue = "5") int size  // 페이지 크기
    ) {
      
        int offset = (page - 1) * size;

      
        List<MemberDTO> members;
        if ("all".equals(searchType)) {
            members = adminservice.MemberAll(offset, size);
        } else {
            members = adminservice.searchMember(searchType, searchKeyword, offset, size);
        }
        

        int totalCount = adminservice.getTotalCount(searchType, searchKeyword);
        int totalPages = (int) Math.ceil((double) totalCount / size);
        Map<String, Object> response = new HashMap<>();
        response.put("members", members);
        response.put("totalPages", totalPages);
        response.put("currentPage", page);
        
        //System.out.println("totalPages:" + totalPages);
        return response;
    }
    @GetMapping("/updateMemberForm.do")
    public String showUpdateForm(@RequestParam("memberID") String memberID, Model model) {
      
        MemberDTO mdto = adminservice.findMemberById(memberID);
        model.addAttribute("member", mdto);
        System.out.println("memberID: "+ mdto.getMemberID());
     //   System.out.println("memberDATE:"+mdto.getSignup_date());
      
        return "admin/updateMemberForm"; // JSP 페이지 이름
    }
    
	
    @PostMapping("/updateMemberPro.do")
    public String updateMemberPro(@ModelAttribute MemberDTO dto, BindingResult result,  Model model) {
        UploadFile uploadFile = new UploadFile(); 
        try { 
            if (dto.getFile() != null) {
              if (uploadFile.uploadFile(dto.getFile())) {
                    dto.setProfile(uploadFile.getFullName()); // 새 파일 이름으로 업데이트
                } 
            }  
       } catch (Exception e) {
            e.printStackTrace();
           }
        if (result.hasErrors()) {
            System.out.println("BindingResult 오류");
           }
        
        int res = adminservice.updateMember(dto);
        if (res > 0) {
           model.addAttribute("msg", "업데이트 완료");
           model.addAttribute("url", "/admin/updateMemberForm.do?memberID=" + dto.getMemberID());//"/admin/updateMemberForm.do?memberID=" + dto.getMemberID());
        } else {
            System.out.println("업데이트 실패: res = " + res);
            model.addAttribute("msg", "업데이트 실패");
            model.addAttribute("url", "/admin/updateMemberForm.do?memberID=" + dto.getMemberID());//"/admin/updateMemberForm.do?memberID=" + dto.getMemberID());
        }
        return "message";
}
}