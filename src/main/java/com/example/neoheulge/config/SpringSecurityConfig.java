package com.example.neoheulge.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.example.neoheulge.util.CustomAuthenticationFailureHandler;

import lombok.RequiredArgsConstructor;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity(debug = false)
@RequiredArgsConstructor
public class SpringSecurityConfig {

	@Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
			http.csrf(AbstractHttpConfigurer::disable)
	        	.authorizeHttpRequests(authz -> authz
//	            .requestMatchers("/WEB-INF/views/index.jsp", "/css/**","/img/**").permitAll()
	        	//.requestMatchers("/admin/**").hasAuthority("ROLE_1") //관리자페이지 접근제어
	        	.requestMatchers("/**", "/css/**","/img/**").permitAll()
	            .anyRequest().authenticated()  // 나머지 경로는 인증 필요
	        )
	        .formLogin(form -> form
	            .loginPage("/member/login.do") // 로그인 페이지 설정
	            .loginProcessingUrl("/login")
	            .failureHandler(new CustomAuthenticationFailureHandler()) // 커스텀 핸들러 추가
	            .defaultSuccessUrl("/")
	            .permitAll()  // 로그인 페이지는 모든 사용자에게 허용
	         
	        )
	        .logout((logout) -> logout
	                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
	                .logoutSuccessUrl("/")
	                .invalidateHttpSession(true))
	        .httpBasic(basic -> basic.disable()); // HTTP Basic 인증 비활성화
	    return http.build();
	}
	@Bean
    WebSecurityCustomizer webSecurityCustomizer() { // security를 적용하지 않을 리소스
        return web -> web.ignoring()
                // error endpoint를 열어줘야 함, favicon.ico 추가!
                .requestMatchers("/error", "/favicon.ico", "/");
    }
	 @Bean
	    public static BCryptPasswordEncoder bCryptPasswordEncoder() {
	        return new BCryptPasswordEncoder();
	    }
}
