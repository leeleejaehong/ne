package com.example.neoheulge.payments.util;

import com.example.neoheulge.payments.config.TossPaymentConfig;
import org.springframework.stereotype.Component;

import java.util.Base64;

@Component
public class TossPaymentAuthUtil {

    private final TossPaymentConfig tossPaymentConfig;

    public TossPaymentAuthUtil(TossPaymentConfig tossPaymentConfig) {
        this.tossPaymentConfig = tossPaymentConfig;
    }


    public String getBasicAuthHeader() {
        String secretKey = tossPaymentConfig.getTestSecretKey();
        String authString = secretKey + ":";
        String encodedAuthString = Base64.getEncoder().encodeToString(authString.getBytes());
        return "Basic " + encodedAuthString;
    }
}