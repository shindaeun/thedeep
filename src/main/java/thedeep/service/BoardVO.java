package thedeep.service;

public class BoardVO {
	
	private int unq;
	private String pcode;
	private String name;
	private String pwd;
	private String title;
	private String content;
	private String filename;
	private String rdate;
	private int hit;
	private int fid;
	private String forder;
	private int filesize;
	private String userid;
	private String delfilename;
	
	private String repwd;

	private int nexInt;
	private int befInt;
	
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	public int getUnq() {
		return unq;
	}
	public void setUnq(int unq) {
		this.unq = unq;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
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
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getForder() {
		return forder;
	}
	public void setForder(String forder) {
		this.forder = forder;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDelfilename() {
		return delfilename;
	}
	public void setDelfilename(String delfilename) {
		this.delfilename = delfilename;
	}
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
	public String getRepwd() {
		return repwd;
	}
	public void setRepwd(String repwd) {
		this.repwd = repwd;
	}
	
}
