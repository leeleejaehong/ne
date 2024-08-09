package com.example.neoheulge.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.neoheulge.purproduct.service.PurproductService;

@Component
public class Scheduler {
	@Autowired
	private SqlSession sqlSession;

	
	@Autowired
	PurproductService purproductService;
	
    @Autowired
    private SchedulerService schedulerService;

    //추가금 넣기 
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실행
    public void schedulePayments() {
        try {
            List<Map<String, Object>> members = purproductService.getActiveAuto();
            if (members != null && !members.isEmpty()) {
                schedulerService.scheduleAutoPayments(members);
            } else {
                System.out.println("No active auto payments found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while scheduling payments: " + e.getMessage());
        }
    }
    
    //이자 계산 실행
    @Scheduled(cron = "0 0 0 1 * ?") // 매달 1일 0시에 실행
    public void applyMonthlyInterest() {
        try {
            List<Map<String, Object>> members = purproductService.getStatusY();
            if (members != null && !members.isEmpty()) {
                schedulerService.applyInterestRates(members);
            } else {
                System.out.println("No members found for interest calculation.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while applying monthly interest: " + e.getMessage());
        }
    }
    
    //상품 종료 업데이트
    @Scheduled(cron = "0 1 0 * * *") // 매일 12시 1분에 실행
    public void updateExpiredProductsStatus() {
        try {
            sqlSession.update("updateProductStatus");
            System.out.println("Expired products have been deactivated.");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while updating product statuses: " + e.getMessage());
        }
    }
    
    
    
}

/*
 * 첫 번째 * 부터 
 * 초(0-59) 
 * 분(0-59) 
 * 시간(0-23) 
 * 일(1-31) 
 * 월(1-12) 
 * 요일(0-6) (0: 일, 1: 월, 2:화, 3:수, 4:목, 5:금, 6:토)
 */
