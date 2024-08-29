package com.example.neoheulge.payments.controller;


import com.example.neoheulge.acount.service.AcountService;
import com.example.neoheulge.dto.MemberDTO;
import com.example.neoheulge.dto.NeAcountDTO;
import com.example.neoheulge.member.service.MemberService;
import com.example.neoheulge.payments.config.TossPaymentConfig;
import com.example.neoheulge.payments.dto.PaymentFailDto;
import com.example.neoheulge.payments.dto.request.PaymentsRequestDTO;
import com.example.neoheulge.payments.dto.response.PaymentResponseDTO;
import com.example.neoheulge.payments.entity.Payments;
import com.example.neoheulge.payments.service.PaymentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@Validated
@RequestMapping("/api/v1/payments")
@RequiredArgsConstructor
public class TossPaymentController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	AcountService acountService;

    private final PaymentService paymentService;
    private final TossPaymentConfig tossPaymentConfig;

    //추후 @AuthenticationPrincipal 어노테이션 통해서 로그인 상태에서 결제 할 수 있게 보완 해야함
    @PostMapping("/toss")
    public ResponseEntity<PaymentResponseDTO> requestPayment(@RequestBody PaymentsRequestDTO request,HttpServletRequest req) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
        String Email = memberService.IdEmail(username);
        
        HttpSession session = req.getSession();
        String acountId = (String) session.getAttribute("acount_id");
        
        System.out.println("acount_id : "+acountId);
        
        PaymentResponseDTO paymentResDto = paymentService.createPaymentRequest(request.toEntity(), Email).toPaymentResDto();
        paymentResDto.setSuccessUrl(request.getMySuccessUrl() == null ? tossPaymentConfig.getSuccessUrl() : request.getMySuccessUrl());
        paymentResDto.setFailUrl(request.getMyFailUrl() == null ? tossPaymentConfig.getFailUrl() : request.getMyFailUrl());
        System.out.println("paymentResDto = " + paymentResDto.getPayType() + " " + paymentResDto.getAmount());
        return ResponseEntity.ok().body(paymentResDto);

    }
    
    @PostMapping("/confirm")
    public ResponseEntity<JSONObject> confirmPayment(@RequestBody Payments request,NeAcountDTO dto,HttpServletRequest req) {
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	JSONObject result = paymentService.confirmPayment(
                request.getPaymentKey(),
                request.getOrderId(),
                request.getAmount()
        );
        
        HttpSession session = req.getSession();
        String acountId = (String) session.getAttribute("acount_id");
        
        System.out.println("acount_id : "+acountId);

        dto.setAcount_id(acountId);
        dto.setMoney(request.getAmount());
        acountService.updateMoney(dto);
        result.put("username", username);
        
        
        System.out.println("dto = "+dto.getAcount_id()+"/22/"+dto.getMoney());
        System.out.println("result1 = " + result.toJSONString());
        
        
        return ResponseEntity.ok(result);
    }

    @PostMapping("/toss/fail")
    public ResponseEntity tossPaymentFail(
            @RequestParam String code,
            @RequestParam String message,
            @RequestParam String orderId
    ) {
        paymentService.tossPaymentFail(code, message, orderId);
        return ResponseEntity.ok().body(
                PaymentFailDto.builder()
                        .errorCode(code)
                        .errorMessage(message)
                        .orderId(orderId)
                        .build()
        );
    }
}
