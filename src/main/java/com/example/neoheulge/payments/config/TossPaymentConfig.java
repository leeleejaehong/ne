package com.example.neoheulge.payments.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
@Getter
public class TossPaymentConfig {

    @Value("${toss.api.cliKey}")
    private  String testCliKey;

    @Value("${toss.api.secretKey}")
    private  String testSecretKey;

    public static final String URL = "https://api.tosspayments.com/v1/payments";

}
