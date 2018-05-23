package thedeep.service;

public class ProductVO {
	//product
	private String cscode;
	private String pcode;
	private String pname;
	private int price;
	private String gcode;
	private String soldout;
	private String wait;
	private String mainfile;
	private String filename;
	
	private int maxpcode;
	public int getMaxpcode() {
		return maxpcode;
	}
	public void setMaxpcode(int maxpcode) {
		this.maxpcode = maxpcode;
	}
	private int point;
	
	//stock
	private String psize;
	private String color;
	private int amount;
	
	public String getCscode() {
		return cscode;
	}
	public void setCscode(String cscode) {
		this.cscode = cscode;
	}
	public String getGcode() {
		return gcode;
	}
	public void setGcode(String gcode) {
		this.gcode = gcode;
	}
	public String getSoldout() {
		return soldout;
	}
	public void setSoldout(String soldout) {
		this.soldout = soldout;
	}
	public String getWait() {
		return wait;
	}
	public void setWait(String wait) {
		this.wait = wait;
	}
	public String getMainfile() {
		return mainfile;
	}
	public void setMainfile(String mainfile) {
		this.mainfile = mainfile;
	}
	public String getPsize() {
		return psize;
	}
	public void setPsize(String psize) {
		this.psize = psize;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
}
