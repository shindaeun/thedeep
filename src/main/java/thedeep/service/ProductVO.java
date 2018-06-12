package thedeep.service;

import org.springframework.web.multipart.MultipartFile;

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
	private String editor;
	
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}

	private int maxpcode;
	public int getMaxpcode() {
		return maxpcode;
	}
	public void setMaxpcode(int maxpcode) {
		this.maxpcode = maxpcode;
	}
	
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

	private int point;

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
	
	//photo_uploader.html페이지의 form태그내에 존재하는 file 태그의 name명과 일치시켜줌

    private MultipartFile Filedata;

    //callback URL

    private String callback;

    //콜백함수??

    private String callback_func;

    public MultipartFile getFiledata() {
        return Filedata;
    }

    public void setFiledata(MultipartFile filedata) {
        Filedata = filedata;
    }

    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    public String getCallback_func() {
        return callback_func;
    }

    public void setCallback_func(String callback_func) {
        this.callback_func = callback_func;
    }

}
