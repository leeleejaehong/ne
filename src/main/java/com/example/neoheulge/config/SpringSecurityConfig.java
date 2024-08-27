package com.example.neoheulge.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import com.example.neoheulge.util.IpAddressAccessControlFilter;
import com.example.neoheulge.util.CustomAccessDeniedHandler;
import com.example.neoheulge.util.CustomAuthenticationFailureHandler;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity(debug = false)
@RequiredArgsConstructor
public class SpringSecurityConfig {

    private final Environment env;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/admin/**").hasAuthority("ROLE_1")
                        //.requestMatchers("/지정경로/**").hasAnyAuthority("ROLE_1", "ROLE_2")-> 일반회원/비회원구분
                        .requestMatchers("/**", "/css/**", "/img/**").permitAll()
                        .anyRequest().authenticated())
                .formLogin(form -> form
                        .loginPage("/member/login.do")
                        .loginProcessingUrl("/login")
                        .failureHandler(new CustomAuthenticationFailureHandler())
                        .defaultSuccessUrl("/")
                        .permitAll())
                .exceptionHandling(exceptions -> exceptions
                        .accessDeniedHandler(new CustomAccessDeniedHandler()))
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                        .logoutSuccessUrl("/")
                        .invalidateHttpSession(true))
                .httpBasic(basic -> basic.disable());
        return http.build();
    }

	/*
	 * @Bean public FilterRegistrationBean<IpAddressAccessControlFilter>
	 * ipAddressAccessControlFilter() { String adminIp =
	 * env.getProperty("admin.ipaddress"); // properties에서 IP 주소 가져오기
	 * IpAddressAccessControlFilter filter = new
	 * IpAddressAccessControlFilter(adminIp);
	 * FilterRegistrationBean<IpAddressAccessControlFilter> registrationBean = new
	 * FilterRegistrationBean<>(); registrationBean.setFilter(filter);
	 * registrationBean.addUrlPatterns("/admin/*"); // 관리자 페이지에만 적용
	 * registrationBean.setOrder(1); // 필터 순서, 숫자 낮을수록 높은 우선순위 return
	 * registrationBean; }
	 */

    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return web -> web.ignoring().requestMatchers("/error", "/favicon.ico", "/css/**", "/js/**", "/img/**");
    }

    @Bean
    public static BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}