package com.example.neoheulge.payments.dto.request;


import com.example.neoheulge.payments.dto.PayType;
import com.example.neoheulge.payments.entity.Payments;
import lombok.*;

import java.util.UUID;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentsRequestDTO {

    @NonNull
    private PayType payType;
    @NonNull
    private Long amount;
    @NonNull
    private String orderName;

    private String mySuccessUrl;
    private String myFailUrl;


    public Payments toEntity() {
        return Payments.builder()
                .paymentType(payType)
                .amount(this.amount)
                .orderId(UUID.randomUUID().toString())
                .orderName(orderName)
                .successYN(false)
                .build();
    }
}
