package com.csp.reportquery.duridconfig;

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @ClassNmame S.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 上午10:57:47
 * @Copyright © 2020 by 奥特虾不会写代码
 */

@Configuration
public class Druid {
	public Druid() {
	}

	@Bean
	public ServletRegistrationBean<StatViewServlet> statViewServlet() {
		ServletRegistrationBean<StatViewServlet> servletRegistrationBean = new ServletRegistrationBean<StatViewServlet>(
				new StatViewServlet(), new String[] { "/druid/*" });
		servletRegistrationBean.addInitParameter("allow", "192.168.6.207");
		servletRegistrationBean.addInitParameter("allow", "192.168.1.9");
		//servletRegistrationBean.addInitParameter("deny", "127.0.0.1");
		servletRegistrationBean.addInitParameter("loginUsername", "psl");
		servletRegistrationBean.addInitParameter("loginPassword", "123456");
		servletRegistrationBean.addInitParameter("resetEnable", "false");
		return servletRegistrationBean;
	}
	// https://github.com/first-java/psl.git
	@Bean
	public FilterRegistrationBean<WebStatFilter> statFilter() {
		FilterRegistrationBean<WebStatFilter> filterRegistrationBean = new FilterRegistrationBean<WebStatFilter>(
				new WebStatFilter(), new ServletRegistrationBean[0]);
		filterRegistrationBean.addUrlPatterns(new String[] { "/*" });
		filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*,");
		return filterRegistrationBean;
	}
}