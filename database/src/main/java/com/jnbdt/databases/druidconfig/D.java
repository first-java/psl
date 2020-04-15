package com.jnbdt.databases.druidconfig;


import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;

/**
 * @ClassNmame D.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月14日 下午4:54:42
 * @Copyright © 2020 by 奥特虾不会写代码
 */

@Configuration
public class D {
	/**
	 * 配置监控服务器
	 * 
	 * @return 返回监控注册的servlet对象
	 * @author SimpleWu
	 */
	@Bean
	public ServletRegistrationBean<StatViewServlet> statViewServlet() {
		ServletRegistrationBean<StatViewServlet> servletRegistrationBean = new ServletRegistrationBean<StatViewServlet>(
				new StatViewServlet(), "/druid/*");
		// 添加IP白名单
		servletRegistrationBean.addInitParameter("allow", "127.0.0.1");
		// 添加IP黑名单，当白名单和黑名单重复时，黑名单优先级更高
		servletRegistrationBean.addInitParameter("deny", "127.0.0.1");
		// 添加控制台管理用户
		servletRegistrationBean.addInitParameter("loginUsername", "psl");
		servletRegistrationBean.addInitParameter("loginPassword", "123456");
		// 是否能够重置数据
		servletRegistrationBean.addInitParameter("resetEnable", "false");
		return servletRegistrationBean;
	}

	/**
	 * 配置服务过滤器
	 *
	 * @return 返回过滤器配置对象
	 */
	@Bean
	public FilterRegistrationBean<WebStatFilter> statFilter() {
		FilterRegistrationBean<WebStatFilter> filterRegistrationBean = new FilterRegistrationBean<WebStatFilter>(
				new WebStatFilter());
		// 添加过滤规则
		filterRegistrationBean.addUrlPatterns("/*");
		// 忽略过滤格式
		filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*,");
		return filterRegistrationBean;
	}

}
