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

import com.singbon.entity.AuthUserGroup;
import com.singbon.service.systemManager.AuthorizationService;

@Repository("customUserDetailService")
public class CustomUserDetailService implements UserDetailsService {
	@Autowired
	public SysUserService sysUserService;
	@Autowired
	public AuthorizationService userRolesService;

	@Override
	public UserDetails loadUserByUsername(String loginInfo) throws UsernameNotFoundException {
		String args[] = loginInfo.split(CustomAuthenticationFilter.USERNAME_LOGINID_SPLIT);
		String userId = args[0];
		String username = args[1];
		String password = args[2];
		String enable = args[3];
		UserDetails userDetail = null;
		if (!"0".equals(userId)) {
			userDetail = new User(username, password, "1".equals(enable), true, true, true, obtainUserPowers(Integer.parseInt(userId)));
		}
		return userDetail;
	}

	public Collection<GrantedAuthority> obtainUserPowers(Integer userId) {
		Collection<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
//		List<AuthUserGroup> list = this.userRolesService.selectByUserId(userId);
//		for (AuthUserGroup r : list) {
//			//gas.add(new SimpleGrantedAuthority(r.getRole()));
//		}
		gas.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		return gas;
	}

}
