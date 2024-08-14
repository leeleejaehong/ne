package com.example.neoheulge.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.neoheulge.admin.service.AdminDAO;
import com.example.neoheulge.product.service.ProductService;
import com.example.neoheulge.purproduct.service.PurproductService;

@Component
public class Scheduler {
	@Autowired
	private SqlSession sqlSession;

	
	@Autowired
	PurproductService purproductService;
	
	@Autowired
	ProductService productService;
	
    @Autowired
    private SchedulerService schedulerService;
    @Autowired
    private AdminDAO admindao;

  
    //추가금 넣기(완료)
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실행 (cron = "0/1 * * * * *")(cron = "0 0 0 * * *")
    public void schedulePayments() {
        try {
            List<Map<String, Object>> members = purproductService.getActiveAuto();
            if (members != null && !members.isEmpty()) {
                schedulerService.scheduleAutoPayments(members);
                for (Map<String, Object> member : members) {
                    if (member.containsKey("TOTAL_PAYMENT")) {
                        System.out.println("TOTAL_PAYMENT: " + member.get("TOTAL_PAYMENT"));
                    }
                }
            } else {
                System.out.println("No active auto payments found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while scheduling payments1: " + e.getMessage());
        }
    }
    
    
    //이자 계산 실행(완료)
    @Scheduled(cron = "0 3 0 1 * ?") // 매달 1일 0시 3분에 실행 (cron = "0/1 * * * * *")(cron = "0 0 0 1 * ?")
    public void applyMonthlyInterest() {
        try {
            //활성 상태의 멤버들을 가져옵니다.
            List<Map<String, Object>> members = purproductService.getStatusY();

            //멤버가 존재하는지 확인합니다.
            if (members != null && !members.isEmpty()) {
                //이자 계산 로직을 수행합니다.
                schedulerService.applyInterestRates(members);

                //TOTAL_PAYMENT 값을 출력합니다.
                for (Map<String, Object> member : members) {
                    if (member.containsKey("TOTAL_PAYMENT")) {
                        System.out.println("TOTAL_PAYMENT: " + member.get("TOTAL_PAYMENT"));
                    }
                }
            } else {
                System.out.println("No members found for interest calculation.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while applying monthly interest: " + e.getMessage());
        }
    }

    
    //상품 종료 업데이트
    //골든볼 처리
    @Scheduled(cron = "0 5 0 * * *") // 매일 12시 5분에 실행 (cron = "0/1 * * * * *") (cron = "0 5 0 * * *")
    public void updateExpiredProductsStatus() {
        try {
        	productService.updateProductStatus();
        	purproductService.allocateGoldenBallAmount();
            System.out.println("3");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error occurred while updating product statuses3: " + e.getMessage());
        }
    }
    
   
    //상품 만기1년후 자동삭제
    @Scheduled(cron = "0 0 0 1 * ?")//매달 1일 실행
    public void deleteExpiredProduct() {
    	try {
    		admindao.deleteExpried();
    	}catch(Exception e) {
    		e.printStackTrace();
    		System.err.println("Error oddurred while running deleteExpired scheduling" +e.getMessage());
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
