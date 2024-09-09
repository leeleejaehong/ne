//package com.example.neoheulge.testsms;
//import com.example.neoheulge.member.service.MemberService;
//import com.example.neoheulge.member.web.MemberController;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.MockitoAnnotations;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//
//import java.util.Map;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.Mockito.*;
//
//class MemberControllerTest {
//
//    @InjectMocks
//    private MemberController yourController;
//
//    @Mock
//    private MemberService memberService;
//
//    @BeforeEach
//    void setUp() {
//        MockitoAnnotations.openMocks(this);
//    }
//
//    @Test
//    void validateNumber_whenPhoneIsRegistered_returnsExistingStatus() {
//        // Given
//        String phone = "01012345678";
//        when(memberService.isPhoneNumberRegistered(phone)).thenReturn(true);
//
//        // When
////        ResponseEntity<Map<String, String>> response = yourController.validateNumber(phone);
//
//        // Then
//        assertEquals(HttpStatus.OK, response.getStatusCode());
//        assertNotNull(response.getBody());
//        assertEquals("existing", response.getBody().get("status"));
//        assertEquals("이미 가입되어 있는 계정입니다.", response.getBody().get("message"));
//    }
//
//    @Test
//    void validateNumber_whenPhoneIsNotRegistered_returnsNewStatus() {
//        // Given
//        String phone = "01079079411";
//        when(memberService.isPhoneNumberRegistered(phone)).thenReturn(false);
//
//        // When
//        ResponseEntity<Map<String, String>> response = yourController.validateNumber(phone);
//
//        // Then
//        assertEquals(HttpStatus.OK, response.getStatusCode());
//        assertNotNull(response.getBody());
//        assertEquals("new", response.getBody().get("status"));
//        assertEquals("신규 가입이 가능합니다.", response.getBody().get("message"));
//    }
//
//    @Test
//    void validateNumber_whenExceptionOccurs_returnsInternalServerError() {
//        // Given
//        String phone = "01012345678";
//        when(memberService.isPhoneNumberRegistered(phone)).thenThrow(new RuntimeException("Test exception"));
//
//        // When
//        ResponseEntity<Map<String, String>> response = yourController.validateNumber(phone);
//
//        // Then
//        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, response.getStatusCode());
//        assertNotNull(response.getBody());
//        assertEquals("서버 오류가 발생했습니다.", response.getBody().get("error"));
//    }
//}
