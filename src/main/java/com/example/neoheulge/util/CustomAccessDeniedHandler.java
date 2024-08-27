package com.example.neoheulge.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {
	//403전용 handler
	 @Override
	    public void handle(HttpServletRequest request, HttpServletResponse response,
	                       AccessDeniedException accessDeniedException) throws IOException, ServletException {
		 request.setAttribute("message", accessDeniedException.getMessage());
		 request.getRequestDispatcher("/WEB-INF/views/error/403.jsp").forward(request, response);
	    }

}
