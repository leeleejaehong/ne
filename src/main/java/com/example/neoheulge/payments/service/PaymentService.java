package com.example.neoheulge.payments.service;

import com.example.neoheulge.member.entity.Member;
import com.example.neoheulge.member.service.MemberService;
import com.example.neoheulge.payments.config.TossPaymentConfig;
import com.example.neoheulge.payments.entity.Payments;
import com.example.neoheulge.payments.repository.JpaPaymentRepository;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Collections;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final JpaPaymentRepository paymentRepository;
    private final RestTemplate restTemplate;
    private final TossPaymentConfig tossPaymentConfig;
    private final MemberService memberService;


    public Payments createPaymentRequest(Payments payments, String userEmail) {
            Member member = memberService.findMember(userEmail);
            if (member == null) {
                member = memberService.findDefaultMember();
            }
            if (payments.getAmount() < 1000) {
                throw new RuntimeException("금액이 안됨");
            }
            payments.setCustomer(member);
            return paymentRepository.save(payments);
      }
      @Transactional
      public JSONObject confirmPayment(String paymentKey, String orderId, Long amount) {
        Payments payment = verifyPayment(orderId, amount);

        HttpHeaders headers = getHeaders();
        JSONObject requestBody = new JSONObject();
        requestBody.put("orderId", orderId);
        requestBody.put("amount", amount);
        requestBody.put("paymentKey", paymentKey);

        HttpEntity<String> request = new HttpEntity<>(requestBody.toString(), headers);
        try {
            ResponseEntity<JSONObject> response = restTemplate.postForEntity(
                    TossPaymentConfig.URL + "/confirm",
                    request,
                    JSONObject.class
            );
            JSONObject result = response.getBody();
            if (response.getStatusCode() == HttpStatus.OK) {
                payment.setPaymentKey(paymentKey);
                payment.setSuccessYN(true);
                paymentRepository.save(payment);
            } else {
                payment.setSuccessYN(false);
                payment.setFailReason(result.getAsString("message"));
                paymentRepository.save(payment);
            }
            return result;
        } catch (Exception e) {
            payment.setSuccessYN(false);
            payment.setFailReason(e.getMessage());
            paymentRepository.save(payment);
            throw new RuntimeException("Payment confirmation failed", e);
        }
    }


    public Payments verifyPayment(String orderId, Long amount) {
        Payments payment = paymentRepository.findByOrderId(orderId).orElseThrow(() -> {
            throw new RuntimeException("payment not found");
        });
        if (!payment.getAmount().equals(amount)) {
            throw new RuntimeException("payment not match");
        }
        return payment;
    }
    @Transactional
    public void tossPaymentFail(String code, String message, String orderId) {
        Payments payment = paymentRepository.findByOrderId(orderId).orElseThrow(() -> {
            throw new RuntimeException("payment not found");
        });
        payment.setSuccessYN(false);
        payment.setFailReason(message);
    }


    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        String encodedAuthKey = new String(
                Base64.getEncoder().encode((tossPaymentConfig.getTestSecretKey() + ":").getBytes(StandardCharsets.UTF_8)));
        headers.setBasicAuth(encodedAuthKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        return headers;
    }
    }

