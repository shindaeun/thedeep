package thedeep.service;

public class CouponVO {
	private String ccode;
	private String userid;
	private String sdate;
	private String edate;
	
	private String cname;
	private int applymoney;
	private int discountrate;
	private int maxdiscmoney;
	
	public String getCcode() {
		return ccode;
	}
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public int getApplymoney() {
		return applymoney;
	}
	public void setApplymoney(int applymoney) {
		this.applymoney = applymoney;
	}
	public int getDiscountrate() {
		return discountrate;
	}
	public void setDiscountrate(int discountrate) {
		this.discountrate = discountrate;
	}
	public int getMaxdiscmoney() {
		return maxdiscmoney;
	}
	public void setMaxdiscmoney(int maxdiscmoney) {
		this.maxdiscmoney = maxdiscmoney;
	}
	
}
