//package com.example.neoheulge;
//
//import org.junit.jupiter.api.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
//import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.TestPropertySource;
//import org.springframework.test.context.junit4.SpringRunner;
//@RunWith(SpringRunner.class)
//@DataJpaTest
//@TestPropertySource(locations = "classpath:application.properties")
//@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
//class NeoheulgeApplicationTests {
//
//	@Autowired
//	MemberRepository memberRepository;
//	@Autowired
//	AccountRepository accountRepository;
//	@Test
//	void contextLoads() {
//		TestAccount account = new TestAccount();
//		account.setAccountNumber("123124124");
//
//		TestMember member = new TestMember();
//		member.setMemberId("test");
//
//		account.add(member);
//
//		memberRepository.save(member);
//	}
//
//}
