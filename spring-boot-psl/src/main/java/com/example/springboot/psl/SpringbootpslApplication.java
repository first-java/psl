package com.example.springboot.psl;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.example.springboot.psl.dao")
public class SpringbootpslApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootpslApplication.class, args);

	}

}
