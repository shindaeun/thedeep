package thedeep.web;

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

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.ReviewReplyVO;

@Controller
public class AdminController {
	
	@Resource(name="adminService")
	AdminService adminService;
	
	@Resource(name="boardService")
	BoardService boardService;
	
	@RequestMapping(value="/adminInfo.do")
	public String insertAdminInfo() throws Exception{
		return "admin/adminInfo";
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
	public String orderList(ModelMap model,@ModelAttribute("searchVO")DefaultVO searchVO) throws Exception{
		String userid="userid1";
		searchVO.setUserid(userid);
		searchVO.setPageUnit(1);// 한 화면에 출력 개수
		searchVO.setPageSize(1);// 페이지 개수
		if(searchVO.getDstate1() == null && searchVO.getDstate2() == null &&searchVO.getDstate3() == null &&searchVO.getDstate4() == null &&searchVO.getDstate5() == null){
			searchVO.setDstate1("입금전");
			searchVO.setDstate2("결제완료");
			searchVO.setDstate3("배송준비중");
			searchVO.setDstate4("배송중");
			searchVO.setDstate5("배송완료");
			
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
		int cnt = adminService.updateDstate(vo.getOcode());
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
	
	
}
