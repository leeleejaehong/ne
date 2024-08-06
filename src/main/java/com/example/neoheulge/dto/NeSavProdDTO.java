package com.example.neoheulge.dto;

import java.math.BigDecimal;
import java.util.Date;

public class NeSavProdDTO {

    private String productCode;
    private String productName;
    private BigDecimal baseRate;
    private BigDecimal goldenballRate;
    private String subscriptionMethod;
    private String subscriptionPeriod;
    private BigDecimal accumulatedAmount;
    private String terminationConditions;
    private BigDecimal earlyFee;
    private String productStatus;
    private BigDecimal minimumDeposit;
    private BigDecimal maximumDeposit;
    private Date startDate;
    private Date endDate;
    private String productDescription;



    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getBaseRate() {
        return baseRate;
    }

    public void setBaseRate(BigDecimal baseRate) {
        this.baseRate = baseRate;
    }

    public BigDecimal getGoldenballRate() {
        return goldenballRate;
    }

    public void setGoldenballRate(BigDecimal goldenballRate) {
        this.goldenballRate = goldenballRate;
    }

    public String getSubscriptionMethod() {
        return subscriptionMethod;
    }

    public void setSubscriptionMethod(String subscriptionMethod) {
        this.subscriptionMethod = subscriptionMethod;
    }

    public String getSubscriptionPeriod() {
        return subscriptionPeriod;
    }

    public void setSubscriptionPeriod(String subscriptionPeriod) {
        this.subscriptionPeriod = subscriptionPeriod;
    }

    public BigDecimal getAccumulatedAmount() {
        return accumulatedAmount;
    }

    public void setAccumulatedAmount(BigDecimal accumulatedAmount) {
        this.accumulatedAmount = accumulatedAmount;
    }

    public String getTerminationConditions() {
        return terminationConditions;
    }

    public void setTerminationConditions(String terminationConditions) {
        this.terminationConditions = terminationConditions;
    }

    public BigDecimal getEarlyFee() {
        return earlyFee;
    }

    public void setEarlyFee(BigDecimal earlyFee) {
        this.earlyFee = earlyFee;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    public BigDecimal getMinimumDeposit() {
        return minimumDeposit;
    }

    public void setMinimumDeposit(BigDecimal minimumDeposit) {
        this.minimumDeposit = minimumDeposit;
    }

    public BigDecimal getMaximumDeposit() {
        return maximumDeposit;
    }

    public void setMaximumDeposit(BigDecimal maximumDeposit) {
        this.maximumDeposit = maximumDeposit;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }
}
