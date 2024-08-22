package com.example.neoheulge.payments.controller;


import com.example.neoheulge.payments.config.TossPaymentConfig;
import com.example.neoheulge.payments.dto.PaymentFailDto;
import com.example.neoheulge.payments.dto.request.PaymentsRequestDTO;
import com.example.neoheulge.payments.dto.response.PaymentResponseDTO;
import com.example.neoheulge.payments.entity.Payments;
import com.example.neoheulge.payments.service.PaymentService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@Validated
@RequestMapping("/api/v1/payments")
@RequiredArgsConstructor
public class TossPaymentController {


    private final PaymentService paymentService;
    private final TossPaymentConfig tossPaymentConfig;

    //추후 @AuthenticationPrincipal 어노테이션 통해서 로그인 상태에서 결제 할 수 있게 보완 해야함
    @PostMapping("/toss")
    public ResponseEntity<PaymentResponseDTO> requestPayment(@RequestBody PaymentsRequestDTO request) {
        String testEmail = "kim@kim.com";
        PaymentResponseDTO paymentResDto = paymentService.createPaymentRequest(request.toEntity(), testEmail).toPaymentResDto();
        paymentResDto.setSuccessUrl(request.getMySuccessUrl() == null ? tossPaymentConfig.getSuccessUrl() : request.getMySuccessUrl());
        paymentResDto.setFailUrl(request.getMyFailUrl() == null ? tossPaymentConfig.getFailUrl() : request.getMyFailUrl());
        System.out.println("paymentResDto = " + paymentResDto.getPayType() + " " + paymentResDto.getAmount());
        return ResponseEntity.ok().body(paymentResDto);

    }
    @PostMapping("/confirm")
    public ResponseEntity<JSONObject> confirmPayment(@RequestBody Payments request) {
        JSONObject result = paymentService.confirmPayment(
                request.getPaymentKey(),
                request.getOrderId(),
                request.getAmount()
        );
        System.out.println("result = " + result.toJSONString());
        return ResponseEntity.ok(result);
    }
//    @GetMapping("/toss/success")
//    public ResponseEntity tossPaymentSuccess(
//            @RequestParam String paymentKey,
//            @RequestParam String orderId,
//            @RequestParam Long amount
//    ) {
//        System.out.println("paymentService = " + paymentService.tossPaymentSuccess(paymentKey, orderId, amount));
//        return ResponseEntity.ok().contentType(MediaType.APPLICATION_JSON).body(paymentService.tossPaymentSuccess(paymentKey, orderId, amount));
//    }
    @PostMapping("/toss/fail")
    public ResponseEntity tossPaymentFail(
            @RequestParam String code,
            @RequestParam String message,
            @RequestParam String orderId
    ) {
        paymentService.tossPaymentFail(code, message, orderId);
        return ResponseEntity.ok().body(
                PaymentFailDto.builder()
                        .errorCode(code)
                        .errorMessage(message)
                        .orderId(orderId)
                        .build()
        );
    }
//    @PostMapping("/approve/{paymentKey}")
//    public ResponseEntity<PaymentResponseDTO> approvePayment(@PathVariable String paymentKey,
//                                                             @RequestParam String orderId,
//                                                             @RequestParam Long amount) {
//        PaymentResponseDTO response = paymentService.approvePayment(paymentKey, orderId, amount);
//        return ResponseEntity.ok(response);
//    }
//
//    @GetMapping("/{orderId}")
//    public ResponseEntity<PaymentResponseDTO> getPayment(@PathVariable SuccessDTO successDTO) {
//        PaymentResponseDTO response = paymentService.getPayment(successDTO);
//        return ResponseEntity.ok(response);
//    }
}