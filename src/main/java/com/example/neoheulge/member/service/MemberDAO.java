package com.example.neoheulge.member.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.neoheulge.dto.CustomMemberDetails;
import com.example.neoheulge.dto.MemberDTO;
@Repository
public class MemberDAO {
	 @Autowired
	 private SqlSession sqlSession;
	 
	 public int signupPro(MemberDTO member) {
		 return sqlSession.insert("member.signupPro", member);
	 }
	 
	 public CustomMemberDetails findById(String memberID) {
		 return sqlSession.selectOne("member.findById", memberID);
	 }
}
