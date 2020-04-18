package com.csp.reportquery;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan({"com.csp.reportquery.dao"})
public class ReportqueryCsp1Application {
    public ReportqueryCsp1Application() {
    }

    public static void main(String[] args) {
        SpringApplication.run(ReportqueryCsp1Application.class, args);
    }
}
