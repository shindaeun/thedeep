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
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;

@Controller
public class AdminController {
	
	@Resource(name="adminService")
	AdminService adminService;
	
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
	public String orderList() throws Exception{
		return "admin/orderList";
	}
	@RequestMapping(value="/orderDetail.do")
	public String orderDetail() throws Exception{
		return "admin/orderDetail";
	}
	@RequestMapping(value="/adminBoard.do")
	public String adminBoard() throws Exception{
		return "admin/adminBoard";
	}
	@RequestMapping(value="/reviewReply.do")
	public String reviewReply() throws Exception{
		return "admin/reviewReply";
	}
	
	@RequestMapping(value="/qnaReply.do")
	public String qnaReply(BoardVO vo, ModelMap model) throws Exception{
		
		int unq = vo.getUnq();
		model.addAttribute("unq", unq);
		
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
}
