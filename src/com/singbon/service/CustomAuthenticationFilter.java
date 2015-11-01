/* Copyright 2004, 2005, 2006 Acegi Technology Pty Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.singbon.service;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.util.Assert;

import com.singbon.dao.CompanyDAO;
import com.singbon.dao.SysUserDAO;
import com.singbon.dao.systemManager.DeviceDAO;
import com.singbon.entity.Company;
import com.singbon.entity.Device;
import com.singbon.entity.SysUser;
import com.singbon.util.DesUtil;

/**
 * Processes an authentication form submission. Called
 * {@code AuthenticationProcessingFilter} prior to Spring Security 3.0.
 * <p>
 * Login forms must present two parameters to this filter: a username and
 * password. The default parameter names to use are contained in the static
 * fields {@link #SPRING_SECURITY_FORM_USERNAME_KEY} and
 * {@link #SPRING_SECURITY_FORM_PASSWORD_KEY}. The parameter names can also be
 * changed by setting the {@code usernameParameter} and
 * {@code passwordParameter} properties.
 * <p>
 * This filter by default responds to the URL {@code /j_spring_security_check}.
 * 
 * @author Ben Alex
 * @author Colin Sampaleanu
 * @author Luke Taylor
 * @since 3.0
 */
public class CustomAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

	@Autowired
	public SysUserDAO sysUserDAO;
	@Autowired
	public CompanyDAO companyDAO;
	@Autowired
	public DeviceDAO deviceDAO;
	// ~ Static fields/initializers
	// =====================================================================================

	public static final String SPRING_SECURITY_FORM_USERNAME_KEY = "j_username";
	public static final String SPRING_SECURITY_FORM_PASSWORD_KEY = "j_password";
	public static final String SPRING_SECURITY_FORM_CompanyName_KEY = "companyName";
	public static final String USERNAME_LOGINID_SPLIT = "/";
	/**
	 * @deprecated If you want to retain the username, cache it in a customized
	 *             {@code AuthenticationFailureHandler}
	 */
	@Deprecated
	public static final String SPRING_SECURITY_LAST_USERNAME_KEY = "SPRING_SECURITY_LAST_USERNAME";

	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
	private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;
	private String companyName = SPRING_SECURITY_FORM_CompanyName_KEY;
	private boolean postOnly = true;

	// ~ Constructors
	// ===================================================================================================

	public CustomAuthenticationFilter() {
		super("/j_spring_security_check");
	}

	// ~ Methods
	// ========================================================================================================

	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		if (postOnly && !request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
		}

		String username = obtainUsername(request);
		String password = obtainPassword(request);
		String companyName = null;
		try {
			companyName = new String(obtainCompanyName(request).getBytes("ISO-8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		if (username == null) {
			username = "";
		}

		if (password == null) {
			password = "";
		}

		if (companyName == null) {
			companyName = "";
		}

		try {
			username = DesUtil.encrypt(username.trim());
			password = DesUtil.encrypt(password.trim());
		} catch (Exception e) {
			e.printStackTrace();
		}
		companyName = companyName.trim();

		// 获取登录信息
		SysUser user = this.sysUserDAO.login(companyName, username, password);
		username = DesUtil.decrypt(username);
		password = DesUtil.decrypt(password);
		if (user == null) {
			username = 0 + USERNAME_LOGINID_SPLIT + username + USERNAME_LOGINID_SPLIT + password;
		} else {
			Company company = (Company) this.companyDAO.selectById(user.getCompanyId());
			request.getSession().setAttribute("company", company);
			user.setLoginName(username);
			request.getSession().setAttribute("sysUser", user);
			username = user.getOperId() + USERNAME_LOGINID_SPLIT + username + USERNAME_LOGINID_SPLIT + password;
			Device device = (Device) this.deviceDAO.selectById(user.getDeviceId());
			request.getSession().setAttribute("device", device);
		}

		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);

		// Allow subclasses to set the "details" property
		authRequest.setDetails(authenticationDetailsSource.buildDetails(request));

		return this.getAuthenticationManager().authenticate(authRequest);
	}

	/**
	 * Enables subclasses to override the composition of the password, such as
	 * by including additional values and a separator.
	 * <p>
	 * This might be used for example if a postcode/zipcode was required in
	 * addition to the password. A delimiter such as a pipe (|) should be used
	 * to separate the password and extended value(s). The
	 * <code>AuthenticationDao</code> will need to generate the expected
	 * password in a corresponding manner.
	 * </p>
	 * 
	 * @param request
	 *            so that request attributes can be retrieved
	 * 
	 * @return the password that will be presented in the
	 *         <code>Authentication</code> request token to the
	 *         <code>AuthenticationManager</code>
	 */
	protected String obtainPassword(HttpServletRequest request) {
		return request.getParameter(passwordParameter);
	}

	// 获取公司id
	protected String obtainCompanyName(HttpServletRequest request) {
		return request.getParameter(companyName);
	}

	/**
	 * Enables subclasses to override the composition of the username, such as
	 * by including additional values and a separator.
	 * 
	 * @param request
	 *            so that request attributes can be retrieved
	 * 
	 * @return the username that will be presented in the
	 *         <code>Authentication</code> request token to the
	 *         <code>AuthenticationManager</code>
	 */
	protected String obtainUsername(HttpServletRequest request) {
		return request.getParameter(usernameParameter);
	}

	/**
	 * Sets the parameter name which will be used to obtain the username from
	 * the login request.
	 * 
	 * @param usernameParameter
	 *            the parameter name. Defaults to "j_username".
	 */
	public void setUsernameParameter(String usernameParameter) {
		Assert.hasText(usernameParameter, "Username parameter must not be empty or null");
		this.usernameParameter = usernameParameter;
	}

	/**
	 * Sets the parameter name which will be used to obtain the password from
	 * the login request..
	 * 
	 * @param passwordParameter
	 *            the parameter name. Defaults to "j_password".
	 */
	public void setPasswordParameter(String passwordParameter) {
		Assert.hasText(passwordParameter, "Password parameter must not be empty or null");
		this.passwordParameter = passwordParameter;
	}

	/**
	 * Defines whether only HTTP POST requests will be allowed by this filter.
	 * If set to true, and an authentication request is received which is not a
	 * POST request, an exception will be raised immediately and authentication
	 * will not be attempted. The <tt>unsuccessfulAuthentication()</tt> method
	 * will be called as if handling a failed authentication.
	 * <p>
	 * Defaults to <tt>true</tt> but may be overridden by subclasses.
	 */
	public void setPostOnly(boolean postOnly) {
		this.postOnly = postOnly;
	}

	public final String getUsernameParameter() {
		return usernameParameter;
	}

	public final String getPasswordParameter() {
		return passwordParameter;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

}
