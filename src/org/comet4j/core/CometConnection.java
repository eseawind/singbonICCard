// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CometConnection.java

package org.comet4j.core;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.comet4j.core.util.ExplorerUtil;
import org.comet4j.core.util.NetUtil;

// Referenced classes of package org.comet4j.core:
//            CometContext

public class CometConnection {

	public CometConnection(HttpServletRequest anRequest, HttpServletResponse anResponse) {
		state = "alive";
		dyingTime = 0L;
		clientIp = NetUtil.getIpAddr(anRequest);
		clientVersion = anRequest.getParameter("cv");
		if (CometContext.getInstance().getWorkStyle().equals("auto")) {
			if (ExplorerUtil.canStreamingXHR(anRequest).booleanValue())
				workStyle = "stream";
			else
				workStyle = "lpool";
		} else {
			workStyle = CometContext.getInstance().getWorkStyle();
		}
		request = anRequest;
		response = anResponse;
		String companyId = (String) request.getSession().getAttribute("companyId");
		if (companyId != null) {
			this.companyId = companyId;
		}
	}

	public String getId() {
		return id;
	}

	public String getClientIp() {
		return clientIp;
	}

	public String getClientVersion() {
		return clientVersion;
	}

	public String getWorkStyle() {
		return workStyle;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public long getDyingTime() {
		return dyingTime;
	}

	public void setDyingTime(long dyingTime) {
		this.dyingTime = dyingTime;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public void destroy() {
		request = null;
		response = null;
	}

	private final String id = UUID.randomUUID().toString();
	private final String clientIp;
	private final String clientVersion;
	private String workStyle;
	private String state;
	private long dyingTime;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String companyId;

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
}
