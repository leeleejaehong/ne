package com.example.neoheulge.member.repository;


import com.example.neoheulge.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;


public interface JpaMemberRepository extends JpaRepository<Member, String>, MemberRepository {

    Optional<Member> findByEmail(String email);
    Optional<Member> findByName(String name);
    //Member findByMemberName(String memberId);

}

