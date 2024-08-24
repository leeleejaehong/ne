package com.example.neoheulge.payments.repository;

import com.example.neoheulge.payments.entity.Payments;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface JpaPaymentRepository extends JpaRepository<Payments, Long> {

    Optional<Payments> findByOrderId(String orderId);


}
