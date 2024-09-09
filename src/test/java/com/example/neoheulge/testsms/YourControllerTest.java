package com.example.neoheulge.testsms;

import com.example.neoheulge.member.web.MemberController;
import com.example.neoheulge.util.SmsUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class YourControllerTest {

    @InjectMocks
    private MemberController memberController;

    @Mock
    private SmsUtil smsUtil;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void sendSmsToFindEmail_shouldSendSmsAndReturnRandomNumber() {
        // Given
        String phone = "010-1234-5678";
        MockHttpServletRequest request = new MockHttpServletRequest();

        // When
        ResponseEntity<?> responseEntity = memberController.sendSmsToFindEmail(phone, request);

        // Then
        assertTrue(responseEntity.getStatusCode().is2xxSuccessful());
        assertNotNull(responseEntity.getBody());

        verify(smsUtil).sendOne(eq("01012345678"), anyString());

        @SuppressWarnings("unchecked")
        Map<String, Object> responseBody = (Map<String, Object>) responseEntity.getBody();
        assertNotNull(responseBody.get("check"));
        assertTrue(responseBody.get("check") instanceof String);
        assertEquals(4, ((String) responseBody.get("check")).length());
    }
}