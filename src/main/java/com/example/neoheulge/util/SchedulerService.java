package com.example.neoheulge.util;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.neoheulge.purproduct.service.PurproductService;

@Service
public class SchedulerService {

    @Autowired
    private PurproductService purproductService;

    public void scheduleAutoPayments(List<Map<String, Object>> members) {
        LocalDate today = LocalDate.now();
        for (Map<String, Object> member : members) {
            String autoCycle = (String) member.get("AUTO_CYCLE");
            String autoDateStr = (String) member.get("AUTO_DATE"); // 사용자 입력 날짜 (예: "17")
            
            // 날짜를 정수로 변환
            int autoDateDay = Integer.parseInt(autoDateStr);

            if (shouldProcessPayment(today, autoDateDay, autoCycle)) {
                processPayment(member);
            }
        }
    }

    public boolean shouldProcessPayment(LocalDate today, int autoDateDay, String autoCycle) {
        switch (autoCycle) {
            case "매일":
                return true; // 매일 실행되므로 항상 true
            case "매주":
                DayOfWeek autoDateDayOfWeek = LocalDate.of(today.getYear(), today.getMonth(), autoDateDay).getDayOfWeek();
                return today.getDayOfWeek().equals(autoDateDayOfWeek); // 오늘 요일과 자동 결제 요일이 같은지 확인
            case "매달":
                return today.getDayOfMonth() == autoDateDay; // 현재 일이 자동 결제 설정일과 같을 때
            default:
                return false;
        }
    }


    public void processPayment(Map<String, Object> member) {
        // 결제 처리 로직
    	double autoAmount = ((Number) member.get("AUTO_AMOUNT")).doubleValue();
        String autoCycle = (String) member.get("AUTO_CYCLE");
        double additionalAmount = 0;
        
        switch (autoCycle) {
	        case "매일":
	            additionalAmount = autoAmount;
	            System.out.println("추가금 넣기 실행: " + autoAmount);
	            break;
	        case "매주":
	            additionalAmount = autoAmount;
	            System.out.println("추가금 넣기 실행: " + autoAmount);
	            break;
	        case "매달":
	            additionalAmount = autoAmount;
	            System.out.println("추가금 넣기 실행: " + autoAmount);
	            break;
	    }
        
        if (additionalAmount > 0) {
            Map<String, Object> params = new HashMap<>();
            params.put("member_id", member.get("MEMBER_ID"));
            params.put("product_code", member.get("PRODUCT_CODE"));
            params.put("additionalAmount", additionalAmount);

            System.out.println("추가금 넣기 실행: " + params);
            purproductService.addAdditionalAmount(params);

        }
        
        //결제 처리 로그 
        System.out.println("Processing payment for: " + member);
    }
    
    //이자계산
    public void applyInterestRates(List<Map<String, Object>> members) {
        for (Map<String, Object> member : members) {
            Map<String, Object> params = new HashMap<>();
            params.put("memberId", member.get("MEMBER_ID"));
            params.put("productCode", member.get("PRODUCT_CODE"));

            String subscriptionSelect = (String) member.get("SUBSCRIPTION_SELECT");
            if ("골든볼".equals(subscriptionSelect)) {
                purproductService.applyGoldenBallRate(params);
            } else if ("기본".equals(subscriptionSelect)) {
                purproductService.applyBaseRate(params);
            }

            // 이자 계산 처리 로그
            System.out.println("Applied interest for: " + member);
        }
    }
    
    
}