package com.example.neoheulge.dto;

import lombok.Data;

@Data
public class CommuDTO {
	private int id;        			//게시물 번호, 기본 키
	private String author;          //작성자 이름
	private String subject;			//게시물 제목
	private String content;         //게시물 내용
	private String createtime;      //작성 시간
	private int views;         		//조회수
	private int re_step;       		//답글의 순서
	private int re_level;       	//답글의 레벨 (깊이)
	
}
