package com.example.neoheulge.util;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class IpAddressAccessControlFilter implements Filter {
    private String adminIp;
    
    public IpAddressAccessControlFilter(String adminIp) {
        this.adminIp = adminIp;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 코드 (필요시 구현)
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String clientIp = httpRequest.getRemoteAddr();
        
        if (!adminIp.equals(clientIp)) {
        	System.out.println("cl="+clientIp);
            System.out.println("al="+adminIp);
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: 지정된 관리자IP에서만 접근 가능합니다.");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // 필터 정리 코드 (필요시 구현)
    }
}