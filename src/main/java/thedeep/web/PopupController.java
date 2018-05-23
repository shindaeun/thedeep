package thedeep.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardService;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.NoticeVO;
import thedeep.service.OrderMainVO;
import thedeep.service.PwdCkVO;
import thedeep.service.ReviewVO;

@Controller
public class PopupController {
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@RequestMapping(value="/pwdChk.do")
	public String PwdChk(ModelMap model, MemberVO mvo) throws Exception{
		model.put("vo", mvo);
		return "popup/pwdChk";
	}
	
	@RequestMapping(value="/adminPwdChk.do")
	public String adminPwdChk(ModelMap model, AdminVO avo) throws Exception{
		model.put("vo", avo);
		return "popup/adminPwdChk";
	}
	
	@RequestMapping(value="/pwdChkSave.do")
	@ResponseBody
	public Map<String,Object> selectPwdChk(PwdCkVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		System.out.println("pwd  :  " + vo.getPwd());
		System.out.println("userid  :  " + vo.getUserid());
		int count = memberService.selectPwdChk(vo);

		if(count > 0) result = "ok";
		else result = "1";
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/adminPwdChkSave.do")
	@ResponseBody
	public Map<String,Object> selectAdminPwdChk(PwdCkVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		System.out.println("pwd  :  " + vo.getPwd());
		System.out.println("adminid  :  " + vo.getAdminid());
		int count = adminService.selectAdminPwdChk(vo);

		if(count > 0) result = "ok";
		else result = "1";
		map.put("result", result);
		
		return map;
	}
	
	
	@RequestMapping(value="/reviewPwdCheck.do")
	public String reviewPwdCheck() throws Exception{
		return "popup/reviewPwdCheck";
	}

	@RequestMapping(value="/reviewPwdCheck2.do")
	@ResponseBody 
	public Map<String,Object> selectReviewPwd(ReviewVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "";
		int number = boardService.selectReviewPwd(vo);
		if(number == 0) {
			result = "0";
		} else {
			result = "1";
		}
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="/noticePwdCheck.do")
	public String noticePwdCheck() throws Exception{
		return "popup/noticePwdCheck";
	}

	@RequestMapping(value="/noticePwdCheck2.do")
	@ResponseBody 
	public Map<String,Object> selectNoticePwd(NoticeVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "";
		int number = boardService.selectNoticePwd(vo);
		if(number == 0) {
			result = "0";
		} else {
			result = "1";
		}
		map.put("result", result);
		return map;
	}
	

	
	@RequestMapping(value="/couponPopup.do")
	public String couponPopup(ModelMap model) throws Exception{
		String userid = "userid1";
		List<?> clist = memberService.selectUserCouponList(userid);
		model.addAttribute("clist",clist);
		return "popup/couponPopup";
	}

}
