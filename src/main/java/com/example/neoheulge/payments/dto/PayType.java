package com.example.neoheulge.payments.dto;

public enum PayType {

    CARD("카드"),
    TRANSFER("계좌이체");;

    private String description;

    PayType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

}
