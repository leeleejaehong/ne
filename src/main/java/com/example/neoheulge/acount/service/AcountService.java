package com.example.neoheulge.acount.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.NeAcountDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AcountService {

    @Autowired
    private SqlSession sqlSession;
    
    @Autowired
    private JavaMailSender mailSender;


    // 계좌 추가
    public void addAccount(NeAcountDTO dto) {

        // 새로운 계좌 추가
        sqlSession.insert("insertNeacount", dto);
        // 주계좌로 설정
        sqlSession.update("updatePrimaryAccountStatus", dto);
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
    
    public void sendSimpleEmail(String toEmail, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("your-email@gmail.com");
        message.setTo(toEmail);
        message.setSubject(subject);
        message.setText(body);

        mailSender.send(message);
    }
    
    public void updateAllAccountsToNonPrimary(String member_id) {
    	sqlSession.update("updateAllAccountsToNonPrimary",member_id);
    }
    
    
    public void updateNToNonPrimary(int acount_id) {
    	sqlSession.update("updateNToNonPrimary",acount_id);
    }
    
    public void updatePrimaryAccountStatus(int acount_id) {
    	sqlSession.update("updatePrimaryAccountStatus",acount_id);
    }
    
    public boolean changeMainAccount(String username, int accountId) {
        try {
            updateAllAccountsToNonPrimary(username);
            updatePrimaryAccountStatus(accountId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public void updateMoney(NeAcountDTO dto) {
    	sqlSession.update("updateMoney",dto);
    }
  
}
