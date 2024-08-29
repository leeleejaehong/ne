//package com.example.neoheulge;
//
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.Data;
//import lombok.Getter;
//import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
//
//@DataJpaTest
//@Entity
//@Data
//@Getter
//@Builder
//@AllArgsConstructor
//public class TestAccount {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "acount_id")
//    private int accountId;
//
//    @Column(name = "acount_number")
//    private String accountNumber;
//
//    @Column(name = "money")
//    private String balance;
//
//    @Column(name = "ACOUNT_STATUS", columnDefinition = "CHAR(1) default 'N'")
//    private Character accountStatus = 'N';
//
//    @OneToOne
//    private TestMember member;
//
//    public void add(TestMember member) {
//        member.setAccount(this);
//    }
//    public TestAccount() {
//
//    }
//}