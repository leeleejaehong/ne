package com.example.neoheulge.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
    private int id;
    private String author;
    private String subject;
    private String content;
    private String createtime;
    private int views;
    private int re_step;
    private int re_level;
}
