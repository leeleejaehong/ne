package com.example.neoheulge.member.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.neoheulge.acount.service.AcountService;
import com.example.neoheulge.admin.service.AdminService;
import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeAcountDTO;
import com.example.neoheulge.dto.NePreSavProdDTO;
import com.example.neoheulge.member.service.MemberService;
import com.example.neoheulge.purproduct.service.PurproductService;
import com.example.neoheulge.util.SmsUtil;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private SmsUtil sms;
	
	@Autowired
	PurproductService purproductService;
	
	@Autowired
	AcountService acountService;
	
	@Autowired 
	private AdminService adminservice;
	
	@Autowired
	ServletContext servletcontext;
	
	@GetMapping("/login.do")
	public String login() {
        System.out.println("memberservice = " + memberservice);
		return "member/login";
	}
	
	@GetMapping("/signup.do")
	public String signup() {
		return "member/signup";
	}
	
	@PostMapping("/signupPro.do")
	public String signupPro(MemberDTO member,@RequestParam(name = "file", required = false)MultipartFile mf) {
		try {
	 String filename = mf.getOriginalFilename();
   	 String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
   	 String uniqueFilename = timeStamp + "_" + filename;

   	 String path = servletcontext.getRealPath("/img");
     File file = new File(path, uniqueFilename);
     mf.transferTo(file);
     member.setProfile(uniqueFilename);
		}catch (Exception e) {
            e.printStackTrace();
           }
		memberservice.signupPro(member);
		return "redirect:/";
	}
    
    @GetMapping("/findid.do")
    public String findId(HttpServletRequest req) {
    	return "member/findid";
    }
    
    @PostMapping("/findid.do")
    public String findIdPro(HttpServletRequest req,MemberDTO member) {
    	MemberDTO dto = memberservice.findByName(member.getName());
    	req.setAttribute("member", dto);
    	
    	return "member/findid_result";
    }
    @GetMapping("/myPage.do")
    public String myPage(HttpServletRequest req,NePreSavProdDTO dto,
    		@RequestParam String user) {
    	dto.setMember_id(user);
    	
    	List<Map<String, Object>> getByMemberId = purproductService.getByMemberId(dto);
    	req.setAttribute("getByMemberId", getByMemberId);
    	
    	List<NeAcountDTO> acount = acountService.getAccountsByMemberId(user);
    	req.setAttribute("acount", acount);
    	
    	return "member/myPage";
    }
    
    @ResponseBody
    @PostMapping("/subCrtifi.ajax")
    public ResponseEntity<?> sendSmsToFindEmail(@RequestParam("phone") String phone, HttpServletRequest req) {
        //수신번호 형태에 맞춰 "-"을 ""로 변환
        String phoneNum = phone.replaceAll("-","");
        Random rand = new Random();
        String randomNum = "";
        for (int i = 0; i < 4; i++) {
            String random = Integer.toString(rand.nextInt(10));
            randomNum += random;
        }        
        sms.sendOne(phoneNum, randomNum);
        Map<String, Object> response = new HashMap<>();
        response.put("check", randomNum.toString());
        
        return ResponseEntity.ok(response);
    }
    @GetMapping("/updatepw.do")
    public String updatepw() {
    	return "member/updatepw";
    }
    @PostMapping("/updatepw.do")
    public String updatepwView(HttpServletRequest req, MemberDTO member) {
    	MemberDTO dto = memberservice.findByIdName(member);
    	req.setAttribute("member", dto);
    	return "member/updatePro";
    }
    @PostMapping("/updatepwPro.do")
    public String updatePwPro(MemberDTO member) {
    	memberservice.updatePw(member);
    	return "redirect:/index.do";
    }
    
    
    
    @PostMapping("/mail.do")
    public String sendMail(String email,String id, HttpServletRequest req) {
        // 6자리 랜덤 숫자 생성
        Random rand = new Random();
        int randomNum = rand.nextInt(900000) + 100000;  // 100000(최소값)부터 999999(최대값) 사이의 숫자
        
        HttpSession session = req.getSession();

        // 세션에 랜덤 숫자 저장
        session.setAttribute("randomNum", randomNum);
        session.setAttribute("email",email);
        session.setAttribute("id",id);
        session.setAttribute("timestamp", System.currentTimeMillis()); // 현재 시간을 밀리초 단위로 저장


        // 이메일 전송
        acountService.sendSimpleEmail(email, "인증번호", "인증번호 : " + randomNum + "입니다.");
        return "checkMe";
    }
	
	
	

	
    @PostMapping("/confirmCheckNumber.do")
    public ResponseEntity<String> confirmCheckNumber(@RequestParam int checkNumber, HttpServletRequest req) {
    	HttpSession session = req.getSession();
        Integer sessionCheckNumber = (Integer) session.getAttribute("randomNum"); // Integer로 가져오기
        Long timestamp = (Long) session.getAttribute("timestamp"); // 타임스탬프 가져오기
        
        if (sessionCheckNumber == null || timestamp == null) {
            return new ResponseEntity<>("failure", HttpStatus.OK); // 인증번호나 타임스탬프가 없는 경우 실패
        }
        
        long currentTime = System.currentTimeMillis();
        long elapsedTime = currentTime - timestamp; // 현재 시간과 저장된 시간의 차이
        
        
        if (sessionCheckNumber == checkNumber) {
        	if (elapsedTime > 180000) { // 3분이 경과한 경우
        		return new ResponseEntity<>("over", HttpStatus.OK); // 인증번호가 만료됨
        	}else {
        		session.removeAttribute("randomNum");
                session.removeAttribute("timestamp");
        		return new ResponseEntity<>("success", HttpStatus.OK); // 인증 성공
        	}
        } else {
            return new ResponseEntity<>("failure", HttpStatus.OK); // 인증 실패
        }
        
    }
    
    @GetMapping("/editMemberForm.do")
    public String editUpdateForm(@RequestParam("memberID") String memberID, Model model) {
    	
    	MemberDTO mdto = adminservice.findMemberById(memberID);
    	model.addAttribute("member", mdto);
    	System.out.println("memberID: "+ mdto.getMemberID());
    	//   System.out.println("memberDATE:"+mdto.getSignup_date());
    	
    	return "member/editMemberForm"; // JSP 페이지 이름
    }
    
    @PostMapping("/editMemberPro.do")
    public String editMemberPro(@RequestParam(name = "file", required = false) MultipartFile mf,
    		@RequestParam("previousImg") String previousImg,@ModelAttribute MemberDTO dto, BindingResult result,  Model model) {
    	try { 
    		if (mf != null && !mf.isEmpty()) {
    			 String filename = mf.getOriginalFilename();
            	 String timeStamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
            	 String uniqueFilename = timeStamp + "_" + filename;
     
            	 String path = servletcontext.getRealPath("/img");
    	            File file = new File(path, uniqueFilename);
    	            mf.transferTo(file);
    				dto.setProfile(uniqueFilename); // 새 파일 이름으로 업데이트
    			} else {
    				// 새로운 이미지가 업로드되지 않은 경우 기존 이미지 파일명을 그대로 사용
               	 dto.setProfile(previousImg); 
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
    		model.addAttribute("url", "/member/editMemberForm.do?memberID=" + dto.getMemberID());//"/admin/updateMemberForm.do?memberID=" + dto.getMemberID());
    	} else {
    		System.out.println("업데이트 실패: res = " + res);
    		model.addAttribute("msg", "업데이트 실패");
    		model.addAttribute("url", "/member/editMemberForm.do?memberID=" + dto.getMemberID());//"/admin/updateMemberForm.do?memberID=" + dto.getMemberID());
    	}
    	return "message";
    	
    }
    
}
