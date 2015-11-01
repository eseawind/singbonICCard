package com.singbon.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;

import com.singbon.dao.systemManager.AuthorizationDAO;

@Repository("customUserDetailService")
public class CustomUserDetailService implements UserDetailsService {

	@Autowired
	public AuthorizationDAO authorizationDAO;

	@Override
	public UserDetails loadUserByUsername(String loginInfo) throws UsernameNotFoundException {
		String args[] = loginInfo.split(CustomAuthenticationFilter.USERNAME_LOGINID_SPLIT);
		String operId = args[0];
		String username = args[1];
		String password = args[2];
		UserDetails userDetail = null;
		if (!"0".equals(operId)) {
			userDetail = new User(username, password, true, true, true, true, obtainUserPowers(Integer.parseInt(operId)));
		}
		return userDetail;
	}

	public Collection<GrantedAuthority> obtainUserPowers(Integer operId) {
		Collection<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
		List<String> rolesList = this.authorizationDAO.selectRolesByOperId(operId);
		for (String role : rolesList) {
			String[] roles = role.split(",");
			for (String r : roles) {
				gas.add(new SimpleGrantedAuthority(r));
			}
		}
		return gas;
	}

}
