package thedeep.web;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.MemberVO;
import thedeep.service.NoticeVO;
import thedeep.service.OrderListVO;
import thedeep.service.ReviewVO;

@Controller
public class BoardController {
	
	@Resource(name = "multipartResolver")
	CommonsMultipartResolver  multipartResolver;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value="/qnaList.do")
	public String selectUploadList(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model, BoardVO vo,HttpServletRequest request) throws Exception {
		

		searchVO.setPageUnit(10);
		searchVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> list = boardService.selectQnaList(searchVO);
		model.addAttribute("list", list);
		
		int totCnt = boardService.selectQnaListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		String a12 = null;
		try {
			HashMap a = (HashMap) request.getSession().getAttribute("ThedeepALoginCert");
			a12=(String) a.get("ThedeepAUserId");
		} catch(Exception e) { }
		
		int login = 1;
		if(a12==null) {
			login = 2;
		}
		
		model.addAttribute("login", login);
		
		return "board/qnaList";
	}
	
	@RequestMapping(value="/qnaWrite.do")
	public String insertQnaWrite(ModelMap model,HttpServletRequest request) throws Exception{
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		String name = boardService.selectUserName(userid);
		
		model.addAttribute("name", name);
		
		return "board/qnaWrite";
	}
	
	@RequestMapping(value = "/qnaWriteSave.do")
	@ResponseBody 
	public Map<String, String> qnaWriteSave (
					final MultipartHttpServletRequest multiRequest,
					HttpServletResponse response, 
					BoardVO vo,
					ModelMap model,
					HttpServletRequest request) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String uploadPath = "C:\\Users\\acorn\\workspace\\thedeep\\src\\main\\webapp\\qnaImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		HashMap imap = (HashMap) multipartProcess(files,uploadPath);

		vo.setFilename((String) imap.get("fileName"));
		
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		
		vo.setUserid(userid);
		vo.setPcode("P00021");
		
		String result = boardService.insertQnaWrite(vo);
		if(result == null) result = "ok";
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	
	@RequestMapping(value="/qnaLock.do")
	public String qnaLock(BoardVO vo, ModelMap model, HttpServletRequest request) throws Exception{
		
		int unq = vo.getUnq();
		model.addAttribute("unq", unq);
		
		String t = boardService.selectQnaTitle(unq);
		model.addAttribute("t", t);
		
		return "board/qnaLock";
	}
	
	@RequestMapping(value="/qnaDetail.do")
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
		
		return "board/qnaDetail";
	}
	
	@RequestMapping(value="/qnaPwdChk.do")
	@ResponseBody
	public Map<String,Object> selectQnaPwdChk(BoardVO vo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		String result = "";

		int cnt = boardService.selectQnaPwdChk(vo);
		if(cnt>0) result = "ok";
		else result = "1";
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value="/qnaModify.do")
	public String updateQnaModify(BoardVO vo, ModelMap model) throws Exception{
		
		int unq = vo.getUnq();
		
		vo = boardService.selectQnaDetail(unq);
		model.addAttribute("vo", vo);
		
		return "board/qnaModify";
	}
	
	@RequestMapping(value = "/qnaFileDelete.do")
	@ResponseBody 
	public Map<String,Object> updateQnaFile (BoardVO vo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\Users\\acorn\\workspace\\thedeep\\src\\main\\webapp\\qnaImages";
		String fullPath = "";
		String result = "";
		String filename=vo.getFilename();
		String delfilename=vo.getDelfilename();
		
		
		filename=filename.replace(delfilename,"");
		vo.setFilename(filename);
		
		int cnt = boardService.updateQnaFile(vo);

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
	
	@RequestMapping(value = "/qnaModifySave.do")
	@ResponseBody 
	public Map<String, String> updateQnaModify (
						final MultipartHttpServletRequest multiRequest,
						HttpServletResponse response, 
						BoardVO vo,
						ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		String result="";
		String uploadPath = "C:\\Users\\acorn\\workspace\\thedeep\\src\\main\\webapp\\qnaImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		
		String nowfilename = boardService.selectQnaNowFilename(vo.getUnq());
		HashMap imap = (HashMap) multipartProcess(files,uploadPath);
		
		if(nowfilename==null) {
			vo.setFilename((String) imap.get("fileName"));
		} else {
			vo.setFilename((String) nowfilename+imap.get("fileName"));
		}
		
		int cnt = boardService.updateQna(vo);
		if(cnt > 0) result = "ok";
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	
	@RequestMapping(value = "/qnaDelete.do")
	@ResponseBody 
	public Map<String, Object> deleteQna(
			HttpServletRequest request,
			HttpServletResponse response, 
			BoardVO vo) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\Users\\acorn\\workspace\\thedeep\\src\\main\\webapp\\qnaImages";
		String fullPath = "", result="";
		
		int chk = boardService.selectQnaPwdChk(vo);
		int cnt = 0;
		
		if(chk>0) {
			cnt = boardService.deleteQna(vo);
			if(cnt > 0) {
				String filenames = vo.getFilename();
				String[] filename = filenames.split(",");
				for(int i=0; i<filename.length; i++) {
					fullPath = uploadPath+"\\"+filename[i];
					File file = new File(fullPath);
					file.delete();
				}
				result="ok";
			} else result = "0";
		}
		else result = "1";
		
		map.put("result", result);
		map.put("cnt", cnt);
		
		return map;
	}
	
	@RequestMapping(value="/noticeWrite.do")
	public String selectNoticeWrite() throws Exception{
		return "board/noticeWrite";
	}
	
	@RequestMapping(value = "/noticeWriteSave.do")
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
	
	@RequestMapping(value = "/noticeDelete.do")
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

	@RequestMapping(value="/noticeList.do")
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

		return "board/noticeList";
	}
	
	@RequestMapping(value="/noticeDetail.do")
	public String selectNoticeDetail(NoticeVO vo,ModelMap model) throws Exception {
		
		int unq = vo.getUnq();
		boardService.updateNoticeHit(unq);
		vo = boardService.selectNoticeDetail(unq);
		model.addAttribute("vo", vo);
		
		return "board/noticeDetail";
	}
	
	@RequestMapping(value="/noticeModify.do")
	public String noticewModify(NoticeVO vo,ModelMap model) 
				throws Exception {
		
		int unq = vo.getUnq();
		
		vo = boardService.selectNoticeDetail(unq);
		model.addAttribute("vo", vo);
		
		return "board/noticeModify";
	}
	
	@RequestMapping(value = "/noticeFileDelete.do")
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
	
	@RequestMapping(value = "/noticeModifySave.do")
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
	
	
	
	@RequestMapping(value="/reviewWrite.do")
	public String reviewWrite() throws Exception{
		return "board/reviewWrite";
	}
	
	@RequestMapping(value = "/reviewWriteSave.do")
	@ResponseBody 
	public Map<String, String> reviewWriteSave (
					final MultipartHttpServletRequest multiRequest,
					HttpServletResponse response, 
					HttpServletRequest request,
					ReviewVO vo,
					OrderListVO ovo,
					ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\reviewImages";
		String result="";
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		HashMap imap = (HashMap) multipartProcess(files,uploadPath);

		vo.setFilename((String) imap.get("fileName"));
		
		System.out.println(vo.getPcode());
		HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
		String userid = (String) a.get("ThedeepUserId");
		vo.setUserid(userid);
		
		int reviewconfirm = boardService.updateOrderList(ovo);
		if(reviewconfirm > 0) {
			result = boardService.insertReview(vo);
			if(result == null) result = "ok";
		}else {
			result="f";
		}
		
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	
	
	/*
	 *   자료실 이미지 저장
	 */
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
	
	
	@RequestMapping(value="/reviewList.do")
	public String selectReviewList(
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

		List<?> sampleList = boardService.selectReviewList(searchVO);
		model.addAttribute("resultList", sampleList);

		int totCnt = boardService.selectReviewListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "board/reviewList";
	}
	
	@RequestMapping(value="/reviewDetail.do")
	public String selectReviewDetail(ReviewVO vo,ModelMap model) throws Exception {
		
		int unq = vo.getUnq();
		boardService.updateReviewHit(unq);
		vo = boardService.selectReviewDetail(unq);
		model.addAttribute("vo", vo);
		
		List<?> rlist = boardService.selectReviewReplyList(unq);
		model.addAttribute("rlist", rlist);
		return "board/reviewDetail";
	}

	
	@RequestMapping(value="/reviewModify.do")
	public String reviewModify(ReviewVO vo,ModelMap model) 
				throws Exception {
		
		int unq = vo.getUnq();
		
		vo = boardService.selectReviewDetail(unq);
		model.addAttribute("vo", vo);
		
		return "board/reviewModify";
	}
	
	@RequestMapping(value = "/reviewFileDelete.do")
	@ResponseBody 
	public Map<String,Object> updateReviewFile (ReviewVO vo) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\reviewImages";
		String fullPath = "";
		String result = "";
		String filename=vo.getFilename();
		String delfilename=vo.getDelfilename();
		
		
		filename=filename.replace(delfilename,"");
		vo.setFilename(filename);
		
		int cnt = boardService.updateReviewFile(vo);

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
	
	@RequestMapping(value = "/reviewModifySave.do")
	@ResponseBody 
	public Map<String, String> updateReviewModify (
						final MultipartHttpServletRequest multiRequest,
						HttpServletResponse response, 
						ReviewVO vo,
						ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		String result="";
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\reviewImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}
		
		String nowfilename = boardService.selectReviewNowFilename(vo.getUnq());
		HashMap imap = (HashMap) multipartProcess(files,uploadPath);
		
		if(nowfilename==null) {
			vo.setFilename((String) imap.get("fileName"));
		} else {
			vo.setFilename((String) nowfilename+imap.get("fileName"));
		}
		System.out.println(vo.getFilename());
		
		int cnt = boardService.updateReview(vo);
		if(cnt > 0) result = "ok";
		map.put("result", result);  //  ( Json 이름, 데이터 )
		map.put("cnt", (String) imap.get("cnt")); // 0,1
		map.put("errCode",(String) imap.get("errCode")); // => -1,0,1
		// Json =>  result=ok&cnt=1
		
		return map;
	}
	
	@RequestMapping(value = "/reviewDelete.do")
	@ResponseBody 
	public Map<String, Object> deleteReview(
			HttpServletRequest request,
			HttpServletResponse response, 
			ReviewVO vo) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\reviewImages";
		String fullPath = "", result="";
		
		int cnt = boardService.deleteReview(vo);
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
	
	
}
