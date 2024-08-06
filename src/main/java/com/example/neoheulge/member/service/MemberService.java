package com.example.neoheulge.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.MemberDTO;

import jakarta.transaction.Transactional;
@Service
public class MemberService {
	@Autowired
	private MemberDAO memberDAO;
	private final PasswordEncoder bcryptPasswordEncoder;
	
	public MemberService(PasswordEncoder bcryptPasswordEncoder) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}
	@Transactional
	public int signupPro(MemberDTO member) {
		member.setGrade("ROLE_1");
		member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
		return memberDAO.signupPro(member);
	}
	
}
