package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	@RequestMapping(value="/adminInfo.do")
	public String insertAdminInfo() throws Exception{
		return "admin/adminInfo";
	}
	@RequestMapping(value="/adminLogin.do")
	public String adminLogin() throws Exception{
		return "admin/adminLogin";
	}
	@RequestMapping(value="/adminList.do")
	public String selectAdminList() throws Exception{
		return "admin/adminList";
	}
	@RequestMapping(value="/adminListModify.do")
	public String updateAdminList() throws Exception{
		return "admin/adminListModify";
	}
	@RequestMapping(value="/orderList.do")
	public String orderList() throws Exception{
		return "admin/orderList";
	}
	@RequestMapping(value="/orderDetail.do")
	public String orderDetail() throws Exception{
		return "admin/orderDetail";
	}
	@RequestMapping(value="/adminBoard.do")
	public String adminBoard() throws Exception{
		return "admin/adminBoard";
	}
	@RequestMapping(value="/reviewReply.do")
	public String reviewReply() throws Exception{
		return "admin/reviewReply";
	}
	@RequestMapping(value="/qnaReply.do")
	public String qnaReply() throws Exception{
		return "admin/qnaReply";
	}
}
