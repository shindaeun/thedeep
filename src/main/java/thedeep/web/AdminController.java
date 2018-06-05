package thedeep.web;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestHttpClientJava.IamportClient;
import com.siot.IamportRestHttpClientJava.request.CancelData;
import com.siot.IamportRestHttpClientJava.response.IamportResponse;
import com.siot.IamportRestHttpClientJava.response.Payment;
import com.siot.IamportRestHttpClientJava.response.Payments;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.GroupVO;
import thedeep.service.PaymentVO;
import thedeep.service.PointVO;
import thedeep.service.ProductService;
import thedeep.service.ProductVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.OrderVO;
import thedeep.service.ReviewReplyVO;
import thedeep.service.ReviewVO;

@Controller
public class AdminController {
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@Resource(name="productService")
	ProductService productService;
	
	@RequestMapping(value="/adminInfo.do")
	public String insertAdminInfo() throws Exception{
		return "admin/adminInfo";
	}
	String api_key = "7972187031404347";
	String api_secret = "1JFZV7lC38ScZDglLKqf2T1Qg1ubDU3FEIEzQ0bT8457Hlts6UI9OJZ4Ltgooj322HBTHNMQRRYzdr1k";

	@RequestMapping(value="/iamportList.do")
	public String iamportList(ModelMap model,@RequestParam(name="page", required=false) String page) throws Exception{
		IamportClient client;
		
		client = new IamportClient(api_key, api_secret);
		String token = client.getToken();
		System.out.println("token : " + token);
		IamportResponse<Payment> paymentByMerchantUid = client.paymentByMerchantUid("nobody_1527581672484");
		System.out.println(paymentByMerchantUid.getResponse().getPayMethod());
		
		IamportResponse<Payments> list = client.paymentAll(page);
		int total = list.getResponse().getTotal();
		int previous = list.getResponse().getPrevious();
		int next = list.getResponse().getNext();
		List<PaymentVO> result = new ArrayList<PaymentVO>();
		for(int i=0;i<list.getResponse().getList().size();i++){
			Payment p = list.getResponse().getList().get(i);
			PaymentVO pay = new PaymentVO(p.getMerchantUid(), p.getAmount(), p.getBuyerName(), p.getBuyerTel(), p.getBuyerPostcode(), p.getBuyerAddr(), p.getStatus(), p.getCancelledAt());
			result.add(pay);
		}
		model.addAttribute("total",total);
		model.addAttribute("previous",previous);
		model.addAttribute("next",next);
		model.addAttribute("result",result);
		System.out.println(result);
		return "admin/iamportList";
	}
	
