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
		HttpServletResponse res = (HttpServletResponse) response;
		String url = req.getRequestURI();
		if (url.equals("/") || url.startsWith("/index.jsp") || url.contains("dwz.frag.xml") || url.startsWith("/userlogin.do") || url.startsWith("/js/") || url.startsWith("/img/")
				|| url.startsWith("/themes/") || url.equals("/favicon.ico") || url.equals("/singbon/backgroud/system/admin/login.do") || url.equals("/singbon/backgroud/system/admin/loginin.do")) {
			chain.doFilter(request, response);
		} else {
			// 后台
			if (url.startsWith("/singbon/backgroud/system/admin")) {
				if (req.getSession().getAttribute("adminLogin") != null) {
					chain.doFilter(request, response);
				} else {
					res.sendRedirect("/singbon/backgroud/system/admin/login.do");
				}
			} else {
				SysUser sysUser = (SysUser) req.getSession().getAttribute("sysUser");
				if (sysUser != null) {
					chain.doFilter(request, response);
				} else {
					res.sendRedirect("/");
				}
			}
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
