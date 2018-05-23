package thedeep.service;

public class CartVO {
	private String userid,pcode,cscode,pname,filename,cssize,cscolor;
	private int amount,price,savepoint;
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCssize() {
		return cssize;
	}
	public void setCssize(String cssize) {
		this.cssize = cssize;
	}
	public String getCscolor() {
		return cscolor;
	}
	public void setCscolor(String cscolor) {
		this.cscolor = cscolor;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSavepoint() {
		return savepoint;
	}
	public void setSavepoint(int savapoint) {
		this.savepoint = savapoint;
	}
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
