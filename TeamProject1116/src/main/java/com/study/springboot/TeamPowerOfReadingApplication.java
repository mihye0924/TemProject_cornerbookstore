package com.study.springboot;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(basePackages = "com.study.springboot")
public class TeamPowerOfReadingApplication {

	public static void main(String[] args) {
		SpringApplication.run(TeamPowerOfReadingApplication.class, args);
	}

}
