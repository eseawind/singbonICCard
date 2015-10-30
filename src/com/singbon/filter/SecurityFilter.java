package com.singbon.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.singbon.entity.SysUser;

/**
 * 安全登录验证
 * 
 * @author 郝威
 *
 */
public class SecurityFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		String url = req.getRequestURI();
		if (url.equals("/") || url.startsWith("/disuserlogin.htm") || url.startsWith("/js/") || url.startsWith("/img/") || url.startsWith("/themes/") || url.equals("/favicon.ico")) {
			chain.doFilter(request, response);
		} else {
			SysUser sysUser = (SysUser) req.getSession().getAttribute("sysUser");
			if (sysUser == null) {
				((HttpServletResponse) response).sendRedirect("/");
			}
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
