package com.example.neoheulge.payments.dto.response;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentResponseDTO {

    private String payType;

    private Long amount;

    private String productType;

    private String orderName;

    private String orderId;

    private String customerEmail;

    private String customerName;

    private String customerMobilePhone;

    private String successUrl;

    private String failUrl;


}
