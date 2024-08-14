package com.example.neoheulge.admin.web;

import java.io.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.neoheulge.admin.service.AdminDAO;
import com.example.neoheulge.admin.service.AdminService;
import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeSavProdDTO;
import com.example.neoheulge.util.UploadFile;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;


@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final String DIRECTORY = "src/main/resources/static/notes/";
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
    @GetMapping("/adminProdcut.do")
    public String adminProd() {
    	return "admin/addProd";
    }
    
    @PostMapping("/addProdPro.do")
    public String addProdPro(@ModelAttribute NeSavProdDTO dto, BindingResult result, Model model) {
    	 UploadFile uploadFile = new UploadFile(); 
         try { 
             if (dto.getFile() != null) {
               if (uploadFile.uploadFile(dto.getFile())) {
                     dto.setProduct_image(uploadFile.getFullName()); // 새 파일 이름으로 업데이트
                 } 
             }  
        } catch (Exception e) {
             e.printStackTrace();
            }
        
        	 try { //3자리입력시 반올림
        	        if (dto.getBase_rate() != null) {
        	            dto.setBase_rate(dto.getBase_rate().setScale(2, RoundingMode.HALF_UP));
        	        }
        	        if (dto.getGoldenball_rate() != null) {
        	            dto.setGoldenball_rate(dto.getGoldenball_rate().setScale(2, RoundingMode.HALF_UP));
        	        }
					
        	        if (dto.getEarly_fee() != null) {
        	            dto.setEarly_fee(dto.getEarly_fee().setScale(2, RoundingMode.HALF_UP));
        	        }
        	        if (dto.getMaximum_deposit() != null) {
        	            dto.setMaximum_deposit(dto.getMaximum_deposit().setScale(2, RoundingMode.HALF_UP));
        	        }
        	        if (dto.getMinimum_deposit() != null) {
        	            dto.setMinimum_deposit(dto.getMinimum_deposit().setScale(2, RoundingMode.HALF_UP));
        	        }
        	        if (dto.getAccumulated_amount()==null || dto.getAccumulated_amount().equals("")) {
        	        	dto.setAccumulated_amount(null);
        	        }
        	    } catch (NumberFormatException e) {
        	        e.printStackTrace();
        	    }
         
         if (result.hasErrors()) {
        	 //System.out.println("date:" + dto.getStart_date());
             System.out.println("BindingResult 오류");
            }
        int res = adminservice.addProd(dto); 
       
        if (res > 0) {
            model.addAttribute("msg", "상품추가 완료");
            model.addAttribute("url", "/");
         } else {
        	 model.addAttribute("msg", "상품추가 실패");
             model.addAttribute("url", "/");
         }
        return "message";
    }
    @GetMapping("/updateProd.do")
    public String updateProd(Model model) {
    	List<NeSavProdDTO> prodList=adminservice.prodList();
    	System.out.println("prodList="+prodList);
    	model.addAttribute("prodList", prodList);
    	return "admin/prodList";
    }
    @PostMapping("/updateProdPro.do")
    public String updateProdPro(@RequestParam ("product_code")String product_code,Model model) {
    	NeSavProdDTO PDTO = adminservice.prodInfo(product_code);
    	model.addAttribute("PDTO", PDTO);
    	return "admin/updateProd";
    }
    @PostMapping("/updateProdOk.do")
    public String updateProdOk(@ModelAttribute NeSavProdDTO dto, BindingResult result, Model model) {
    	 UploadFile uploadFile = new UploadFile(); 
         try { 
             if (dto.getFile() != null) {
               if (uploadFile.uploadFile(dto.getFile())) {
                     dto.setProduct_image(uploadFile.getFullName()); // 새 파일 이름으로 업데이트
                 } 
             }  
        } catch (Exception e) {
             e.printStackTrace();
            }
         if (result.hasErrors()) {
        	 //System.out.println("date:" + dto.getStart_date());
             System.out.println("BindingResult 오류");
            }
        int res=adminservice.updateProd(dto); 
        if (res > 0) {
            model.addAttribute("msg", "상품수정 완료");
            model.addAttribute("url",  "/admin/updateProd.do");
         } else {
        	 model.addAttribute("msg", "상품수정 실패");
             model.addAttribute("url", "/admin/updateProd.do");
         }
        return "message";
    }
    @PostMapping("/deleteProd.do")
    public String deleteProd(@RequestParam("product_code") String product_code, Model model) {
    	int res = adminservice.deleteProd(product_code);
    	 if (res > 0) {
             model.addAttribute("msg", "상품삭제 완료");
             model.addAttribute("url",  "/admin/updateProd.do");
          } else {
         	 model.addAttribute("msg", "상품삭제 실패");
              model.addAttribute("url", "/admin/updateProd.do");
          }
         return "message";
    }
    
    @GetMapping("/adminChart.do")
    public String adminChart(Model model) {
    	List<NeSavProdDTO> nList = adminservice.prodList();
    	model.addAttribute("nList", nList);
    	return "admin/adminChart";
    }
    @ResponseBody
    @RequestMapping(value="/chartajax.do",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
    public String chartAjax(String product_code) {
    	List<NeSavProdDTO> NeList= adminservice.chartList(product_code);
    	Gson gson = new Gson();
		JsonArray jarray = new JsonArray();
		System.out.println("prodcutcode:"+ product_code);
		Iterator <NeSavProdDTO>it = NeList.iterator();
		while(it.hasNext()) {
			NeSavProdDTO ndto = it.next();
			JsonObject jObject = new JsonObject();
			BigDecimal accumulated_amount = ndto.getAccumulated_amount();
			String product_code1 = ndto.getProduct_code();
			int numberOfSubscribers = ndto.getNumberOfSubscribers();
			jObject.addProperty("accumulated_amount",accumulated_amount);
			jObject.addProperty("number_of_subscribers", numberOfSubscribers);
			jObject.addProperty("product_code", product_code1);
			jarray.add(jObject);
			System.out.println("accumulated_amount="+ accumulated_amount);
			System.out.println("number_of_subscribers="+ numberOfSubscribers);
			System.out.println("prodcut_code="+product_code1);
		}
		String json = gson.toJson(jarray);
		
		return json;
    }
    @GetMapping("/calTest.do")
    public String calTest(Model model) {
    	 File folder = new File(DIRECTORY);
         File[] files = folder.listFiles();
         model.addAttribute("files", files != null ? files : new File[0]);
    	return "admin/CalTest";
    }
    @RequestMapping("/calculator.do")
    public String calculate(@RequestParam("display") String display, Model model) {
    	 String result;
    	    try {
    	        if (display != null && !display.isEmpty()) {
    	            String cleanedExpression = display.replaceAll("\\s+", "");
    	            result = evaluateExpression(cleanedExpression);
    	        } else {
    	            result = "";
    	        }
    	    } catch (Exception e) {
    	        e.printStackTrace(); 
    	        result = "Error";
    	    }
    	    model.addAttribute("display", display);
    	    model.addAttribute("result", result);
    	    return "admin/CalTest"; 
    	}

    	private String evaluateExpression(String expression) {
    	    ScriptEngineManager mgr = new ScriptEngineManager();
    	    ScriptEngine engine = mgr.getEngineByName("JavaScript");

    	    try {
    	        Object result = engine.eval(expression);
    	        return result.toString();
    	    } catch (ScriptException e) {
    	        return "Error";
    	    }
    	}

    	@PostMapping("/saveNote.do")
        public String saveNote(@RequestParam("note") String note) {
            if (note != null && !note.trim().isEmpty()) {
                File dir = new File(DIRECTORY);
                if (!dir.exists()) dir.mkdirs();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String dateTime = dateFormat.format(new Date());
                // 번호를 찾기 위한 패턴
                Pattern pattern = Pattern.compile("^note_(\\d+)_(" + dateTime + ")\\.txt$");
                File[] existingFiles = dir.listFiles((d, name) -> pattern.matcher(name).matches());
                //가장큰수찾아서 +1해서 새파일이름 설정함
                int maxNumber = 0; 
                if (existingFiles != null) {
                    for (File file : existingFiles) {
                        Matcher matcher = pattern.matcher(file.getName());
                        if (matcher.matches()) {
                            int number = Integer.parseInt(matcher.group(1));
                            maxNumber = Math.max(maxNumber, number);
                        }
                    }
                }
                int nextNumber = maxNumber + 1;
                
                String fileName = "note_" + nextNumber + "_" + dateTime + ".txt";
                // 저장할 파일 객체
                File fileToSave = new File(dir, fileName); 
                try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileToSave), "UTF-8"))) {
                    writer.write(note);
                } catch (IOException e) {
                    e.printStackTrace();
                    System.out.println("파일생성/입력중 오류발생");
                }
            }
            return "redirect:/admin/calTest.do";
        }
    	
        @PostMapping("/updateNote.do")
        public String updateNote(@RequestParam("fileName") String fileName, @RequestParam("note") String note) {
            File file = new File(DIRECTORY, fileName);
            if (file.exists() && note != null && !note.trim().isEmpty()) {
                try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"))) {
                    writer.write(note);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return "redirect:/admin/calTest.do";
        }

        @PostMapping("/deleteNote.do")
        public String deleteNote(@RequestParam("fileName") String fileName) {
            File file = new File(DIRECTORY, fileName);
            if (file.exists()) {
                file.delete();
            }
            return "redirect:/admin/calTest.do";
        }

        @GetMapping("/viewNote.do")
        public String viewNote(@RequestParam("fileName") String fileName, Model model) {
            File file = new File(DIRECTORY, fileName);
            if (file.exists()) {
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"))) {
                    StringBuilder content = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        content.append(line).append("\n");
                        //readLine은 한줄씩읽어오기때문에 줄개행해줘야함!
                    }
                    model.addAttribute("content", content.toString());
                    model.addAttribute("fileName", fileName);
                    return "admin/viewNote";
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            return "redirect:/admin/calTest.do";
        }
        @GetMapping("/adminPage.do")
    	public String adminPage() {
    		return "admin/adminPage";
    	} 	
    }

    	

