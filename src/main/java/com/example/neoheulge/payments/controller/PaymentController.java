package com.example.neoheulge.payments.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @PostMapping("/payment.do")
    public String payment(String acount_id,HttpServletRequest req) {
    	String acountId = req.getParameter("acount_id");
        System.out.println("acountId = " + acountId);

        // 세션에 저장
        HttpSession session = req.getSession();
        session.setAttribute("acount_id", acountId);
        return "payments/payment";
    }
}