	@RequestMapping(value="/iamportCancel.do")
	@ResponseBody
	public Map<String,Object> iamportCancel(HttpServletRequest request, @RequestParam(name="merchant_uid", required=false) String merchant_uid) throws Exception{
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		IamportClient client;
		Map<String,Object> map = new HashMap<String, Object>();
		String result = "fail";
		client = new IamportClient(api_key, api_secret);
		String token = client.getToken();
		
		CancelData cancel2 = new CancelData(merchant_uid, false);
		IamportResponse<Payment> cancelpayment2 = client.cancelPayment(cancel2);
		if(cancelpayment2.getMessage()==null){
			result = "ok";
			OrderVO ovo  = memberService.selectOrderInfo(merchant_uid);
			
			DeliveryVO dvo = new DeliveryVO();
			dvo.setOcode(merchant_uid);
			dvo.setDstate("취소");
			adminService.updateDstate(dvo);
			
			//쿠폰 미사용으로 수정
			int cnt = memberService.updateUseCoupon2(ovo);
			//재고수정
			List<?> list = memberService.selectOrderListByOcode(merchant_uid);
			Map<String,String> map2 = new HashMap<String,String>();
			ProductVO pvo;
			for(int i=0;i<list.size();i++){
				map2 = (Map<String, String>) list.get(i);
				pvo = new ProductVO();
				pvo.setCscode(map2.get("cscode"));
				pvo.setAmount(Integer.parseInt(String.valueOf(map2.get("amount"))));
				productService.updateAmount(pvo);
			}
			//적립금 회수
			PointVO point = new PointVO();
			point.setUserid(userid);
			point.setContent("구매취소("+merchant_uid+")");
			ovo = memberService.selectOrderInfo(merchant_uid);
			System.out.println("point3 : "+ovo.getUsepoint()+","+ ovo.getSavepoint());
			point.setUsepoint(ovo.getSavepoint());
			point.setSavepoint(ovo.getUsepoint());
			String ablepoint = adminService.selectAblePoint(userid);
			int ablepoint2 = Integer.parseInt(ablepoint) - point.getUsepoint() + point.getSavepoint();
			point.setAblepoint(ablepoint2);
			memberService.insertPoint(point);
		}
		map.put("result",result);
		return map;
	}
	@RequestMapping(value="/adminInfoSave.do")
	@ResponseBody
	public Map<String,Object> insertMemeberInfo(AdminVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = adminService.insertAdmin(vo);
		if(result==null) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/adminIdChk.do")
	@ResponseBody
	public Map<String,Object> selectIdChk(AdminVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		
		int count = adminService.selectIdChk(vo.getAdminid());

		if(count > 0) result = "1";
		else result = "ok";
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/adminLogin.do")
	public String adminLogin() throws Exception{
		return "admin/adminLogin";
	}
	
	@RequestMapping(value="/adminLoginCert.do")
	 @ResponseBody
	public Map<String, Object> loginCert(AdminVO vo, HttpServletRequest request) throws Exception {
		
		String result = "";
		int cnt = 0;
		
		Map<String,Object> map = new HashMap<String, Object>();
		cnt = adminService.selectAdminCertCnt(vo);
		if(cnt>0) {
			map.put("ThedeepAUserId", vo.getAdminid());
			map.put("ThedeepAPwd", vo.getPwd());
			request.getSession().setAttribute("ThedeepALoginCert", map);
			result = "ok";
		} else {
			result = "-1";
		}
	
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="/adminLogout.do")
	 @ResponseBody
	public Map<String,Object> adminLogout(AdminVO vo, HttpServletRequest request, HttpSession session) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		session.setAttribute("ThedeepALoginCert", null);
		map.put("result", "ok");
		
		return map;
	}
	@RequestMapping(value="/reviewDetailAdmin.do")
	public String selectReviewDetailAdmin(ReviewVO vo,ModelMap model) throws Exception {
		
		int unq = vo.getUnq();
		boardService.updateReviewHit(unq);
		vo = boardService.selectReviewDetail(unq);
		model.addAttribute("vo", vo);
		
		List<?> rlist = boardService.selectReviewReplyList(unq);
		model.addAttribute("rlist", rlist);
		return "admin/reviewDetail";
	}
	@RequestMapping(value="/adminList.do")
	public String selectAdminList(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model) throws Exception{
		
		searchVO.setPageUnit(10); 	// 한 화면 출력 개수
		searchVO.setPageSize(10);	// 페이지 너비 개수
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> list = adminService.selectAdminList(searchVO);
		model.addAttribute("list", list);
		
		int totCnt = adminService.selectAdminListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/adminList";
	}
	
	@RequestMapping(value="/adminModify.do")
	public String updateAdminList(AdminVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
		String adminid = (String) a.get("ThedeepAUserId");
		
		vo = adminService.selectAdminDetail(adminid);
		model.addAttribute("vo", vo);
		
		return "admin/adminModify";
	}
	
	@RequestMapping(value="/adminModifySave.do")
	@ResponseBody
	public Map<String,Object> updateAdminInfo(AdminVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result ="";
		int cnt = adminService.updateAdmin(vo);
		if(cnt>0) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/orderList.do")
	public String orderList(HttpServletRequest request,ModelMap model,@ModelAttribute("searchVO")DefaultVO searchVO) throws Exception{
		/*HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		searchVO.setUserid(userid);*/
		searchVO.setPageUnit(10);// 한 화면에 출력 개수
		searchVO.setPageSize(10);// 페이지 개수
		if(searchVO.getDstate1() == null && searchVO.getDstate2() == null &&searchVO.getDstate3() == null &&searchVO.getDstate4() == null &&searchVO.getDstate5() == null &&searchVO.getDstate6() == null&&searchVO.getDstate7() == null){
			searchVO.setDstate1("입금전");
			searchVO.setDstate2("결제완료");
			searchVO.setDstate3("배송준비중");
			searchVO.setDstate4("배송중");
			searchVO.setDstate5("배송완료");
			searchVO.setDstate6("취소");
			searchVO.setDstate6("구매확정");
			
		}
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> olist = adminService.selectOrderList(searchVO);
		model.addAttribute("olist",olist);
		int totCnt = adminService.selectOrderListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("search",searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return "admin/orderList";
	}
	@RequestMapping(value="/orderDetail.do")
	public String orderDetail(ModelMap model,@RequestParam("ocode") String ocode) throws Exception{
		
		List<?> olist = adminService.selectOrderDetail(ocode);
		model.addAttribute("olist",olist);
		System.out.println(olist);
		Map<String,String> map = new HashMap<String,String>();
		map = (Map<String, String>) olist.get(0);
		if(map.get("dstate").equals("결제완료")){
			DeliveryVO dvo = new DeliveryVO();
			dvo.setOcode(ocode);
			dvo.setDstate("배송준비중");
			adminService.updateDstate(dvo);
		}
			
		return "admin/orderDetail";
	}
	@RequestMapping(value="/transSave.do")
	@ResponseBody
	public Map<String,Object> orderDetail(DeliveryVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		int cnt = adminService.updateTransNum(vo);
		if(cnt>0) result="ok";
		map.put("result", result);
		return map;
	}
	@RequestMapping(value="/payCheck.do")
	@ResponseBody
	public Map<String,Object> payCheck(DeliveryVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail";
		vo.setDstate("결제완료");
		int cnt = adminService.updateDstate(vo);
		if(cnt>0) result="ok";
		map.put("result", result);
		return map;
	}
	@RequestMapping(value="/adminBoard.do")
	public String adminBoard(ModelMap model,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{

		searchVO.setPageUnit(2);// 한 화면에 출력 개수
		searchVO.setPageSize(2);// 페이지 개수
		
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
		List<?> qlist = adminService.selectQnaList(searchVO);
		model.addAttribute("qlist", qlist);
		int totCnt = adminService.selectQnaTotCnt(searchVO);
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
		List<?> rlist = adminService.selectReviewList(searchVO);
		model.addAttribute("rlist", rlist);
		int totCnt2 = adminService.selectReviewTotCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		searchVO.setSearchKeyword("");
		model.addAttribute("paginationInfo2", paginationInfo2);
		return "admin/adminBoard";
	}
	@RequestMapping(value="/reviewReply.do")
	@ResponseBody
	public Map<String,Object> reviewReply(ReviewReplyVO vo) throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		String result="fail"; 
		result= adminService.insertReviewReply(vo);
		if(result==null) result="ok";
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="/qnaReply.do")
	public String qnaReply(BoardVO vo, ModelMap model) throws Exception{
		
		int unq = vo.getUnq();
		model.addAttribute("unq", unq);
		
		String pwd = vo.getRepwd();
		model.addAttribute("pwd", pwd);
		
		return "admin/qnaReply";
	}
	
	@RequestMapping(value="/qnaReplySave.do")
	@ResponseBody
	public Map<String,Object> insertQnareply(BoardVO vo, ModelMap model, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
		String adminid = (String) a.get("ThedeepAUserId");
		System.out.println("unq  :  " + vo.getUnq());
		vo.setUserid(adminid);
		vo.setPcode("P00005");
		
		String result = adminService.insertQnareply(vo);
		if(result==null) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/qnaRePwdChk.do")
	@ResponseBody
	public Map<String,Object> selectQnaRePwdChk(AdminVO vo,HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
		String adminid = (String) a.get("ThedeepAUserId");
		
		vo.setAdminid(adminid);

		int cnt = adminService.selectQnaRePwdChk(vo);
		if(cnt>0) result = "ok";
		else result = "1";
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/qnaReDetail.do")
	public String selectQnaReDetail(BoardVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		int unq = vo.getUnq();
		
		vo = boardService.selectQnaDetail(unq);
		model.addAttribute("vo", vo);
		
		String a12 = null;
		try {
			HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
			System.out.println("adminid  :  " + a.get("ThedeepAUserId"));
			a12=(String) a.get("ThedeepAUserId");
		} catch(Exception e) { }
		
		int login = 1;
		if(a12==null) {
			boardService.updateQnaHit(unq);
			login = 2;
		}
		
		model.addAttribute("login", login);
		
		return "admin/qnaReDetail";
	}
	
	@RequestMapping(value="/qnaReModify.do")
	public String selectQnaReModify(BoardVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		int unq = vo.getUnq();
		System.out.println("unq  _  " + unq);
		vo = boardService.selectQnaDetail(unq);
		
		model.addAttribute("vo", vo);
		
		return "admin/qnaReModify";
	}
	
	@RequestMapping(value="/qnaReModifySave.do")
	@ResponseBody
	public Map<String,Object> updateQnaReModify(BoardVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result ="";
		int cnt = adminService.updateQnaReModify(vo);
		if(cnt>0) result = "ok";
		else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value = "/qnaReDelete.do")
	@ResponseBody 
	public Map<String,Object> deleteQnaRe(BoardVO bvo, AdminVO vo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result ="";
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
		String adminid = (String) a.get("ThedeepAUserId");
		
		vo.setAdminid(adminid);
		
		int chk = adminService.selectQnaRePwdChk(vo);
		if(chk>0){
			int cnt = adminService.deleteQnaRe(bvo);
			if(cnt>0) result = "ok";
			else result = "2";
		} else result = "1";
			
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/adminCoupon.do")
	public String selectAdminCoupon(CouponVO vo, ModelMap model) throws Exception{
		
		List<?> list = adminService.selectCouponList();
		model.addAttribute("list", list);
		
		String ccode = vo.getCcode();
		
		if(ccode!=null) {
			vo = adminService.selectCouponDetail(ccode);
		}
		
		model.addAttribute("vo", vo);
		
		return "admin/adminCoupon";
	}
	
	@RequestMapping(value = "/adminCouponSave.do")
	@ResponseBody 
	public Map<String,Object> insertAdminCoupon(CouponVO vo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();

		String result = adminService.insertAdminCoupon(vo);
		if(result==null) result = "ok";
		else result = "1";

		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value = "/adminCouponModify.do")
	@ResponseBody 
	public Map<String,Object> updateAdminCoupon(CouponVO vo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";

		int cnt = adminService.updateAdminCoupon(vo);
		if(cnt>0) result = "ok";
		else result = "1";

		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value = "/adminBtdCoupon.do")
	@ResponseBody 
	public Map<String,Object> insertBtdCoupon(CouponVO vo, HttpServletRequest request) throws Exception {
		System.out.println("a");
		Map<String,Object> map = new HashMap<String, Object>();
		
		Calendar cal = Calendar.getInstance();
		
		String result = "";
		
		int tmonth = cal.get(Calendar.MONTH)+1;
		int tday = cal.get(Calendar.DATE);
		String today = "";
		if(tmonth<10) today += "0" + tmonth;
		else today += tmonth + "";
		if(tday<10) today += "0" + tday;
		else today += tday + "";
		
		String edate = "";
		int year = 0;
		int month = 0;
		int day = 0;
		String userid = "";
		
		List<?> list = memberService.selectMemberBTD(today);
		Map<String,String> map2;
		for(int i=0;i<list.size();i++){
			map2 = new HashMap<String,String>();
			map2 = (Map<String, String>) list.get(i);
			userid += map2.get("userid") + " ";
		}
		System.out.println("userid  /  " + userid + "  today  /" + today);
		String[] id = userid.split(" ");
		if(id[0]!="") {
			for(int i=0; i<id.length; i++) {
				userid = id[i];
				int coupon = memberService.selectBTDCoupon(userid);
				if(coupon==0) {
					cal.add(Calendar.MONTH, 1);
					year = cal.get(Calendar.YEAR);
					month = cal.get(Calendar.MONTH)+1;
					day = cal.get(Calendar.DATE);
					edate = year + "-";
					if(month<10) edate += "0" + month + "-";
					else edate += month + "-";
					edate += day + "";
					
					vo.setUserid(userid);
					vo.setEdate(edate);
					
					result = memberService.insertBTDCoupon(vo);
					if(result==null) {
						result = "ok";
					} else result = "1";
				}
			}
		} else result = "2";
		

		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/pointAdd.do")
	public String selectgroup(ModelMap model, PointVO vo) throws Exception{
		List<?> pointList = adminService.selectPointList();
		model.addAttribute("resultList", pointList);

		return "admin/pointAdd";
	}
	
	@RequestMapping(value="/pointAddSave.do")
	@ResponseBody
	public Map<String,Object> insertPoint(PointVO vo) throws Exception{
		Map <String,Object> map = new HashMap<String,Object>();
		String result="";
		int point;
		int cnt = adminService.selectMemberIdChk(vo.getUserid());
		if(cnt > 0) {
			String ablepoint = adminService.selectAblePoint(vo.getUserid());
			//System.out.println("1231//"+ablepoint+"123");
			if(ablepoint==null || ablepoint.equals("")) {
				point = 0;
			} else {
				point = Integer.parseInt(ablepoint);
			}
			vo.setAblepoint(point+vo.getSavepoint());
			result = adminService.insertPoint(vo);
			if(result == null) {
				result = "ok";
			}
		} else {
			result="idchk";
		}
		
		map.put("result", result);
		return map;
	}
}
