package thedeep.service;

import java.math.BigDecimal;
import java.util.Date;

public class PaymentVO {
	private String merchant_uid,buyer_name,buyer_addr,buyer_postcode,status;
	private Date cancelled_at;
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getBuyer_name() {
		return buyer_name;
	}
	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}
	public String getBuyer_addr() {
		return buyer_addr;
	}
	public void setBuyer_addr(String buyer_addr) {
		this.buyer_addr = buyer_addr;
	}
	public String getBuyer_postcode() {
		return buyer_postcode;
	}
	public void setBuyer_postcode(String buyer_postcode) {
		this.buyer_postcode = buyer_postcode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCancelled_at() {
		return cancelled_at;
	}
	public void setCancelled_at(Date cancelled_at) {
		this.cancelled_at = cancelled_at;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	private BigDecimal amount;
	public PaymentVO(String merchant_uid,BigDecimal amount, String name,String tel,String post_code,String addr,String status,Date date){
		this.amount=amount;
		this.merchant_uid = merchant_uid;
		this.buyer_name = name;
		this.buyer_addr = addr;
		this.buyer_postcode=post_code;
		this.status = status;
		this.cancelled_at = cancelled_at;
	}
}
