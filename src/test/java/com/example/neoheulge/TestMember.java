//package com.example.neoheulge;
//
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Builder;
//import lombok.Getter;
//import lombok.Setter;
//import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
//
//import java.time.LocalDate;
//
//
//@DataJpaTest
//    @Entity
//    @Getter
//    @Builder
//    @Setter
//    @AllArgsConstructor
//    public class TestMember {
//
//        @Id
//        @Column(name = "memberID")
//        private String memberId;
//
//        @Column(name = "name", nullable = false, length = 100)
//        private String name;
//
//        @Column(name = "email", length = 100)
//        private String email;
//
//        @Column(name = "phone", length = 20)
//        private String phone;
//
//        @Column(name = "profile", length = 255)
//        private String profile;
//
//        @Column(name = "nickname", length = 100)
//        private String nickname;
//
//        @Column(name = "grade", length = 20)
//        private String grade;
//
//        @Column(name = "password", length = 255)
//        private String password;
//
//        @Column(name = "signup_date")
//        private LocalDate signupDate;
//
//        @OneToOne(mappedBy = "member", cascade = CascadeType.REMOVE)
//        private TestAccount account;
//
//
//        protected TestMember() {}
//}
