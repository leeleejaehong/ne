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
    private Long amount; // 가격 정보
    @NonNull
    private String orderName; // 주문명

    private String mySuccessUrl; // 성공 시 리다이렉트 될 URL
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
