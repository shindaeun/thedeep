package thedeep.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.CartVO;
import thedeep.service.DefaultVO;
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
	public String userBoard(ModelMap model,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		String userid="userid1";
		searchVO.setUserid(userid);
		searchVO.setPageUnit(1);// 한 화면에 출력 개수
		searchVO.setPageSize(1);// 페이지 개수
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		String keyword="";
		if(searchVO.getSearchkind()==2){
			System.out.println("in");
			keyword=searchVO.getSearchKeyword();
			System.out.println(keyword);
			searchVO.setSearchKeyword("");
		}
		List<?> qlist = memberService.selectUserQna(searchVO);
		model.addAttribute("qlist", qlist);
		int totCnt = memberService.selectUserQnaTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		
		/** pageing setting */
		PaginationInfo paginationInfo2 = new PaginationInfo();
		paginationInfo2.setCurrentPageNo(searchVO.getPageIndex2());
		paginationInfo2.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo2.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo2.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo2.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo2.getRecordCountPerPage());
		if(searchVO.getSearchkind()==2){
			searchVO.setSearchKeyword(keyword);
		}else if(searchVO.getSearchkind()==1){
			searchVO.setSearchKeyword("");
		}
		List<?> rlist = memberService.selectUserReview(searchVO);
		model.addAttribute("rlist", rlist);
		int totCnt2 = memberService.selectUserReviewTotCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		searchVO.setSearchKeyword("");
		model.addAttribute("paginationInfo2", paginationInfo2);
		
		return "member/userBoard";
	}
	@RequestMapping(value="/cart.do")
	public String cart(ModelMap model) throws Exception{
		String userid="userid1";
		List<?> list = memberService.selectCartList(userid);
		model.addAttribute("List",list);
		return "member/cart";
	}
	@RequestMapping(value="/addCart.do")
	@ResponseBody
	public Map<String,Object> addCart(RedirectAttributes redirectAttributes,ModelMap model,CartVO vo,@RequestParam(name="cscode", required=false) String[] csarr,@RequestParam(name="amount", required=false) String[] amarr) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String userid="userid1";
		String result="fail";
		for(int i=0;i<csarr.length;i++){
			String tmp[]=csarr[i].split(" ");
			String[] color=tmp[0].split("-");
			String[] size=tmp[1].split("-");
			String cscode=vo.getPcode()+size[1]+color[1];
			vo.setCscode(cscode);
			vo.setAmount(Integer.parseInt(amarr[i]));
			vo.setUserid(userid);
			int cnt = memberService.selectCartCscodeCount(vo);
			if(cnt>0){
				cnt = memberService.updateCart(vo);
				if(cnt>0) result="ok";
			}else{
				result = memberService.insertCartList(vo);
				if(result==null) result="ok";
			}
		}
		model.addAttribute("pcode", vo.getPcode());
		map.put("result", result);
		return map;
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
	public String point(ModelMap model) throws Exception{
		String userid="userid1";
		String allpoint = memberService.selectAllPoint(userid);
		String ablepoint = memberService.selectAblePoint(userid);
		List<?> list = memberService.selectPointList(userid);
		model.addAttribute("allpoint",allpoint);
		model.addAttribute("ablepoint",ablepoint);
		model.addAttribute("List",list);
		System.out.println(list);
		return "member/point";
	}
	@RequestMapping(value="/order.do")
	public String order(@RequestParam(name="ordercheck", required=false) List<String> list) throws Exception{
		System.out.println(list);
		return "member/order";
	}
	@RequestMapping(value="/orderNow.do")
	public String orderNow(ModelMap model,CartVO vo,@RequestParam(name="cscode", required=false) String[] csarr,@RequestParam(name="amount", required=false) String[] amarr) throws Exception{
		
		String userid="userid1";

		vo.setUserid(userid);
		for(int i=0;i<csarr.length;i++){
			String tmp[]=csarr[i].split(" ");
			String[] color=tmp[0].split("-");
			String[] size=tmp[1].split("-");
			String cscode=vo.getPcode()+size[1]+color[1];
			vo.setCscode(cscode);
			vo.setAmount(Integer.parseInt(amarr[i]));
			vo.setUserid(userid);
			System.out.println(vo.getUserid() + vo.getPcode()+vo.getCscode()+vo.getAmount());
		}
		return "member/order";
	}
	
	@RequestMapping(value="/orderComplete.do")
	public String orderComplete() throws Exception{
		return "member/orderComplete";
	}

}
