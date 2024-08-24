package com.example.neoheulge.member.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.hibernate.annotations.Immutable;

import java.time.LocalDate;

@Entity
@Table(name = "NEMEMBER")
@Immutable
@Getter
@Builder
@AllArgsConstructor
public class Member {

    @Id
    @Column(name = "memberID")
    private String memberId;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "email", length = 100)
    private String email;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "profile", length = 255)
    private String profile;

    @Column(name = "nickname", length = 100)
    private String nickname;

    @Column(name = "grade", length = 20)
    private String grade;

    @Column(name = "password", length = 255)
    private String password;

    @Column(name = "signup_date")
    private LocalDate signupDate;

    protected Member() {}


}
