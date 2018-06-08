package thedeep.web;


import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
import thedeep.service.CheckVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.GroupVO;
import thedeep.service.MemberService;
import thedeep.service.NoticeVO;
import thedeep.service.OrderListVO;
import thedeep.service.OrderVO;
import thedeep.service.PaymentVO;
import thedeep.service.PointVO;
import thedeep.service.ProductService;
import thedeep.service.ProductVO;
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
	@RequestMapping(value="/CancelApply.do")
	@ResponseBody
	public Map<String,String> CancelApply(HttpServletRequest request, @RequestParam("merchant_uid") String merchant_uid) throws Exception{
		
		//무통장 전체 주문 취소 적용
		String result="fail";
		Map<String,String> map = new HashMap<String,String>();
		System.out.println("inin");
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
		point.setUserid(ovo.getUserid());
		point.setContent("구매취소("+merchant_uid+")");
		ovo = memberService.selectOrderInfo(merchant_uid);
		System.out.println("point3 : "+ovo.getUsepoint()+","+ ovo.getSavepoint());
		point.setUsepoint(ovo.getSavepoint());
		point.setSavepoint(ovo.getUsepoint());
		String ablepoint = adminService.selectAblePoint(ovo.getUserid());
		int ablepoint2 = Integer.parseInt(ablepoint) - point.getUsepoint() + point.getSavepoint();
		point.setAblepoint(ablepoint2);
		memberService.insertPoint(point);
		//adminmemo 수정
		OrderVO vo = new OrderVO();
		vo.setOcode(merchant_uid);
		vo.setAdminmemo("취소요청 처리완료");
		cnt = memberService.updateAdminMemo(vo);
		result="ok";

		map.put("result",result);
		return map;
	}
	@RequestMapping(value="/CancelAlert.do")
	@ResponseBody
	public Map<String,String> CancelAlert(HttpServletRequest request, @RequestParam(name="ocode", required=false) String ocode) throws Exception{
		//무통장 전체주문 취소요청
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String result="fail";
		Map<String,String> map = new HashMap<String,String>();
		OrderVO vo = new OrderVO();
		vo.setOcode(ocode);
		vo.setAdminmemo("취소요청");
		int cnt = memberService.updateAdminMemo(vo);
		if(cnt>0){
			result="ok";
		}
		map.put("result",result);
		return map;
	}
	@RequestMapping(value="/CancelAlert2.do")
	@ResponseBody
	public Map<String,String> CancelAlert2(HttpServletRequest request, @RequestParam(name="ocode", required=false) String ocode, @RequestParam(name="cscode", required=false) String cscode) throws Exception{
		//부분 주문 취소요청
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String result="fail";
		Map<String,String> map = new HashMap<String,String>();
		
		OrderListVO vo = new OrderListVO();
		vo.setOcode(ocode);
		vo.setCscode(cscode);
		int cnt = memberService.updateBuyConfirm3(vo);
		if(cnt>0){
			result="ok";
		}
		map.put("result",result);
		return map;
	}
	@RequestMapping(value="/iamportCancelPart.do")
	@ResponseBody
	public Map<String,String> iamportCancelPart(HttpServletRequest request, @RequestParam(name="ocode", required=false) String ocode, @RequestParam(name="cscode", required=false) String cscode) throws Exception{
		//카드결제 부분 취소
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String result="fail";
		Map<String,String> map = new HashMap<String,String>();
		//BuyConfirm C(취소)로 변경
		OrderListVO vo = new OrderListVO();
		vo.setOcode(ocode);
		vo.setCscode(cscode);
		int cnt = memberService.updateBuyConfirm2(vo);
		//재고수정
		OrderListVO lvo = memberService.selectOrderInfoByOVO(vo);
		ProductVO pvo = new ProductVO();
		pvo.setCscode(cscode);
		pvo.setAmount(lvo.getAmount());
		productService.updateAmount(pvo);
		
		//적립금회수
		PointVO point = new PointVO();
		point.setUserid(userid);
		point.setContent("구매취소("+ocode+")");
		point.setUsepoint((int) Math.floor(lvo.getTotalmoney()*0.001));
		point.setSavepoint(0);
		String ablepoint = adminService.selectAblePoint(userid);
		int ablepoint2 = Integer.parseInt(ablepoint) - point.getUsepoint();
		point.setAblepoint(ablepoint2);
		memberService.insertPoint(point);
		//카드취소
		IamportClient client;
		int disrate = memberService.selectDisRate(ocode);
		BigDecimal cancelAmount = new BigDecimal(lvo.getTotalmoney()/100*(100-disrate));
		client = new IamportClient(api_key, api_secret);
		String token = client.getToken();
		
		CancelData cancel2 = new CancelData(ocode, false,cancelAmount);
		IamportResponse<Payment> cancelpayment2 = client.cancelPayment(cancel2);
		if(cancelpayment2.getMessage()==null){
			result="ok";
		}
		//취소가 아닌게 0개면 dstate 취소로 변경
		cnt = memberService.selectCancelConfirm(ocode);
		if(cnt ==0){
			DeliveryVO dvo = new DeliveryVO();
			dvo.setOcode(ocode);
			dvo.setDstate("취소");
			adminService.updateDstate(dvo); 
		}
		map.put("result",result);
		return map;
	}
	@RequestMapping(value="/depositCancelPart.do")
	@ResponseBody
	public Map<String,String> depositCancelPart(HttpServletRequest request, @RequestParam(name="ocode", required=false) String ocode, @RequestParam(name="cscode", required=false) String cscode) throws Exception{
		//무통장입금 결제 부분 취소
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		String result="fail";
		Map<String,String> map = new HashMap<String,String>();
		//BuyConfirm C(취소)로 변경
		OrderListVO vo = new OrderListVO();
		vo.setOcode(ocode);
		vo.setCscode(cscode);
		int cnt = memberService.updateBuyConfirm2(vo);
		//재고수정
		System.out.println("aaaaaaaaaaaaaa"+ocode+cscode);
		OrderListVO lvo = memberService.selectOrderInfoByOVO(vo);
		ProductVO pvo = new ProductVO();
		pvo.setCscode(cscode);
		pvo.setAmount(lvo.getAmount());
		productService.updateAmount(pvo);
		
		//적립금회수
		PointVO point = new PointVO();
		point.setUserid(userid);
		point.setContent("구매취소("+ocode+")");
		point.setUsepoint((int) Math.floor(lvo.getTotalmoney()*0.001));
		point.setSavepoint(0);
		String ablepoint = adminService.selectAblePoint(userid);
		int ablepoint2 = Integer.parseInt(ablepoint) - point.getUsepoint();
		point.setAblepoint(ablepoint2);
		memberService.insertPoint(point);
		//취소가 아닌게 0개면 dstate 취소로 변경
		cnt = memberService.selectCancelConfirm(ocode);
		if(cnt ==0){
			DeliveryVO dvo = new DeliveryVO();
			dvo.setOcode(ocode);
			dvo.setDstate("취소");
			adminService.updateDstate(dvo); 
		}
		result="ok";
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
	@RequestMapping(value="/reviewReplyDelete.do")
	 @ResponseBody
	public Map<String,Object> reviewReplyDelete(AdminVO vo, HttpServletRequest request) throws Exception {
		String result="fail";
		String unq = request.getParameter("unq");
		Map<String,Object> map = new HashMap<String, Object>();
		int cnt = adminService.deleteReviewReply(unq);
		if(cnt>0)result="ok";
		map.put("result", result);
		
		return map;
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
			searchVO.setDstate7("구매확정");
			
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
	public String selectAdminCoupon(CouponVO vo, ModelMap model,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		
		searchVO.setPageUnit(10); 	// 한 화면 출력 개수
		searchVO.setPageSize(10);	// 페이지 너비 개수
		
		PaginationInfo paginationInfo2 = new PaginationInfo();
		paginationInfo2.setCurrentPageNo(searchVO.getPageIndex2());
		paginationInfo2.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo2.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo2.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo2.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo2.getRecordCountPerPage());

		List<?> list = adminService.selectCouponList(searchVO);
		model.addAttribute("list", list);
		
		int totCnt2 = adminService.selectCouponListCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		model.addAttribute("paginationInfo2", paginationInfo2);

		String ccode = vo.getCcode();
		
		if(ccode!=null) {
			vo = adminService.selectCouponDetail(ccode);
		}
		
		model.addAttribute("vo", vo);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> list2 = adminService.selectAdminList(searchVO);
		model.addAttribute("list2", list2);
		
		int totCnt = adminService.selectAdminListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/adminCoupon";
	}
	
	@RequestMapping(value = "/adminCouponSave.do")
	@ResponseBody 
	public Map<String,Object> insertAdminCoupon(CouponVO vo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String maxCode = adminService.selectMaxCode();
		int add = Integer.parseInt(maxCode) + 1;
		
		String creatCode = "";
		if(add<10) creatCode += "c00" + add;
		else if(add<100) creatCode += "c0" + add;
		else creatCode += "c" + add;
		
		vo.setCcode(creatCode);
		
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
		String bmonth = "";
		if (tmonth<10) bmonth = "0" + tmonth;
		else bmonth = tmonth + "";
		String userid = "";
		
		cal.add(Calendar.MONTH, 1);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		String edate = year + "-";
		if(month<10) edate += "0" + month + "-";
		else edate += month + "-";
		if(day<10) edate += "0" + day;
		else edate += day + "";
		
		List<?> list = memberService.selectMemberBTD(bmonth);
		Map<String,String> map2;
		for(int i=0;i<list.size();i++){
			map2 = new HashMap<String,String>();
			map2 = (Map<String, String>) list.get(i);
			userid += map2.get("userid") + " ";
		}
		System.out.println("userid  /  " + userid + "  today  /" + bmonth);
		String[] id = userid.split(" ");
		if(id[0]!="") {
			for(int i=0; i<id.length; i++) {
				userid = id[i];
				int coupon = memberService.selectBTDCoupon(userid);
				if(coupon==0) {
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
	
	@RequestMapping(value = "/adminCouponDel.do")
	@ResponseBody 
	public Map<String,Object> deleteAdminCoupon(CouponVO vo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";
		
		String ccode = vo.getCcode();

		int cnt = adminService.deleteAdminCoupon(ccode);
		if(cnt>0) result = "ok";
		else result = "1";

		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value = "/adminCouponOut.do")
	@ResponseBody 
	public Map<String,Object> insertAdminCouponOut(CheckVO cvo, HttpServletRequest request) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		Calendar cal = Calendar.getInstance();
		
		String result = "";
		
		String ccode = cvo.getCcode1();
		String check = cvo.getCheck();
		String cname = "";
		String cnt = "";

		cal.add(Calendar.MONTH, 1);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DATE);
		String edate = year + "-";
		if(month<10) edate += "0" + month + "-";
		else edate += month + "-";
		if(day<10) edate += "0" + day;
		else edate += day + "";
		
		
		String[] userid = check.split(",");
		for(int i=0; i<userid.length; i++) {
			cvo.setUserid(userid[i]);
			cname = adminService.selectCouponName(ccode);
			if(cname!=null) {
				cvo.setEdate(edate);
				cvo.setCname(cname);
				System.out.println(edate + "  /  " + cname + "  / " + ccode);
				cnt = adminService.insertAdminCouponOut(cvo);
			}
		}
		if(cnt==null) result = "ok";
		else result = "1";

		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/pointAdd.do")
	public String selectgroup(ModelMap model, PointVO vo, @ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		
		/** EgovPropertyService.sample */
		/* context-properties.xml */
		searchVO.setPageUnit(30); // 한화면의 출력 개수
		searchVO.setPageSize(30); // 페이지 너버 개수

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = adminService.selectPointList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = adminService.selectPointListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
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
	
	@RequestMapping(value="/productAdd.do")
	public String selectProductAdd(ModelMap model) throws Exception{
		List<?> groupName = productService.selectGname();
		model.addAttribute("group", groupName);
		
		return "admin/productAdd";
	}
	
	@RequestMapping(value = "/productAddSave.do")
	@ResponseBody 
	public Map<String, String> productAddSave (
					final MultipartHttpServletRequest multiRequest,
					HttpServletResponse response, 
					ProductVO vo,
					ModelMap model) throws Exception {
		
		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String result="",result1="",result2="";
		int pcode;
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		String psize = vo.getPsize();
		String[] splitpsize = psize.split(",");
		
		String color = vo.getColor();
		String[] splitcolor = color.split(",");
		
		pcode = productService.selectPcode();
		vo.setMaxpcode(pcode);
		
		HashMap imap = (HashMap) multipartProcess(files,uploadPath,pcode);
		vo.setMainfile((String) imap.get("fileName"));
		
		for(int i=0; i<splitpsize.length; i++) {
			for(int j=0; j<splitcolor.length; j++) {
				vo.setPsize(splitpsize[i]);
				vo.setColor(splitcolor[j]);
				
				result1 = productService.insertProduct(vo);
				result2 = productService.insertProductStock(vo);
			}
		}
		
		if(result1 == null && result2 == null) result = "ok";
		
		String hiddenPcode = "P"+ String.format("%05d", pcode);
		map.put("pcode", hiddenPcode);
		
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	

	
	public static Map multipartProcess (Map files,String uploadPath,int pcode) {
		MultipartFile file;
		String filePath = "";
		int cnt = 0;
		Map<String,String> map = new HashMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();

		String filename = "";
		int filesize = 0;
		String errCode = "";
		String exeName = "";
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {

				String realFile = file.getOriginalFilename();

				if(realFile.lastIndexOf(".") == -1) {
					errCode = "-1";
				}  else {
					String[] array = realFile.split("\\.");
					exeName = array[array.length-1];
					exeName = exeName.toLowerCase();
					if(    !exeName.equals("jpg") 
					    && !exeName.equals("jpeg") 
					    && !exeName.equals("gif") 
					    && !exeName.equals("bmp") )
					{
						errCode = "0";
					} else {
						if(file.getSize() > 1024*1024*5) {
							errCode = "1";
						}
					}
				}

				
				if(errCode.equals("")) {
					System.out.println(errCode);
					filename = "P"+ String.format("%05d", pcode) + "." + exeName;
					filePath = uploadPath + "\\" + filename;
					filesize = (int)file.getSize();
					// 물리적인 파일 저장 -> transferTo
					try {
						file.transferTo(new File(filePath));
						cnt++;
					} catch(Exception e) {
						errCode = "2";
					}
				}	
			}
		}
		map.put("fileName", filename);
		map.put("fileSize", filesize+"");
		map.put("cnt", cnt+"");
		map.put("errCode", errCode);
		return map;
	}
	
	
	@RequestMapping(value="/productModify.do")
	public String selectProductModify(ProductVO vo, ModelMap model) throws Exception{
		String pcode = vo.getPcode();
		
		vo = productService.selectProductDetail(pcode);
		model.addAttribute("vo", vo);
		
		List<?> groupList = productService.selectGroupList();
		model.addAttribute("group", groupList);
		
		List<?> CsList = productService.selectCsList(pcode);
		model.addAttribute("cs", CsList);
		
		List<?> color = productService.selectColorList(pcode);
		model.addAttribute("color", color);
		
		
		return "admin/productModify";
	}
	
	@RequestMapping(value = "/productModifySave.do")
	@ResponseBody 
	public Map<String, String> updateProductModify (
						final MultipartHttpServletRequest multiRequest,
						HttpServletResponse response, 
						ProductVO vo,
						ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		String result="",result1="",result2="", CS="";
		int pcode,cnt,cnt2=0;
		String psize = vo.getPsize();
		String color = vo.getColor();
		if(vo.getPsize()!=null || vo.getColor()!=null) {
			String[] splitpsize = psize.split(",");
			String[] splitcolor = color.split(",");
			//현재 있는 색상,사이즈 추가안되게
			for(int i=0; i<splitpsize.length; i++) {
				for(int j=0; j<splitcolor.length; j++) {
					vo.setPsize(splitpsize[i]);
					vo.setColor(splitcolor[j]);
					cnt2 = adminService.selectColorSize(vo);
					cnt2 += cnt2;
				}
			}
		}
		
		if(cnt2 > 0) {
			CS = "no";
			map.put("CS", CS);
		} else {
			String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages";
			
			File saveFolder = new File(uploadPath);
			if (!saveFolder.exists()) {
				saveFolder.mkdirs();
			}
			pcode = Integer.parseInt(vo.getPcode().substring(1));
			//System.out.println("123"+vo.getMainfile()+"456");
			HashMap imap = (HashMap) multipartProcess(files,uploadPath,pcode);
			String test = (String) imap.get("fileName");
			
			if(test==null || test.equals("")) {
				vo.getFilename();
			} else {
				vo.setMainfile(test);
			}
			//System.out.println("123"+vo.getMainfile()+"456");
			
			if(vo.getPsize()==null || vo.getColor()==null) {
				cnt = productService.updateProduct(vo);
				if(cnt>0) result = "ok";
				map.put("result", result);
			} else {
				cnt = productService.updateProduct(vo);
				vo.setColor(color);
				vo.setPsize(psize);
				String[] splitpsize = psize.split(",");
				String[] splitcolor = color.split(",");
				
				for(int i=0; i<splitpsize.length; i++) {
					for(int j=0; j<splitcolor.length; j++) {
						vo.setPsize(splitpsize[i]);
						vo.setColor(splitcolor[j]);
			
						result1 = productService.insertProductModify(vo);
						result2 = productService.insertProductStockModify(vo);
					}
				}
				if(result1 == null && result2 == null) result = "ok";
				map.put("result", result);
			}
		
			map.put("cnt", (String) imap.get("cnt")); // 0,1
			map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		}
		
		return map;

	}
	
	@RequestMapping(value="/productFileDelete.do")
	@ResponseBody 
	public Map<String,Object> updateProductFile (ProductVO vo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages";
		String fullPath = "";
		String result = "";
		String mainfile="";
		String delmainfile=vo.getMainfile();
		
		
		mainfile=delmainfile.replace(delmainfile,"");
		vo.setMainfile(mainfile);

		int cnt = productService.updateProductFile(vo);

		if(cnt > 0) {
			fullPath = uploadPath+"\\"+delmainfile;
			File file = new File(fullPath);
			file.delete();
			result="1";
		}
		else {
			result = "-1";
		}

		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value="/productDelete.do")
	@ResponseBody
	public Map<String, Object> deleteProduct(
			HttpServletRequest request,
			HttpServletResponse response, 
			ProductVO vo) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages";
		String fullPath = "", result="";
		int cnt = productService.deleteProduct(vo);	
		
		if(cnt > 0) {
			String mainfile = vo.getMainfile();
			fullPath = uploadPath+"\\"+mainfile;
			File file = new File(fullPath);
			file.delete();
			result="ok";
			
		}
		map.put("result", result);
		map.put("cnt", cnt);
		return map;
	}
	
	@RequestMapping(value="/productCsDelete.do")
	@ResponseBody
	public Map<String,Object> deleteCsProduct(
			HttpServletRequest request,
			HttpServletResponse response, 
			ProductVO vo) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String result="";
		int cnt = productService.deleteCsProduct(vo);	
		
		if(cnt > 0) result="ok";

		map.put("result", result);
		map.put("cnt", cnt);
		
		return map;
	}
	@RequestMapping(value="/productListView.do")
	public String selectProductListView(
			@ModelAttribute("searchVO") DefaultVO searchVO,ModelMap model) 
				throws Exception {

		/** EgovPropertyService.sample */
		/* context-properties.xml */
		searchVO.setPageUnit(10); // 한화면의 출력 개수
		searchVO.setPageSize(10); // 페이지 너버 개수

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = productService.selectProductListView(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = productService.selectProductListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "admin/productListView";
	}
	
	@RequestMapping(value="/productAmountAdd.do")
	@ResponseBody
	public Map<String,Object> updateAmount (ProductVO vo) throws Exception  {
		Map<String,Object> map = new HashMap<String,Object>();
		String result="0";
		int cnt1,cnt2,nowAmount;
		
		cnt1 = productService.updateAmount(vo);
		nowAmount = productService.selectAmount(vo);
		System.out.println(nowAmount);
		if(cnt1 > 0) {
			if(nowAmount > 0) {
				cnt2 = productService.updateNotSoldout(vo);
			} else {
				cnt2 = productService.updateSoldout(vo);
			}
			
			if(cnt2 > 0) result="1";
			else result = "-1";
		}


		map.put("result",result);
		
		return map;
	}
	
	@RequestMapping(value="/group.do")
	public String selectgroup(ModelMap model, GroupVO vo) throws Exception{
		vo = productService.selectGroup(vo.getGcode());
		
		List<?> groupList = productService.selectGroupList();
		model.addAttribute("resultList", groupList);
		model.addAttribute("group", vo);
		return "admin/group";
	}
	
	@RequestMapping(value="/groupSave.do")
	@ResponseBody
	public Map<String,Object> insertgroup(GroupVO vo) throws Exception{
		Map <String,Object> map = new HashMap<String,Object>();
		String result="";
		result = productService.insertgroup(vo);
		if(result == null) {
			result = "ok";
		}
		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value = "/groupModify.do")
	@ResponseBody
	public Map<String,Object> updateGroup (GroupVO vo) throws Exception  {
		Map<String,Object> map = new HashMap<String,Object>();
		String result="";
		
		int cnt = productService.updateGroup(vo);
		if(cnt > 0) result="1";
		else result = "-1";
		
		map.put("result",result);
		
		return map;
	}
	@RequestMapping(value = "/groupDelete.do")
	@ResponseBody
	public Map<String,Object> deleteGroup (GroupVO vo) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		String result="";
		
		int cnt = productService.deleteGroup(vo.getGcode());
		if(cnt > 0) result="1";
		else result = "-1";
		
		map.put("result",result);
		
		return map;
	}
	
	@RequestMapping("/updateSmartEditor.do")
	@ResponseBody
	public Map<String,Object> updateSmartEditor (ProductVO vo) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();
		
		System.out.println("에디터 컨텐츠값:"+vo.getEditor());
		System.out.println("pcode :"+vo.getPcode());
		
		int cnt = productService.updateSmartEditor(vo);
		
		return map;
	}
	

	//단일파일업로드

	@RequestMapping("/photoUpload.do")

	public String photoUpload(HttpServletRequest request, ProductVO vo){

	    String callback = vo.getCallback();
	    String callback_func = vo.getCallback_func();
	    String file_result = "";

	    try {

	        if(vo.getFiledata() != null && vo.getFiledata().getOriginalFilename() != null && !vo.getFiledata().getOriginalFilename().equals("")){
	            //파일이 존재하면
	            String original_name = vo.getFiledata().getOriginalFilename();
	            String ext = original_name.substring(original_name.lastIndexOf(".")+1);

	            //파일 기본경로
	            //String defaultPath = request.getSession().getServletContext().getRealPath("/");

	            //파일 기본경로 _ 상세경로
	            String path = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages" + File.separator;              
	            File file = new File(path);
	            System.out.println("path:"+path);

	            //디렉토리 존재하지 않을경우 디렉토리 생성
	            if(!file.exists()) {
	                file.mkdirs();
	            }

	            //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
	            String realname = UUID.randomUUID().toString() + "." + ext;

	        ///////////////// 서버에 파일쓰기 ///////////////// 
	            vo.getFiledata().transferTo(new File(path+realname));
	            file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=/productImages/"+realname;

	        } else {
	            file_result += "&errstr=error";
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "redirect:" + callback + "?callback_func="+callback_func+file_result;

	}
	
	@RequestMapping(value="/adminNoticeWrite.do")
	public String selectNoticeWrite() throws Exception{
		return "admin/adminNoticeWrite";
	}
	
	@RequestMapping(value = "/adminNoticeWriteSave.do")
	@ResponseBody 
	public Map<String, String> noticeWriteSave (
					final MultipartHttpServletRequest multiRequest,
					HttpServletResponse response, 
					NoticeVO vo,
					ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\noticeImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		HashMap imap = (HashMap) multipartProcess(files,uploadPath);

		vo.setFilename((String) imap.get("fileName"));

		String result = boardService.insertnotice(vo);
		if(result == null) result = "ok";
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	
	@RequestMapping(value = "/adminNoticeDelete.do")
	@ResponseBody 
	public Map<String, Object> deleteNotice(
			HttpServletRequest request,
			HttpServletResponse response, 
			NoticeVO vo) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\noticeImages";
		String fullPath = "", result="";
		
		int cnt = boardService.deleteNotice(vo);
		if(cnt > 0) {
			String filenames = vo.getFilename();
			String[] filename = filenames.split(",");
			for(int i=0; i<filename.length; i++) {
				fullPath = uploadPath+"\\"+filename[i];
				File file = new File(fullPath);
				file.delete();
			}
			result="ok";
		}
		map.put("result", result);
		map.put("cnt", cnt);
		return map;
	}

	@RequestMapping(value="/adminNoticeList.do")
	public String selectNoticeList(
			@ModelAttribute("searchVO") DefaultVO searchVO,ModelMap model,HttpServletRequest request) 
				throws Exception {

		/** EgovPropertyService.sample */
		/* context-properties.xml */
		searchVO.setPageUnit(10); // 한화면의 출력 개수
		searchVO.setPageSize(10); // 페이지 너버 개수

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> sampleList = boardService.selectNoticeList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = boardService.selectNoticeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		String AUserid = null;
		int login;
		try {
			HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
			AUserid=(String) a.get("ThedeepAUserId");
			login = 1;
		} catch(Exception e) {
			login = 2;
		}
		
		model.addAttribute("login", login);
		
		return "admin/adminNoticeList";
	}
	
	@RequestMapping(value="/adminNoticeDetail.do")
	public String selectNoticeDetail(NoticeVO vo,ModelMap model) throws Exception {
		
		int unq = vo.getUnq();
		boardService.updateNoticeHit(unq);
		vo = boardService.selectNoticeDetail(unq);
		model.addAttribute("vo", vo);
		
		return "admin/adminNoticeDetail";
	}
	
	@RequestMapping(value="/adminNoticeModify.do")
	public String noticewModify(NoticeVO vo,ModelMap model) 
				throws Exception {
		
		int unq = vo.getUnq();
		
		vo = boardService.selectNoticeDetail(unq);
		model.addAttribute("vo", vo);
		
		return "admin/adminNoticeModify";
	}
	
	@RequestMapping(value = "/adminNoticeFileDelete.do")
	@ResponseBody 
	public Map<String,Object> updateNoticeFile (ReviewVO vo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\noticeImages";
		String fullPath = "";
		String result = "";
		String filename=vo.getFilename();
		String delfilename=vo.getDelfilename();
		
		
		filename=filename.replace(delfilename,"");
		vo.setFilename(filename);
		
		int cnt = boardService.updateNoticeFile(vo);

		if(cnt > 0) {
			String[] splitfilename = delfilename.split(",");
			for(int i=0; i<splitfilename.length; i++) {
				fullPath = uploadPath+"\\"+splitfilename[i];
				File file = new File(fullPath);
				file.delete();
			}
			result="1";
		}
		else {
			result = "-1";
		}

		map.put("result", result);
		return map;
	}
	
	@RequestMapping(value = "/adminNoticeModifySave.do")
	@ResponseBody 
	public Map<String, String> updateNoticeModify (
						final MultipartHttpServletRequest multiRequest,
						HttpServletResponse response, 
						NoticeVO vo,
						ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		String result="";
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\noticeImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		
		String nowfilename = boardService.selectNoticeNowFilename(vo.getUnq());
		HashMap imap = (HashMap) multipartProcess(files,uploadPath);
		
		if(nowfilename==null) {
			vo.setFilename((String) imap.get("fileName"));
		} else {
			vo.setFilename((String) nowfilename+imap.get("fileName"));
		}
		System.out.println(vo.getFilename());
		
		int cnt = boardService.updateNotice(vo);
		if(cnt > 0) result = "ok";
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	public static Map multipartProcess (Map files,String uploadPath) {
		MultipartFile file;
		String filePath = "";
		int cnt = 0;
		Map<String,String> map = new HashMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();

		String filename = "";
		String filenames = "";
		int filesize = 0;
		String errCode = "";
		String exeName = "";
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {

				String realFile = file.getOriginalFilename();

				if(realFile.lastIndexOf(".") == -1) {
					errCode = "-1";
				}  else {
					String[] array = realFile.split("\\.");
					exeName = array[array.length-1];
					exeName = exeName.toLowerCase();
					if(    !exeName.equals("jpg") 
					    && !exeName.equals("jpeg") 
					    && !exeName.equals("gif") 
					    && !exeName.equals("bmp")
					    && !exeName.equals("png"))
					{
						errCode = "0";
					} else {
						if(file.getSize() > 1024*1024*5) {
							errCode = "1";
						}
					}
				}
				long unixTime = System.currentTimeMillis();
				Random rn = new Random();
				int b = rn.nextInt(90);

				if(errCode.equals("")) {
					System.out.println(errCode);
					filename = unixTime+b+"."+exeName;
					filenames += filename + ",";
					filePath = uploadPath + "\\" + filename;
					filesize = (int)file.getSize();
					String targetPath = uploadPath + "\\" + unixTime+"_1."+exeName;
					// 물리적인 파일 저장 -> transferTo
					try {
						file.transferTo(new File(filePath));
						
						//imeCreate(uploadPath,unixTime+"",exeName,100);
						//imeCreate(uploadPath,unixTime+"",exeName,80);
						
						//imageResize(uploadPath,unixTime+"",exeName,100);
						//imageResize(uploadPath,unixTime+"",exeName,80);
						
						cnt++;
						
						// Thumbnail (썸네일) 이미지 생성
						// (현재파일경로,New파일경로,타입,크기)
						//imageResize(filePath,targetPath,"jpg",70);
						
					} catch(Exception e) {
						errCode = "2";
					}
				}	
			}
		}
		map.put("fileName", filenames);
		map.put("fileSize", filesize+"");
		map.put("cnt", cnt+"");
		map.put("errCode", errCode);
		return map;
	}
	
	@RequestMapping(value="/adminQnaDetail.do")
	public String selectQnaDetail(BoardVO vo,ModelMap model,HttpServletRequest request) throws Exception{
		
		int unq = vo.getUnq();
		boardService.updateQnaHit(unq);
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
			login = 2;
		}
		
		model.addAttribute("login", login);
		
		return "admin/adminQnaDetail";
	}
}
