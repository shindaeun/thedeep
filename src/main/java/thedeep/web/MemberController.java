package thedeep.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.AdminService;
import thedeep.service.CartVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.FindVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.OrderListVO;
import thedeep.service.OrderVO;
import thedeep.service.PointVO;
import thedeep.service.ProductService;
import thedeep.service.ProductVO;
import thedeep.service.UolVO;

@Controller
public class MemberController {
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="productService")
	ProductService productService;
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@RequestMapping(value="/memberInfo.do")
	public String MemberInfo() throws Exception{
		return "member/memberInfo";
	}
	
	@RequestMapping(value="/memberInfoSave.do")
	@ResponseBody
	public Map<String,Object> insertMemeberInfo(MemberVO vo, CouponVO cvo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		Calendar cal = Calendar.getInstance();
		
		System.out.println("userid  :  " + vo.getUserid());
		String result = memberService.insertMember(vo);
		
		String userid = vo.getUserid();
		
		cal.add(Calendar.MONTH, 1);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		
		String edate = year + "-";
			if(month<10) edate += "0" + month + "-";
			else edate += month + "-";
			edate += day + "";
		cvo.setUserid(userid);
		cvo.setEdate(edate);
		
		if(result==null) {
			String coupon = memberService.insertCoupon(cvo);
			if(coupon==null)result = "ok";
			else result = "0";
		}
		else {
			result = "1";
		}
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/memberIdChk.do")
	@ResponseBody
	public Map<String,Object> selectIdChk(MemberVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";

		System.out.println("userid  :  " + vo.getUserid());
		int cnt = memberService.selectIdChk(vo.getUserid());
		System.out.println("cnt  :  " + cnt);
		if(cnt == 0) result = "ok";
		else result = "1";
		map.put("result", result);
		
		return map;
	}

	@RequestMapping(value="/myPage.do")
	public String selectMyPage(MemberVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		vo = memberService.selectMemeberDetail(userid);
		model.addAttribute("vo", vo);
		
		int coupon = memberService.selectMemberCoupon(userid);
		model.addAttribute("coupon", coupon);
		
		int total = memberService.selectMemberMoney(userid);
		model.addAttribute("total", total);
		
		int inMoney = memberService.selectInMoneyCnt(userid);
		model.addAttribute("inMoney", inMoney);
		
		int preparing = memberService.selectPreparingCnt(userid);
		model.addAttribute("preparing", preparing);
		
		int deliver = memberService.selectDeliverCnt(userid);
		model.addAttribute("deliver", deliver);
		
		int complete = memberService.selectCompleteCnt(userid);
		model.addAttribute("complete", complete);
		
		return "member/myPage";
	}
	
	@RequestMapping(value="/memberModify.do")
	public String updateMemberInfo(MemberVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		vo = memberService.selectMemeberDetail(userid);
		model.addAttribute("vo", vo);
		
		return "member/memberModify";
	}
	
	@RequestMapping(value="/memberModifySave.do")
	@ResponseBody
	public Map<String,Object> updateMemeberInfo(MemberVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result ="";
		int cnt = memberService.updateMember(vo);
		if(cnt>0) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/login.do")
	public String memberLogin(MemberVO vo, ModelMap model) throws Exception{
		
		
		String useridIn = vo.getUserid();
		
		if (useridIn!=null) {
			model.addAttribute("useridIn", useridIn);
		}
		
		return "member/login";
	}
	
	@RequestMapping(value="/loginCert.do")
	 @ResponseBody
	public Map<String, Object> loginCert(MemberVO vo, HttpServletRequest request) throws Exception {
		
		String result = "";
		int cnt = 0;
		
		Map<String,Object> map = new HashMap<String, Object>();
		cnt = memberService.selectMemberCertCnt(vo);
		if(cnt>0) {
			map.put("ThedeepUserId", vo.getUserid());
			map.put("ThedeepPwd", vo.getPwd());
			request.getSession().setAttribute("ThedeepLoginCert", map);
			result = "ok";
		} else {
			result = "-1";
		}
	
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="/logout.do")
	 @ResponseBody
	public Map<String,Object> logout(MemberVO vo, HttpServletRequest request, HttpSession session) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		session.setAttribute("ThedeepLoginCert", null);
		map.put("result", "ok");
		
		return map;
	}
	
	@RequestMapping(value="/findId1.do")
	public String memberFindId1() throws Exception{
		
		return "member/findId1";
	}
	
	@RequestMapping(value="/findIdChk.do")
	@ResponseBody
	public Map<String,Object> selectFindId(FindVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		int cnt = memberService.selectFindid(vo);
		if(cnt>0) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/findId2.do")
	public String memberFindId2(FindVO fvo, MemberVO vo, ModelMap model) throws Exception{
		
		model.addAttribute("name", fvo.getName());
		model.addAttribute("email", fvo.getEmail());
		
		List<?> list = memberService.selectFindIdList(fvo);
		model.addAttribute("list", list);
		
		int cnt = memberService.selectFindidCnt(fvo);
		model.addAttribute("cnt", cnt);
		
		return "member/findId2";
	}
	
	@RequestMapping(value="/findPwd1.do")
	public String memberFindPwd1(FindVO vo, ModelMap model) throws Exception{

		return "member/findPwd1";
	}
	
	@RequestMapping(value="/findPwdChk.do")
	@ResponseBody
	public Map<String,Object> selectFindPwd(FindVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		System.out.println("pwd  :  " + vo.getPwd());
		int cnt = memberService.selectFindPwd(vo);
		if(cnt>0) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/findPwd2.do")
	public String memberFindPwd2(FindVO vo, ModelMap model) throws Exception{
		
		model.addAttribute("name", vo.getName());
		model.addAttribute("email", vo.getEmail());
		model.addAttribute("userid", vo.getUserid());
		
		String pwd = "";
		String result = "";
		
		for (int i = 0; i < 12; i++) {
			pwd += (char) ((Math.random() * 26) + 97);
		}
		System.out.println("new pwd  :  " + pwd);
		vo.setPwd(pwd);
		
		int cnt = memberService.updatePwd(vo);
		if (cnt>0) result = "ok";
		else result = "1";
		
		model.addAttribute("result", result);
		
		sendMail(vo);
		
		return "member/findPwd2";
	}
	
	public static void sendMail(FindVO vo) throws Exception {
		
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "mlpokn_23";
		String hostSMTPpwd = "alsgmlWkd34";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "mlpokn_23@naver.com";
		String fromName = "The Deep";
		String subject = "";
		String msg = "";

		// 회원가입 메일 내용
		subject = "The Deep 임시 비밀번호 입니다.";
		msg += "<div align='center' style='font-size:9pt; border: 1px dashed #828282; padding-top: 45px; padding-bottom:60px; width:600px; margin-left:300px;'>";
		msg += "<h3 style='color: #bf82bf;'>";
		msg += vo.getName() + " 님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += vo.getPwd() + "</p></div>";


		// 받는 사람 E-Mail 주소
		String mail = vo.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587);

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패  :  " + e);
		}
		
	}

	
	@RequestMapping(value="/userBoard.do")
	public String userBoard(HttpServletRequest request,ModelMap model,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
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
	public String cart(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		List<?> list = memberService.selectCartList(userid);
		model.addAttribute("List",list);
		return "member/cart";
	}
	@RequestMapping(value="/addCart.do")
	@ResponseBody
	public Map<String,Object> addCart(HttpServletRequest request,RedirectAttributes redirectAttributes,ModelMap model,CartVO vo,@RequestParam(name="cscode", required=false) String[] csarr,@RequestParam(name="amount", required=false) String[] amarr) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
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
	public Map<String,Object> cartUpdate(HttpServletRequest request,CartVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
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
	public Map<String,Object> cartDelete(HttpServletRequest request,CartVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
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
	public String coupon(ModelMap model, HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		List<?> list = memberService.selectCouponList(userid);
		
		model.addAttribute("List",list);
		
		return "member/coupon";
	}
	@RequestMapping(value="/point.do")
	public String point(HttpServletRequest request, ModelMap model) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String allpoint = memberService.selectAllPoint(userid);
		List<?> list = memberService.selectPointList(userid);
		model.addAttribute("allpoint",allpoint);
		Map<String,String> map = new HashMap<String,String>();
		map = (Map<String, String>) list.get(0);
		String ablepoint = String.valueOf(map.get("ablepoint"));
		model.addAttribute("ablepoint",ablepoint);
		model.addAttribute("List",list);
		System.out.println(list);
		return "member/point";
	}
	@RequestMapping(value="/order.do")
	public String order(HttpServletRequest request,ModelMap model,@RequestParam(name="ordercheck", required=false) String[] orderarr) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		List<CartVO> olist = new ArrayList<CartVO>();
		if(orderarr!=null){
			for(int i=0;i<orderarr.length;i++){
				CartVO vo = new CartVO();
				vo.setUserid(userid);
				vo.setCscode(orderarr[i]);
				vo = memberService.selectCartProductInfo(vo);
				olist.add(vo);
			}
			model.addAttribute("olist",olist);
		}
		MemberVO vo = new MemberVO();
		vo = memberService.selectMemeberDetail(userid);
		vo.setPost(memberService.selectLatestPost(userid));
		model.addAttribute("vo",vo);
		String ablepoint = adminService.selectAblePoint(userid);
		model.addAttribute("ablepoint",ablepoint);
		return "member/order";
	}
	@RequestMapping(value="/orderNow.do")
	public String orderNow(HttpServletRequest request,CartVO vo,ModelMap model,@RequestParam(name="cscode", required=false) String[] csarr,@RequestParam(name="amount", required=false) String[] amarr) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String pcode=vo.getPcode();
		List<CartVO> olist = new ArrayList<CartVO>();

		for(int i=0;i<csarr.length;i++){
			vo = new CartVO();
			String tmp[]=csarr[i].split(" ");
			String[] color=tmp[0].split("-");
			String[] size=tmp[1].split("-");
			String cscode=pcode+size[1]+color[1];
			vo.setCscode(cscode);
			vo = memberService.selectProductInfo(vo);
			vo.setAmount(Integer.parseInt(amarr[i]));
			vo.setPrice(vo.getPrice()*Integer.parseInt(amarr[i]));
			vo.setSavepoint(vo.getSavepoint()*Integer.parseInt(amarr[i]));
			vo.setUserid(userid);
			olist.add(vo);
		}
		model.addAttribute("olist",olist);
		MemberVO mvo = new MemberVO();
		mvo = memberService.selectMemeberDetail(userid);
		mvo.setPost(memberService.selectLatestPost(userid));
		model.addAttribute("vo",mvo);
		String ablepoint = adminService.selectAblePoint(userid);
		model.addAttribute("ablepoint",ablepoint);
		return "member/order";
	}
	@RequestMapping(value="/orderSave.do")
	@ResponseBody
	public Map<String,Object> orderSave(HttpServletRequest request,OrderVO ovo,OrderListVO lvo,DeliveryVO dvo) throws Exception{
		
		Map<String,Object> map = new HashMap<String, Object>();
		String result = "fail";
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		List<OrderListVO> olist = lvo.getOlist();
		String ocode = memberService.selectOcodeNext(); 
		MemberVO mvo =memberService.selectMemeberDetail(userid);
		
		ovo.setOcode(ocode);
		dvo.setOcode(ocode);
		
		ovo.setUserid(userid);
		result = memberService.insertOrder(ovo);
		 
		dvo.setOemail(mvo.getEmail());
		dvo.setOname(mvo.getName());
		dvo.setOphone(mvo.getPhone());
		if(result==null){
			result = memberService.insertDelivery(dvo);
			if(result==null){
				for(int i =0;i<olist.size();i++){
					OrderListVO vo = olist.get(i);
					vo.setOcode(ocode);
					result = memberService.insertOrderList(vo);
				}
				if(result==null){
					result="ok";
				}
			}
		}
		
		map.put("result", result);
		map.put("ocode", ocode);
		return map;
	}
	@RequestMapping(value="/orderSub.do")
	public String orderSub(HttpServletRequest request,ModelMap model,OrderVO ovo,OrderListVO lvo,DeliveryVO dvo) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		model.addAttribute("ocode",ovo.getOcode());
		model.addAttribute("oemail",dvo.getOemail());
		model.addAttribute("name",dvo.getDname());
		model.addAttribute("phone",dvo.getDphone());
		model.addAttribute("post",dvo.getDpost());
		model.addAttribute("totalmoney",ovo.getTotalmoney());
		model.addAttribute("usepoint",ovo.getUsepoint());
		model.addAttribute("savepoint",ovo.getSavepoint());
		System.out.println("point1 : "+ovo.getUsepoint() +","+ovo.getSavepoint() );
		return "member/orderSub";
	}
	
	@RequestMapping(value="/orderComplete.do")
	public String orderComplete(HttpServletRequest request,ModelMap model,PointVO point,@RequestParam("ocode") String ocode,@RequestParam(value="paymethod",required=false) String paymethod) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		if(paymethod!=null && paymethod.equals("신용카드")){
			DeliveryVO dvo = new DeliveryVO();
			dvo.setOcode(ocode);
			dvo.setDstate("결제완료");
			adminService.updateDstate(dvo);
		}
		OrderVO ovo  = memberService.selectOrderInfo(ocode);
		String olist = memberService.selectOrderList(ocode);
		model.addAttribute("ovo",ovo);
		model.addAttribute("olist",olist);
		//적립금 지급
		point.setUserid(userid);
		point.setContent("구매("+ocode+")");
		System.out.println("point : "+point.getUsepoint()+","+ point.getSavepoint());
		String ablepoint = adminService.selectAblePoint(userid);
		int ablepoint2 = Integer.parseInt(ablepoint) - point.getUsepoint() + point.getSavepoint();
		point.setAblepoint(ablepoint2);
		memberService.insertPoint(point);
		//쿠폰 사용으로 수정
		int cnt = memberService.updateUseCoupon(ovo);
		//재고수정
		List<?> list = memberService.selectOrderListByOcode(ocode);
		Map<String,String> map = new HashMap<String,String>();
		ProductVO pvo;
		for(int i=0;i<list.size();i++){
			map = (Map<String, String>) list.get(i);
			pvo = new ProductVO();
			pvo.setCscode(map.get("cscode"));
			pvo.setAmount(Integer.parseInt(String.valueOf(map.get("amount")))*-1);
			productService.updateAmount(pvo);
		}
		return "member/orderComplete";
	}
	
	@RequestMapping(value="/userOrderList.do")
	public String selectUserOrderList(UolVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		List<?> list = memberService.selectUserOrderList(userid);
		model.addAttribute("list", list);
		
		return "member/userOrderList";
	}
	@RequestMapping(value="/updateDstate.do")
	@ResponseBody
	public Map<String,String> updateDstate(HttpServletRequest request,@RequestParam("dstate") String dstate,@RequestParam("ocode") String ocode) throws Exception{
		String result="fail";
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		Map<String,String> map = new HashMap<String,String>();
		DeliveryVO dvo = new DeliveryVO();
		dvo.setOcode(ocode);
		dvo.setDstate(dstate);
		int cnt = adminService.updateDstate(dvo);
		if(cnt>0){
			result = "ok";
		}
		
		OrderVO ovo = memberService.selectOrderInfo(ocode);

		memberService.deleteUseCoupon(ovo);
		map.put("result", result);
		return map;
	}

}
