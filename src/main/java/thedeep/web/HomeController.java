package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	
	@RequestMapping(value="/home.do")
	public String selectEmpList1() throws Exception{
		return "home/home";
	}
	
	@RequestMapping(value="/outerDetail.do")
	public String selectEmpList2() throws Exception{
		
		return "product/outerDetail";
	}
	@RequestMapping(value="/noticeList.do")
	public String selectNoticeList() throws Exception{
		return "board/noticeList";
	}
	@RequestMapping(value="/noticeDetail.do")
	public String noticeDetail() throws Exception{
		return "board/noticeDetail";
	}
	@RequestMapping(value="/userBoard.do")
	public String userBoard() throws Exception{
		return "member/userBoard";
	}
	@RequestMapping(value="/cart.do")
	public String cart() throws Exception{
		return "member/cart";
	}

}


