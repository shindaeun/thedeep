package thedeep.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import thedeep.service.CartVO;
import thedeep.service.MemberService;

@Controller
public class MemberController {
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@RequestMapping(value="/memberInfo.do")
	public String insertMemberInfo() throws Exception{
		return "member/memberInfo";
	}
	@RequestMapping(value="/myPage.do")
	public String selectMyPage() throws Exception{
		return "member/myPage";
	}
	@RequestMapping(value="/memberModify.do")
	public String updateMemberInfo() throws Exception{
		return "member/memberModify";
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
	public String cart(ModelMap model) throws Exception{
		String userid="userid1";
		List<?> list = memberService.selectCartList(userid);
		model.addAttribute("List",list);
		return "member/cart";
	}
	
	@RequestMapping(value="/cartUpdate.do")
	@ResponseBody
	public Map<String,Object> cartUpdate(CartVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		String userid="userid1";
		vo.setUserid(userid);
		int cnt = memberService.updateCart(vo);
		if(cnt>0){
			result="ok";
		}
		map.put("result", result);
		return map;
	}
	@RequestMapping(value="/cartDelete.do")
	@ResponseBody
	public Map<String,Object> cartDelete(CartVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		String userid="userid1";
		vo.setUserid(userid);
		int cnt = memberService.cartDelete(vo);
		if(cnt>0){
			result="ok";
		}
		map.put("result", result);
		return map;
	}
	@RequestMapping(value="/NewFile.do")
	public String NewFile() throws Exception{
		return "/NewFile";
	}
	@RequestMapping(value="/coupon.do")
	public String coupon(ModelMap model) throws Exception{
		String userid="userid1";
		List<?> list = memberService.selectCouponList(userid);
		model.addAttribute("List",list);
		return "member/coupon";
	}
	@RequestMapping(value="/point.do")
	public String point() throws Exception{
		return "member/point";
	}
	@RequestMapping(value="/order.do")
	@ResponseBody//@RequestBody List<CartVO> list
	public Map<String,Object> order(CartVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		System.out.println("in");
		//System.out.println(list);
		String result="ok";
		map.put("result", result);
		return map;
	}
	@RequestMapping(value="/orderComplete.do")
	public String orderComplete() throws Exception{
		return "member/orderComplete";
	}

}
