package com.example.neoheulge.acount.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.NeAcountDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AcountService {

    @Autowired
    private SqlSession sqlSession;

    // 계좌 추가
    public void addAccount(NeAcountDTO dto) {
        sqlSession.insert("insertNeacount", dto);
    }

    // 계좌 삭제
    public void removeAccount(NeAcountDTO dto) {
        sqlSession.delete("deleteNeAcountById", dto);
    }

    // 계좌 리스트 조회 (회원 ID로)
    public List<NeAcountDTO> getAccountsByMemberId(String member_id) {
        return sqlSession.selectList("memberAcount", member_id);
    }

    // 주 계좌 상태 변경
    public void updateAccountStatus(NeAcountDTO dto) {
        sqlSession.update("updateAccountStatus", dto);
    }

    // 계좌에서 돈 차감
    public void deductMoneyFromAccount(Map<String, Object> params) {
        sqlSession.update("deductMoneyFromAccount", params);
    }

    // 결제 로그 기록
    public void logPayment(Map<String, Object> params) {
        sqlSession.insert("insertPaymentLog", params);
    }
}
