package org.comet4j.core;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.comet4j.core.event.CometContextEvent;
import org.comet4j.core.exception.DoubleAppModuleKeyException;
import org.comet4j.core.listener.CometContextListener;
import org.comet4j.event.Observable;

public class CometContext extends Observable<CometContextEvent, CometContextListener> {
	public final String version = "0.1.0";

	private Locale locale = Locale.CHINESE;

	private String workStyle = "auto";
	private CometEngine engine;
	private List<String> appModules = new ArrayList<String>();

	private int timeout = 60000;

	private int cacheExpires = 60000;

	private int cacheFrequency = 60000;

	private int connExpires = 5000;

	private int connFrequency = 5000;

	private boolean debug = false;

	private boolean init = false;
	private ServletContext servletContext;
	private static CometContext instance;

	public void init(ServletContextEvent event) {
		if (this.init) {
			return;
		}
		this.servletContext = event.getServletContext();
		loadConfig(this.servletContext);
		this.init = true;
		CometContextEvent e = new CometContextEvent(this, CometContextEvent.INITIALIZED);
		e.setCometContext(this);
		e.setServletContext(event.getServletContext());
		fireEvent(e);
		log("Comet4J v0.1.0 " + Language.get("InitComplete"));
	}

	public static CometContext getInstance() {
		if (instance == null) {
			instance = new CometContext();
		}
		return instance;
	}

	public void log(String str) {
		if (this.debug)
			instance.servletContext.log(str);
	}

	public void log(String str, Throwable trb) {
		if (this.debug)
			instance.servletContext.log(str, trb);
	}

	public Object createInstance(String className) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		Object obj = Class.forName(className).newInstance();
		return obj;
	}

	private CometContext() {
		addEvent(CometContextEvent.class);
	}

	private void loadConfig(ServletContext ct) {
		String workStyleStr = ct.getInitParameter("Comet.WorkStyle");
		if ((workStyleStr != null) && (!"".equals(workStyleStr.trim())) && (("auto".equals(workStyleStr)) || ("lpool".equals(workStyleStr)) || ("stream".equals(workStyleStr)))) {
			this.workStyle = workStyleStr;
		}

		String timeoutStr = ct.getInitParameter("Comet.Timeout");
		if ((timeoutStr != null) && (!"".equals(timeoutStr.trim()))) {
			try {
				this.timeout = Integer.valueOf(timeoutStr).intValue();
			} catch (Exception e) {
				log("配置错误", e);
			}
		}

		String cacheExpiresStr = ct.getInitParameter("Comet.CacheExpires");
		if ((cacheExpiresStr != null) && (!"".equals(cacheExpiresStr.trim()))) {
			try {
				this.cacheExpires = Integer.valueOf(cacheExpiresStr).intValue();
			} catch (Exception e) {
				log("配置错误", e);
			}
		}

		String cacheFrequencyStr = ct.getInitParameter("Comet.CacheFrequency");
		if ((cacheFrequencyStr != null) && (!"".equals(cacheFrequencyStr.trim()))) {
			try {
				this.cacheFrequency = Integer.valueOf(cacheFrequencyStr).intValue();
			} catch (Exception e) {
				log("配置错误", e);
			}
		}

		String connExpiresStr = ct.getInitParameter("Comet.ConnExpires");
		if ((connExpiresStr != null) && (!"".equals(connExpiresStr.trim()))) {
			try {
				this.connExpires = Integer.valueOf(connExpiresStr).intValue();
			} catch (Exception e) {
				log("配置错误", e);
			}
		}

		String connFrequencyStr = ct.getInitParameter("Comet.ConnFrequency");
		if ((connFrequencyStr != null) && (!"".equals(connFrequencyStr.trim()))) {
			try {
				this.connFrequency = Integer.valueOf(connFrequencyStr).intValue();
			} catch (Exception e) {
				log("配置错误", e);
			}
		}

		String debugStr = ct.getInitParameter("Comet.Debug");
		if ((debugStr != null) && ("true".equals(debugStr.trim()))) {
			this.debug = true;
		}

		String languageStr = ct.getInitParameter("Comet.Language");
		if ((languageStr != null) && (!"".equals(languageStr.trim())) && (Locale.ENGLISH.getLanguage().equals(languageStr))) {
			this.locale = Locale.ENGLISH;
		}

		String engineStr = ct.getInitParameter("Comet.CometEngine");
		if ((engineStr != null) && (!"".equals(engineStr.trim()))) {
			try {
				this.engine = ((CometEngine) createInstance(engineStr));
			} catch (Exception e) {
				log("配置错误", e);
				this.engine = new CometEngine();
			}
		} else
			this.engine = new CometEngine();
	}

	public String getVersion() {
		return "0.1.0";
	}

	public String getWorkStyle() {
		return this.workStyle;
	}

	public CometEngine getEngine() {
		return this.engine;
	}

	public int getTimeout() {
		return this.timeout;
	}

	public int getCacheExpires() {
		return this.cacheExpires;
	}

	public int getConnExpires() {
		return this.connExpires;
	}

	public boolean isDebug() {
		return this.debug;
	}

	public boolean isInit() {
		return this.init;
	}

	public Locale getLocale() {
		return this.locale;
	}

	public ServletContext getServletContext() {
		return this.servletContext;
	}

	public int getCacheFrequency() {
		return this.cacheFrequency;
	}

	public int getConnFrequency() {
		return this.connFrequency;
	}

	public void registChannel(String anAppModule) {
		if (this.appModules.contains(anAppModule)) {
			throw new DoubleAppModuleKeyException(Language.get("DoubleAppModuleKey"));
		}
		this.appModules.add(anAppModule);
	}

	public void destroy() {
		this.appModules.clear();
		this.appModules = null;
		this.engine.destroy();
		this.engine = null;
		this.servletContext = null;
		instance = null;
		CometContextEvent e = new CometContextEvent(this, CometContextEvent.DESTROYED);
		fireEvent(e);
	}

	public List<String> getAppModules() {
		return appModules;
	}

	public void setAppModules(List<String> appModules) {
		this.appModules = appModules;
	}
}