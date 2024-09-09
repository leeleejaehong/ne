package com.example.neoheulge.testsms;

import com.example.neoheulge.member.entity.Member;
import com.example.neoheulge.member.repository.JpaMemberRepository;
import com.example.neoheulge.member.repository.MemberRepository;
import com.example.neoheulge.member.service.MemberService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class MemberServiceTest {

    @InjectMocks
    private MemberService memberService;

    @Mock
    private JpaMemberRepository memberRepository;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void isPhoneNumberRegistered_whenPhoneExists_returnsTrue() {
        // Given
        String phone = "01079079411";
        when(memberRepository.findByPhone(phone)).thenReturn(Optional.of(new Member()));

        // When
        boolean result = memberService.isPhoneNumberRegistered(phone);

        // Then
        assertTrue(result);
        verify(memberRepository).findByPhone(phone);
    }

    @Test
    void isPhoneNumberRegistered_whenPhoneDoesNotExist_returnsFalse() {
        // Given
        String phone = "01012345678";
        when(memberRepository.findByPhone(phone)).thenReturn(Optional.empty());

        // When
        boolean result = memberService.isPhoneNumberRegistered(phone);

        // Then
        assertFalse(result);
        verify(memberRepository).findByPhone(phone);
    }
}