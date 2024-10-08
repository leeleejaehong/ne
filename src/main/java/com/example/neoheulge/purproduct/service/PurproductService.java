package com.example.neoheulge.purproduct.service;

import java.util.HashMap;
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
    public int insertSubscription(NePreSavProdDTO dto) {
        return sqlSession.insert("insertSubscription", dto);
    }

    public List<Map<String, Object>> getByMemberId(NePreSavProdDTO dto) {
        return sqlSession.selectList("getByMemberId", dto);
    }
    
    // 회원 ID와 상품 코드로 모든 가입 정보 가져오기
    public List<NePreSavProdDTO> getAllSubscriptionsByMemberIdAndProductCode(Map<String, Object> params) {
        return sqlSession.selectList("getAllSubscriptionsIDPROD", params);
    }

    // 상품 해지 (회원 상태 변경, 포기 환급액, 해지 날짜 기록)
    public void terminateSubscription(NePreSavProdDTO dto) {
        sqlSession.update("terminateSubscription", dto);
    }

    // 상품의 종료일 도래 시 골든볼 처리
    public String selectRandomMemberId() {
    	return sqlSession.selectOne("selectRandomMemberId");
    }
    
    public void allocateGoldenBallAmount(String member_id) {
        sqlSession.update("allocateGoldenBallAmount",member_id);
    }
    
    public void updateWinner(String member_id) {
    	sqlSession.update("updateWinner",member_id);
    }

    // 만기 시 골든볼 이율 적용
    public void applyGoldenBallRate(Map<String, Object> params) {
        sqlSession.update("applyGoldenBallRate", params);
    }

    // 만기 시 기본 이율 적용
    public void applyBaseRate(Map<String, Object> params) {
        sqlSession.update("applyBaseRate", params);
    }

    //자동결제가 활성화된 회원 목록을 가져옴
    public List<Map<String, Object>> getStatusY() {
        return sqlSession.selectList("getStatusY");
    }
    
    //자동결제가 활성화된 회원 목록을 가져옴
    public List<Map<String, Object>> getActiveAuto() {
        return sqlSession.selectList("getActiveAuto");
    }
    
    // 추가금 넣기
    public void addAdditionalAmount(Map<String, Object> params) {
        sqlSession.update("AdditionalAmount", params);
    }
    
    //날짜 업데이트
    public void updateAutoDate(Map<String, Object> params) {
    	sqlSession.update("updateAutoDate",params); 
    }

    
    // 자동결제 등록
    public void insertAuto(NePreSavProdDTO dto) {
        sqlSession.insert("insertAuto", dto);
    }

    // 자동결제 수정
    public void updateAutoPayment(NePreSavProdDTO dto) {
        sqlSession.update("updateAutoPayment", dto);
    }

    // 자동결제 삭제
    public void deleteAutoPayment(Map<String, Object> params) {
        sqlSession.update("deleteAutoPayment", params);
    }
    
    //해지한 상품정보 삭제
    public int deleteProProduct(int subscription_id) {
    	return sqlSession.delete("deleteProProduct",subscription_id);
    }
    
    //상품 중복 가입 확인
    public NePreSavProdDTO findProdDo(String member_id,String product_code) {
    	Map<String, Object> params = new HashMap<>();
	    params.put("product_code",product_code);
	    params.put("member_id",member_id);
    	return sqlSession.selectOne("findProdDo",params);
    }
    
    //가입한 상품정보 전체 삭제
    public int deleteAllProduct(String member_id) {
    	return sqlSession.delete("deleteAllProduct",member_id);
    }
    
    //회원 삭제전 가입한 상품 있는지 확인
    public List<Map<String, Object>> getSignMemberId(NePreSavProdDTO dto) {
        return sqlSession.selectList("getSignMemberId", dto);
    }
}