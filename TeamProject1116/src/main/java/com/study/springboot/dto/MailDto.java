package com.study.springboot.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class MailDto {
    private String address;
    private String title;
    private String message;
}
