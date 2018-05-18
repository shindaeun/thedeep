package thedeep.service;

public class NoticeVO {
	private int unq;
	private String name;
	private String pwd;
	private String title;
	private String content;
	private String filename;
	private String rdate;
	private int hit;
	
	private int nexInt;
	private int befInt;
	
	public int getNexInt() {
		return nexInt;
	}
	public void setNexInt(int nexInt) {
		this.nexInt = nexInt;
	}
	public int getBefInt() {
		return befInt;
	}
	public void setBefInt(int befInt) {
		this.befInt = befInt;
	}
	public int getUnq() {
		return unq;
	}
	public void setUnq(int unq) {
		this.unq = unq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
}
