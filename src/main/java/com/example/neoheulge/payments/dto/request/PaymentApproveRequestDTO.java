package com.example.neoheulge.payments.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentApproveRequestDTO {
    private String orderId;
    private Long amount;
    private String paymentKey;
}