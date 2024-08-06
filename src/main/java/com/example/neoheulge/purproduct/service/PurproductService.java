package com.example.neoheulge.purproduct.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.NePreSavProdDTO;

@Service
public class PurproductService {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 상품 가입
    public void insertSubscription(Map<String, Object> params) {
        sqlSession.insert("insertSubscription", params);
    }

    // 회원 ID로 모든 가입 정보 조회
    public List<Map<String, Object>> getAllSubscriptionsByMemberId(String memberId) {
        return sqlSession.selectList("getAllSubscriptionsByMemberId", memberId);
    }

    // 만기된 가입 중 하나를 랜덤으로 선택하여 골든볼 등록
    public void registerGoldenBallForExpiredSubscriptions(Map<String, Object> params) {
        sqlSession.update("registerGoldenBallForExpiredSubscriptions", params);
    }

    // 만기된 가입의 기본 이율 반환
    public Double getBaseRateForExpiredSubscriptions(String subscriptionId) {
        return sqlSession.selectOne("getBaseRateForExpiredSubscriptions", subscriptionId);
    }

    // 가입 해지 및 포기 환급액 기록
    public void terminateSubscription(Map<String, Object> params) {
        sqlSession.update("terminateSubscription", params);
    }

    // 자동 결제 정보 수정
    public void updateAutoPayment(Map<String, Object> params) {
        sqlSession.update("updateAutoPayment", params);
    }

    // 자동 결제 삭제
    public void deleteAutoPayment(String subscriptionId) {
        sqlSession.update("deleteAutoPayment", subscriptionId);
    }
}
