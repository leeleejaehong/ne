/* 테스트중
 * package com.example.neoheulge.errors;
 * 
 * 
 * import org.springframework.boot.web.servlet.error.ErrorController; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.servlet.ModelAndView;
 * 
 * import javax.servlet.http.HttpServletRequest;
 * 
 * @Controller public class CustomErrorController implements ErrorController {
 * 
 * @RequestMapping("/error") public ModelAndView handleError(HttpServletRequest
 * request) { Integer statusCode = (Integer)
 * request.getAttribute("javax.servlet.error.status_code");
 * 
 * if (statusCode != null && statusCode == 403) {//403에러만 권한없음으로돌림(관리자페이지)
 * System.out.println(statusCode); return new ModelAndView("error/403"); }
 * 
 * // 기본 처리 (다른 상태 코드에 대한 기본 페이지를 사용) return new ModelAndView("error/general");
 * } }
 */
