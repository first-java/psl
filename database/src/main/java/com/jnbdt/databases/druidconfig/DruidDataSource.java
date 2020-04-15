package com.jnbdt.databases.druidconfig;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;

/** @ClassNmame DruidDataSource.java
  * @author 奥特虾不会写代码 
  * @author E-mail:pengshiliang@latticepower.com
  * @version 1.0
  * @time 创建时间：2020年4月14日 下午5:01:12
  * @Copyright © 2020 by 奥特虾不会写代码  
*/
public class DruidDataSource {
	@ConfigurationProperties(prefix = "spring.datasource")
	@Bean
	public DruidDataSource druidDataSource(){
	      return new DruidDataSource();
	}
}

