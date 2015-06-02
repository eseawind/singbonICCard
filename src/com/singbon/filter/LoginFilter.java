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
 * 
 * @author 郝威
 * 
 */
public class LoginFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) arg0;
		String url = req.getRequestURI();
		SysUser user = (SysUser) req.getSession().getAttribute("sysUser");
		if (user != null) {
			arg2.doFilter(arg0, arg1);
		} else {
			if (url.endsWith("/") || url.endsWith(".js") || url.endsWith("/login.do") || url.endsWith("/index.html")) {
				arg2.doFilter(arg0, arg1);
			} else {
				((HttpServletResponse) arg1).sendRedirect("/");
			}
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
