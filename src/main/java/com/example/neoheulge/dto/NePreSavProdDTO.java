package com.example.neoheulge.dto;

import java.math.BigDecimal;
import java.util.Date;

public class NePreSavProdDTO {
    private String subscription_id;
    private String member_id;
    private String product_code;
    private Date subscription_date;
    private BigDecimal subscription_amount;
    private String subscription_select;
    private Date termination_date;
    private String status;
    private BigDecimal early_refund;
    private BigDecimal total_payment;
    private String auto_enabled;
    private BigDecimal auto_amount;
    private String auto_cycle;
    private String auto_account;
    private String auto_date;
    
	public String getSubscription_id() {
		return subscription_id;
	}
	public void setSubscription_id(String subscription_id) {
		this.subscription_id = subscription_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public Date getSubscription_date() {
		return subscription_date;
	}
	public void setSubscription_date(Date subscription_date) {
		this.subscription_date = subscription_date;
	}
	public BigDecimal getSubscription_amount() {
		return subscription_amount;
	}
	public void setSubscription_amount(BigDecimal subscription_amount) {
		this.subscription_amount = subscription_amount;
	}
	public String getSubscription_select() {
		return subscription_select;
	}
	public void setSubscription_select(String subscription_select) {
		this.subscription_select = subscription_select;
	}
	public Date getTermination_date() {
		return termination_date;
	}
	public void setTermination_date(Date termination_date) {
		this.termination_date = termination_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BigDecimal getEarly_refund() {
		return early_refund;
	}
	public void setEarly_refund(BigDecimal early_refund) {
		this.early_refund = early_refund;
	}
	public BigDecimal getTotal_payment() {
		return total_payment;
	}
	public void setTotal_payment(BigDecimal total_payment) {
		this.total_payment = total_payment;
	}
	public String getAuto_enabled() {
		return auto_enabled;
	}
	public void setAuto_enabled(String auto_enabled) {
		this.auto_enabled = auto_enabled;
	}
	public BigDecimal getAuto_amount() {
		return auto_amount;
	}
	public void setAuto_amount(BigDecimal auto_amount) {
		this.auto_amount = auto_amount;
	}
	public String getAuto_cycle() {
		return auto_cycle;
	}
	public void setAuto_cycle(String auto_cycle) {
		this.auto_cycle = auto_cycle;
	}
	public String getAuto_account() {
		return auto_account;
	}
	public void setAuto_account(String auto_account) {
		this.auto_account = auto_account;
	}
	public String getAuto_date() {
		return auto_date;
	}
	public void setAuto_date(String auto_date) {
		this.auto_date = auto_date;
	}
    
    
}

