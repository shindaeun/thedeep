package thedeep.service;

import java.util.List;

public class OrderListVO {
	private String ocode,pcode,cscode;
	private int amount,totalmoney;
	private List<OrderListVO> olist;
	public List<OrderListVO> getOlist() {
		return olist;
	}
	public void setOlist(List<OrderListVO> olist) {
		this.olist = olist;
	}
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getCscode() {
		return cscode;
	}
	public void setCscode(String cscode) {
		this.cscode = cscode;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(int totalmoney) {
		this.totalmoney = totalmoney;
	}
}
