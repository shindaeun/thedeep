package thedeep.service;

public class OrderVO {
	private String ocode,userid,payresult,paymethod,depositname,adminmemo,odate,usecoupon;
	public String getUsecoupon() {
		return usecoupon;
	}
	public void setUsecoupon(String usecoupon) {
		this.usecoupon = usecoupon;
	}
	private int totalmoney,usepoint,savepoint;
	public String getOcode() {
		return ocode;
	}
	public void setOcode(String ocode) {
		this.ocode = ocode;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPayresult() {
		return payresult;
	}
	public void setPayresult(String payresult) {
		this.payresult = payresult;
	}
	public String getPaymethod() {
		return paymethod;
	}
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public String getDepositname() {
		return depositname;
	}
	public void setDepositname(String depositname) {
		this.depositname = depositname;
	}
	public String getAdminmemo() {
		return adminmemo;
	}
	public void setAdminmemo(String adminmemo) {
		this.adminmemo = adminmemo;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public int getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(int totalmoney) {
		this.totalmoney = totalmoney;
	}
	public int getUsepoint() {
		return usepoint;
	}
	public void setUsepoint(int usepoint) {
		this.usepoint = usepoint;
	}
	public int getSavepoint() {
		return savepoint;
	}
	public void setSavepoint(int savepoint) {
		this.savepoint = savepoint;
	}

}
