package org.comet4j.core;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.comet4j.core.util.ExplorerUtil;
import org.comet4j.core.util.NetUtil;

public class CometConnection {
	private final String id = UUID.randomUUID().toString();
	private final String clientIp;
	private final String clientVersion;
	private String workStyle;
	private String state;
	private long dyingTime;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private String companyId;

	public CometConnection(HttpServletRequest anRequest, HttpServletResponse anResponse) {
		this.state = "alive";
		this.dyingTime = 0L;
		this.clientIp = NetUtil.getIpAddr(anRequest);
		this.clientVersion = anRequest.getParameter("cv");
		if (CometContext.getInstance().getWorkStyle().equals("auto")) {
			if (ExplorerUtil.canStreamingXHR(anRequest).booleanValue())
				this.workStyle = "stream";
			else
				this.workStyle = "lpool";
		} else
			this.workStyle = CometContext.getInstance().getWorkStyle();

		this.request = anRequest;
		this.response = anResponse;
		String companyId = (String) this.request.getSession().getAttribute("companyId");
		if (companyId != null)
			this.companyId = companyId;
	}

	public String getId() {
		return this.id;
	}

	public String getClientIp() {
		return this.clientIp;
	}

	public String getClientVersion() {
		return this.clientVersion;
	}

	public String getWorkStyle() {
		return this.workStyle;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public long getDyingTime() {
		return this.dyingTime;
	}

	public void setDyingTime(long dyingTime) {
		this.dyingTime = dyingTime;
	}

	public HttpServletRequest getRequest() {
		return this.request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return this.response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public void destroy() {
		this.request = null;
		this.response = null;
	}

	public String getCompanyId() {
		return this.companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
}