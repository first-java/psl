package com.jnbdt;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;

import org.springframework.web.bind.annotation.RestController;

@RestController
@EnableAutoConfiguration

public class PslApplication {

	public static void main(String[] args) {
		SpringApplication.run(PslApplication.class, args);
	}

}
