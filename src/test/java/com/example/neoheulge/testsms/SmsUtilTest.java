package com.example.neoheulge.testsms;

import com.example.neoheulge.util.SmsUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.util.ReflectionTestUtils;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class SmsUtilTest {

    @InjectMocks
    private SmsUtil smsUtil;

    @Mock
    private DefaultMessageService messageService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        ReflectionTestUtils.setField(smsUtil, "apiKey", "testApiKey");
        ReflectionTestUtils.setField(smsUtil, "apiSecretKey", "testApiSecretKey");
        ReflectionTestUtils.setField(smsUtil, "messageService", messageService);
    }

    @Test
    void sendOne_shouldSendMessage() {
        // Given
        String to = "01012345678";
        String verificationCode = "1234";
        SingleMessageSentResponse mockResponse = mock(SingleMessageSentResponse.class);

        when(messageService.sendOne(any(SingleMessageSendingRequest.class))).thenReturn(mockResponse);

        // When
        SingleMessageSentResponse response = smsUtil.sendOne(to, verificationCode);

        // Then
        assertNotNull(response);
        verify(messageService).sendOne(argThat(request -> {
            Message message = request.getMessage();
            return message.getFrom().equals("01079079411") &&
                   message.getTo().equals(to) &&
                   message.getText().contains(verificationCode);
        }));
    }
}