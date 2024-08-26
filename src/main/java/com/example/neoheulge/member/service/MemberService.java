package com.example.neoheulge.member.service;

import com.example.neoheulge.member.entity.Member;
import com.example.neoheulge.member.repository.JpaMemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
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
	private final JpaMemberRepository memberRepository;


	public MemberService(PasswordEncoder bcryptPasswordEncoder, JpaMemberRepository memberRepository) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
        this.memberRepository = memberRepository;
    }
	@Transactional
	//@CacheEvict(value = "members", allEntries = true) -> 멤버추가할시 전체멤버캐시초기화
	public int signupPro(MemberDTO member) {
		member.setGrade("ROLE_1");
		member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
		return memberDAO.signupPro(member);
	}
	public Member findMember(String email) {
		return memberRepository.findByEmail(email)
				.orElseThrow(() -> new RuntimeException("없는 계정입니다."));
	}

	public Member findDefaultMember() {
		// 테스트용 기본 회원을 반환하는 로직
		// 예: 데이터베이스에서 특정 ID나 이메일을 가진 회원을 조회
		return memberRepository.findByEmail("default@example.com")
				.orElseThrow(() -> new RuntimeException("ad"));
	}
	public MemberDTO findByName(String name) {
		return memberDAO.findByName(name);
	}
	
	public MemberDTO findByIdName (MemberDTO member) {
		return memberDAO.findByIdName(member);
	}
	//@CacheEvict(value = "members", allEntries = true) redis설치하면 주석풀어주세여
	public int updatePw(MemberDTO member) {
		member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
		return memberDAO.updatePw(member);
	}
	
	public String IdEmail(String member) {
		return memberDAO.IdEmail(member);
	}

}
