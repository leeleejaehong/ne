package com.example.neoheulge.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
	
    @Autowired
    private JavaMailSender mailSender;
    
    private static final Logger logger = LoggerFactory.getLogger(NotificationService.class);
    
    public void sendErrorNotification(String subject, String errorMessage) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("yjhwkdgh961010@gmail.com");
        message.setTo("yjhwkdgh961010@gmail.com"); // 수신자 이메일
        message.setSubject(subject);
        message.setText("Scheduler error occurred:\n\n" + errorMessage);

        try {
            mailSender.send(message);
            logger.info("Error notification sent successfully to yjhwkdgh96@naver.com");
        } catch (Exception e) {
            logger.error("Failed to send error notification: {}", e.getMessage(), e);
        }
    }
}
