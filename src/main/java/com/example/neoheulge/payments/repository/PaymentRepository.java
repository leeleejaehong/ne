package com.example.neoheulge.payments.repository;

import com.example.neoheulge.payments.entity.Payments;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PaymentRepository extends JpaRepository<Payments, Long> {

    Optional<Payments> findByOrderId(String orderId);


}
