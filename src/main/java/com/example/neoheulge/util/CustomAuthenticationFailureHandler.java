package com.example.neoheulge.util;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {


	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
										HttpServletResponse response, 
										AuthenticationException exception)
			throws IOException, ServletException {
		System.out.println(exception.getMessage());
		String errorMessage = URLEncoder.encode(exception.getMessage(), StandardCharsets.UTF_8.toString());
		
		
        response.sendRedirect("/member/login.do?error=true&message=" + errorMessage);
		
		
	}
}