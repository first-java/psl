package com.jnbdt;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
@MapperScan("com.jnbdt.dao")
public class DevelopmentApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(DevelopmentApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
 
		return builder.sources(DevelopmentApplication.class);
	}

}
