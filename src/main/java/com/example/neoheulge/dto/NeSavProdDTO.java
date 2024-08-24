	package com.example.neoheulge.dto;

import java.math.BigDecimal;
import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class NeSavProdDTO {

	private String product_code;
    private String product_name;
    private String product_image;
    private BigDecimal base_rate;
    private BigDecimal goldenball_rate;
    private String subscription_method;
    private String subscription_period;
    private BigDecimal accumulated_amount;
    private String termination_conditions;
    private BigDecimal early_fee;
    private String product_status;
    private BigDecimal minimum_deposit;
    private BigDecimal maximum_deposit;
    private Date start_date;
    private Date end_date;
    private String product_description;
    private MultipartFile file;
    private int numberOfSubscribers;
    private String winner;
    
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public BigDecimal getBase_rate() {
		return base_rate;
	}
	public void setBase_rate(BigDecimal base_rate) {
		this.base_rate = base_rate;
	}
	public BigDecimal getGoldenball_rate() {
		return goldenball_rate;
	}
	public void setGoldenball_rate(BigDecimal goldenball_rate) {
		this.goldenball_rate = goldenball_rate;
	}
	public String getSubscription_method() {
		return subscription_method;
	}
	public void setSubscription_method(String subscription_method) {
		this.subscription_method = subscription_method;
	}
	public String getSubscription_period() {
		return subscription_period;
	}
	public void setSubscription_period(String subscription_period) {
		this.subscription_period = subscription_period;
	}
	public BigDecimal getAccumulated_amount() {
		return accumulated_amount;
	}
	public void setAccumulated_amount(BigDecimal accumulated_amount) {
		this.accumulated_amount = accumulated_amount;
	}
	public String getTermination_conditions() {
		return termination_conditions;
	}
	public void setTermination_conditions(String termination_conditions) {
		this.termination_conditions = termination_conditions;
	}
	public BigDecimal getEarly_fee() {
		return early_fee;
	}
	public void setEarly_fee(BigDecimal early_fee) {
		this.early_fee = early_fee;
	}
	public String getProduct_status() {
		return product_status;
	}
	public void setProduct_status(String product_status) {
		this.product_status = product_status;
	}
	public BigDecimal getMinimum_deposit() {
		return minimum_deposit;
	}
	public void setMinimum_deposit(BigDecimal minimum_deposit) {
		this.minimum_deposit = minimum_deposit;
	}
	public BigDecimal getMaximum_deposit() {
		return maximum_deposit;
	}
	public void setMaximum_deposit(BigDecimal maximum_deposit) {
		this.maximum_deposit = maximum_deposit;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getProduct_description() {
		return product_description;
	}
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	public int getNumberOfSubscribers() {
		return numberOfSubscribers;
	}
	public void setNumberOfSubscribers(int numberOfSubscribers) {
		this.numberOfSubscribers = numberOfSubscribers;
	}
	public String getWinner() {
		return winner;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
    
    
    
}
