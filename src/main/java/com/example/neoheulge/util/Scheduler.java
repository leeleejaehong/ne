package com.example.neoheulge.util;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.neoheulge.admin.service.AdminDAO;
import com.example.neoheulge.product.service.ProductService;
import com.example.neoheulge.purproduct.service.PurproductService;

@Component
public class Scheduler {

    //private static final Logger logger = LoggerFactory.getLogger(Scheduler.class);

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

    // 추가금 넣기
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실행 (cron = "0/1 * * * * *")(cron = "0 0 0 * * *")
    public void schedulePayments() {
        try {
            List<Map<String, Object>> members = purproductService.getActiveAuto();
            if (members != null && !members.isEmpty()) {
                schedulerService.scheduleAutoPayments(members);
                for (Map<String, Object> member : members) {
                    if (member.containsKey("TOTAL_PAYMENT")) {
                        //logger.info("TOTAL_PAYMENT: {}", member.get("TOTAL_PAYMENT"));
                    }
                }
                //logger.info("schedulePayments completed successfully.");
            } else {
                //logger.warn("No active auto payments found.");
            }
        } catch (Exception e) {
            //logger.error("Error occurred while scheduling payments: {}", e.getMessage(), e);
        }
    }

    // 이자 계산 실행
    @Scheduled(cron = "0 3 0 1 * ?") // 매달 1일 0시 3분에 실행 (cron = "0/1 * * * * *")(cron = "0 0 0 1 * ?")
    public void applyMonthlyInterest() {
        try {
            List<Map<String, Object>> members = purproductService.getStatusY();
            if (members != null && !members.isEmpty()) {
                schedulerService.applyInterestRates(members);
                for (Map<String, Object> member : members) {
                    if (member.containsKey("TOTAL_PAYMENT")) {
                        //logger.info("TOTAL_PAYMENT: {}", member.get("TOTAL_PAYMENT"));
                    }
                }
                //logger.info("applyMonthlyInterest completed successfully.");
            } else {
                //logger.warn("No members found for interest calculation.");
            }
        } catch (Exception e) {
            //logger.error("Error occurred while applying monthly interest: {}", e.getMessage(), e);
        }
    }

    // 상품 종료 업데이트 및 골든볼 처리
    @Scheduled(cron = "0 5 0 * * *") // 매일 12시 5분에 실행 (cron = "0/1 * * * * *") (cron = "0 5 0 * * *")
    public void updateExpiredProductsStatus() {
        try {
            productService.updateProductStatus();
            purproductService.allocateGoldenBallAmount();
            //logger.info("updateExpiredProductsStatus completed successfully.");
        } catch (Exception e) {
            //logger.error("Error occurred while updating product statuses: {}", e.getMessage(), e);
        }
    }

    // 상품 만기 1년 후 자동 삭제
    @Scheduled(cron = "0 0 0 1 * ?")//매달 1일 실행
    public void deleteExpiredProduct() {
        try {
            admindao.deleteExpried();
            //logger.info("deleteExpiredProduct completed successfully.");
        } catch (Exception e) {
            //logger.error("Error occurred while deleting expired products: {}", e.getMessage(), e);
        }
    }
}
