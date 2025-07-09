package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoTcsChallengeApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoTcsChallengeApplication.class, args);
	}

	@GetMapping("/hello")
    public String hello() {
        return "Hola desde Spring Boot!";
	}
}
