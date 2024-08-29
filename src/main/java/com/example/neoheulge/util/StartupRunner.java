package com.example.neoheulge.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class StartupRunner implements CommandLineRunner {

    @Autowired
    private NotificationService notificationService;

    @Override //메일발송 테스트 (어플리케이션실행시 발송)
    public void run(String... args) throws Exception {
        notificationService.sendErrorNotification("Test Email", "This is a test email to verify mail configuration.");
    }
}
