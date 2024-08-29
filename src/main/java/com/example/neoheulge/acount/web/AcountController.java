package com.example.neoheulge.acount.web;

import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeAcountDTO;
import com.example.neoheulge.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;

import com.example.neoheulge.acount.service.AcountService;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@RequestMapping("/acount")
public class AcountController {

	@Autowired
	private AcountService acountService;
	
	@Autowired
	private MemberService memberService;

	@PostMapping("/insertNeacount.do")
	public String addAccount(NeAcountDTO dto) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		System.out.println("39: "+dto.getAcount_status()+", 333 "+dto.getMember_id());
		if("Y".equals(dto.getAcount_status())) {
			acountService.updateAllAccountsToNonPrimary(dto.getMember_id());
		}
		acountService.addAccount(dto);

		return "redirect:/member/myPage.do?user=" + username;
	}

	@GetMapping("/insertNeacountform.do")
	public String addAccountForm() {
		return "member/acount";
	}

	@PostMapping("/deleteNeacount.do")
	public String deleteAccount(@RequestParam("acount_id") String acountId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();

		NeAcountDTO dto = new NeAcountDTO();
		dto.setAcount_id(acountId);

		acountService.removeAccount(dto);

		return "redirect:/member/myPage.do?user=" + username;
	}

	@GetMapping("/add.do")
	public String addAccount(HttpServletRequest req,@RequestParam String member) {
		String email = memberService.IdEmail(member);
		req.setAttribute("id", member);
		req.setAttribute("mail", email);
		return "checkMe";
	}
	
	@PostMapping("/changeMainAccount.do")
    @ResponseBody
    public Map<String, Object> changeMainAccount(@RequestBody Map<String, Object> request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        int accountId = (int) request.get("accountId");

        boolean isUpdated = acountService.changeMainAccount(username, accountId);

        System.out.println("1. "+username+" 2. "+accountId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", isUpdated);

        return response;
    }

}
