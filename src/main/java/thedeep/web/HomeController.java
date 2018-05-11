package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	
	@RequestMapping(value="/home.do")
	public String selectEmpList1() throws Exception{
		return "home/home";
	}
	
	@RequestMapping(value="/productList.do")
	public String selectProductList() throws Exception{
	
		return "product/productList";
	}
	@RequestMapping(value="/productDetail.do")
	public String selectProductDetail() throws Exception{
	
		return "product/productDetail";
	}
	@RequestMapping(value="/noticeWrite.do")
	public String selectNoticeWrite() throws Exception{
		return "board/noticeWrite";
	}
	@RequestMapping(value="/noticeModify.do")
	public String selectNoticeModify() throws Exception{
		return "board/noticeModify";
	}
	@RequestMapping(value="/noticeList.do")
	public String selectNoticeList() throws Exception{
		return "board/noticeList";
	}
	@RequestMapping(value="/noticeDetail.do")
	public String noticeDetail() throws Exception{
		return "board/noticeDetail";
	}
	
	
	@RequestMapping(value="/reviewWrite.do")
	public String selectReviewWrite() throws Exception{
		return "board/reviewWrite";
	}
	@RequestMapping(value="/reviewList.do")
	public String selectReviewList() throws Exception{
		return "board/reviewList";
	}
	@RequestMapping(value="/reviewDetail.do")
	public String selectReviewDetail() throws Exception{
		return "board/reviewDetail";
	}
	@RequestMapping(value="/reviewModify.do")
	public String selectReviewModify() throws Exception{
		return "board/reviewModify";
	}
	@RequestMapping(value="/pwdCheck.do")
	public String selectPwdCheck() throws Exception{
		return "popup/pwdCheck";
	}
	@RequestMapping(value="/productAdd.do")
	public String selectProductAdd() throws Exception{
		return "product/productAdd";
	}
	@RequestMapping(value="/productModify.do")
	public String selectProductModify() throws Exception{
		return "product/productModify";
	}
	@RequestMapping(value="/productListView.do")
	public String selectProductListView() throws Exception{
		return "product/productListView";
	}
	@RequestMapping(value="/group.do")
	public String selectgroup() throws Exception{
		return "product/group";
	}
	
	@RequestMapping(value="/userBoard.do")
	public String userBoard() throws Exception{
		return "member/userBoard";
	}
	@RequestMapping(value="/cart.do")
	public String cart() throws Exception{
		return "member/cart";
	}
	@RequestMapping(value="/test.do")
	public String test() throws Exception{
		return "product/test";
	}

}


