package com.example.neoheulge.member.repository;


import com.example.neoheulge.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

public interface JpaMemberRepository extends JpaRepository<Member, String>, MemberRepository {

    Optional<Member> findByEmail(String email);
    //Member findByMemberName(String memberId);
    Optional<Member> findByPhone(String phone);
}

