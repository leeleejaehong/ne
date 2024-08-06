package com.example.neoheulge.dto;

import java.math.BigDecimal;
import java.util.Date;

public class NePreSavProdDTO {
	private String subscriptionId;
    private String memberId;
    private String productCode;
    private Date subscriptionDate;
    private BigDecimal subscriptionAmount;
    private Date terminationDate;
    private String status;
    private BigDecimal earlyRefund;
    private BigDecimal interestPayment;
    private String autoEnabled;
    private BigDecimal autoAmount;
    private String autoCycle;
    private String autoAccount;
    private String autoDate;

 

    public String getSubscriptionId() {
        return subscriptionId;
    }

    public void setSubscriptionId(String subscriptionId) {
        this.subscriptionId = subscriptionId;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public Date getSubscriptionDate() {
        return subscriptionDate;
    }

    public void setSubscriptionDate(Date subscriptionDate) {
        this.subscriptionDate = subscriptionDate;
    }

    public BigDecimal getSubscriptionAmount() {
        return subscriptionAmount;
    }

    public void setSubscriptionAmount(BigDecimal subscriptionAmount) {
        this.subscriptionAmount = subscriptionAmount;
    }

    public Date getTerminationDate() {
        return terminationDate;
    }

    public void setTerminationDate(Date terminationDate) {
        this.terminationDate = terminationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getEarlyRefund() {
        return earlyRefund;
    }

    public void setEarlyRefund(BigDecimal earlyRefund) {
        this.earlyRefund = earlyRefund;
    }

    public BigDecimal getInterestPayment() {
        return interestPayment;
    }

    public void setInterestPayment(BigDecimal interestPayment) {
        this.interestPayment = interestPayment;
    }

    public String getAutoEnabled() {
        return autoEnabled;
    }

    public void setAutoEnabled(String autoEnabled) {
        this.autoEnabled = autoEnabled;
    }

    public BigDecimal getAutoAmount() {
        return autoAmount;
    }

    public void setAutoAmount(BigDecimal autoAmount) {
        this.autoAmount = autoAmount;
    }

    public String getAutoCycle() {
        return autoCycle;
    }

    public void setAutoCycle(String autoCycle) {
        this.autoCycle = autoCycle;
    }

    public String getAutoAccount() {
        return autoAccount;
    }

    public void setAutoAccount(String autoAccount) {
        this.autoAccount = autoAccount;
    }

    public String getAutoDate() {
        return autoDate;
    }

    public void setAutoDate(String autoDate) {
        this.autoDate = autoDate;
    }
}

