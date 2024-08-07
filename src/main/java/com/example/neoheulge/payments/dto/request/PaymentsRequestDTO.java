package com.example.neoheulge.payments.dto.request;


import com.example.neoheulge.payments.entity.Payments;
import lombok.*;

import java.util.UUID;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class PaymentsRequestDTO {

    @NonNull
    private static final String payType = "CARD";
    @NonNull
    private Long amount;
    @NonNull
    private String orderName;

    private String mySuccessUrl;
    private String myFailUrl;

    public Payments toEntity() {
        return Payments.builder()
                .paymentType(payType)
                .amount(amount)
                .orderName(orderName)
                .orderId(UUID.randomUUID().toString())
                .build();
    }

}
