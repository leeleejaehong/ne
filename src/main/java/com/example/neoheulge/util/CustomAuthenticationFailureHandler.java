package com.example.neoheulge.util;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        // 실패 페이지로 리다이렉트, 메시지 전달
        String errorMessage = exception.getMessage();
        response.sendRedirect("/member/login.do?error=true&message=" + errorMessage);
    }

	@Override
	public void onAuthenticationFailure(jakarta.servlet.http.HttpServletRequest request,
			jakarta.servlet.http.HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
		String errorMessage = URLEncoder.encode(exception.getMessage(), StandardCharsets.UTF_8.toString());
        response.sendRedirect("/member/login.do?error=true&message=" + errorMessage);
		// TODO Auto-generated method stub
		
	}
}