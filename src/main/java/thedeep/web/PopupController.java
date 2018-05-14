package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class PopupController {
	@RequestMapping(value="/post1.do")
	public String selectPost1() throws Exception{
		return "popup/post1";
	}
	
	@RequestMapping(value="/pwdChk.do")
	public String selectPwdChk() throws Exception{
		return "popup/pwdChk";
	}
	
	
	
	
	
	
	
	@RequestMapping(value="/pwdCheck.do")
	public String selectPwdCheck() throws Exception{
		return "popup/pwdCheck";
	}

	
	

	
	@RequestMapping(value="/couponPopup.do")
	public String couponPopup() throws Exception{
		return "popup/couponPopup";
	}

}
