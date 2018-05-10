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
	@RequestMapping(value="/coupon.do")
	public String coupon() throws Exception{
		return "member/coupon";
	}
	@RequestMapping(value="/point.do")
	public String point() throws Exception{
		return "member/point";
	}
	@RequestMapping(value="/order.do")
	public String order() throws Exception{
		return "member/order";
	}
	@RequestMapping(value="/couponPopup.do")
	public String couponPopup() throws Exception{
		return "popup/couponPopup";
	}
	@RequestMapping(value="/postPopup.do")
	public String postPopup() throws Exception{
		return "popup/postPopup";
	}
	@RequestMapping(value="/orderComplete.do")
	public String orderComplete() throws Exception{
		return "member/orderComplete";
	}
	@RequestMapping(value="/orderList.do")
	public String orderList() throws Exception{
		return "admin/orderList";
	}
	@RequestMapping(value="/orderDetail.do")
	public String orderDetail() throws Exception{
		return "admin/orderDetail";
	}

}


