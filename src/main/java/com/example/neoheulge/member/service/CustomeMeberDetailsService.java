package com.example.neoheulge.member.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.neoheulge.dto.CustomMemberDetails;
@Service
public class CustomeMeberDetailsService implements UserDetailsService{
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		CustomMemberDetails user = memberDAO.findById(username);
		System.out.println("!!!확인");
		if(username==null) {
			throw new UsernameNotFoundException(username);
		}
		
		System.out.println("CustomUserDetailsService 들어왔다!!!!!!!!!!!!!!!!");
		System.out.println(user.getUsername());
		System.out.println(user.getName());
		System.out.println(user.getPassword());
		List<GrantedAuthority> authorities = new ArrayList<>();
		return new User(user.getUsername(), user.getPassword(), authorities);
	}
}
