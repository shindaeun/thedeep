package thedeep.service;

public class PointVO {
	private String userid;
	private String content;
	private int usepoint;
	private int savepoint;
	private int ablepoint;
	private String rdate;
	public PointVO(){}
	public PointVO(String userid, String content, int usepoint, int savepoint, int ablepoint, String rdate) {
		super();
		this.userid = userid;
		this.content = content;
		this.usepoint = usepoint;
		this.savepoint = savepoint;
		this.ablepoint = ablepoint;
		this.rdate = rdate;
	}
	public String getRdate() {
		return rdate;
	}
	
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public int getAblepoint() {
		return ablepoint;
	}
	public void setAblepoint(int ablepoint) {
		this.ablepoint = ablepoint;
	}
}
