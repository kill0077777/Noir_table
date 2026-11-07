package com.noir.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.web.util.matcher.RequestMatcher;

/**
 * 리뷰 게시판의 상태 변경 요청에만 우선 적용하는 CSRF 매처입니다.
 * 전체 애플리케이션에 적용할 때는 security-context.xml의 matcher를 제거하고
 * 모든 POST/PUT/PATCH/DELETE 폼과 AJAX에 토큰을 추가하십시오.
 */
public class ReviewCsrfRequestMatcher implements RequestMatcher {
    @Override
    public boolean matches(HttpServletRequest request) {
        String uri = request.getRequestURI().substring(request.getContextPath().length());
        String method = request.getMethod();
        boolean stateChanging = "POST".equalsIgnoreCase(method)
                || "PUT".equalsIgnoreCase(method)
                || "PATCH".equalsIgnoreCase(method)
                || "DELETE".equalsIgnoreCase(method);
        return stateChanging && uri.startsWith("/review/");
    }
}
