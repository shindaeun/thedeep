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
	
	@RequestMapping(value="/qnaList.do")
	public String selectQnaListe() throws Exception{
		return "board/qnaList";
	}
	@RequestMapping(value="/qnaWrite.do")
	public String insertQnaWrite() throws Exception{
		return "board/qnaWrite";
	}
	@RequestMapping(value="/qnaDetail.do")
	public String selectQnaDetail() throws Exception{
		return "board/qnaDetail";
	}
	@RequestMapping(value="/qnaModify.do")
	public String updateQnaModify() throws Exception{
		return "board/qnaModify";
	}
	
	@RequestMapping(value="/memberInfo.do")
	public String insertMemberInfo() throws Exception{
		return "member/memberInfo";
	}
	@RequestMapping(value="/post1.do")
	public String selectPost1() throws Exception{
		return "popup/post1";
	}
	@RequestMapping(value="/myPage.do")
	public String selectMyPage() throws Exception{
		return "member/myPage";
	}
	@RequestMapping(value="/memberModify.do")
	public String updateMemberInfo() throws Exception{
		return "member/memberModify";
	}
	@RequestMapping(value="/pwdChk.do")
	public String selectPwdChk() throws Exception{
		return "popup/pwdChk";
	}
	@RequestMapping(value="/login.do")
	public String memberLogin() throws Exception{
		return "member/login";
	}
	@RequestMapping(value="/findId1.do")
	public String memberFindId1() throws Exception{
		return "member/findId1";
	}
	@RequestMapping(value="/findId2.do")
	public String memberFindId2() throws Exception{
		return "member/findId2";
	}
	@RequestMapping(value="/findPwd1.do")
	public String memberFindPwd1() throws Exception{
		return "member/findPwd1";
	}
	@RequestMapping(value="/findPwd2.do")
	public String memberFindPwd2() throws Exception{
		return "member/findPwd2";
	}
	
	@RequestMapping(value="/userBoard.do")
	public String userBoard() throws Exception{
		return "member/userBoard";
	}
	@RequestMapping(value="/cart.do")
	public String cart() throws Exception{
		return "member/cart";
	}
	
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


}


