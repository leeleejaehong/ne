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
	 
	 public MemberDTO findByName(String name) {
		 return sqlSession.selectOne("member.findByName", name);	 
	 }
	 
	 public MemberDTO findByIdName(MemberDTO member) {
		 return sqlSession.selectOne("member.findByIdName", member);
	 }
	 public int updatePw(MemberDTO member) {
		 return sqlSession.update("member.updatePw", member);
	 }

	public String IdEmail(String member) {
		return sqlSession.selectOne("member.IdEmail", member);
	}
}
