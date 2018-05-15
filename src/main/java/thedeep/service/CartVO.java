package thedeep.service;

public class CartVO {
	String userid,pcode,cscode;
	int amount;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	
}
