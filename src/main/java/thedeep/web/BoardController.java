package thedeep.web;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.enterprise.inject.Model;
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
import thedeep.service.ReviewVO;

@Controller
public class BoardController {
	
	@Resource(name = "multipartResolver")
	CommonsMultipartResolver  multipartResolver;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value="/noticeList.do")
	public String selectNoticeList() throws Exception{
		return "board/noticeList";
	}
	@RequestMapping(value="/noticeDetail.do")
	public String noticeDetail() throws Exception{
		return "board/noticeDetail";
	}
	
	@RequestMapping(value="/qnaList.do")
	public String selectUploadList(@ModelAttribute("searchVO") DefaultVO searchVO, ModelMap model, BoardVO vo) throws Exception {
		

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
		model.addAttribute("resultList", list);
		
		int totCnt = boardService.selectQnaListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "board/qnaList";
	}
	
	@RequestMapping(value="/qnaWrite.do")
	public String insertQnaWrite() throws Exception{
		return "board/qnaWrite";
	}
	
	/*@RequestMapping(value = "/qnaWriteSave.do")
	@ResponseBody public Map<String, String> multipartProcess(
						final MultipartHttpServletRequest multiRequest,
						HttpServletResponse response, 
						BoardVO vo,
						ModelMap model) throws Exception {
		MultipartFile file;;
		String filePath = "";
		int cnt = 0;

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String uploadPath ="C:/Users/acorn/workspace/thedeep/src/main/webapp/images";

		System.out.println("title : " + vo.getTitle());
		System.out.println("path : " + uploadPath);

		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists() || saveFolder.isFile()) {
			saveFolder.mkdirs();
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();

		String	filename = "";
		int		filesize = 0;
		String errCode = "";
		String exeName = "";

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {
				
				
				// jpg, jepg, gif, bmp
				// --> abdefjpg
				
				 *	1. 확장자 get
				 *	2. 확장자를 이용한 유효성 체크
				 *	3. size 체크 (5m) 
				 
				
				String realFile = file.getOriginalFilename();
				
				if(realFile.lastIndexOf(".")==-1) {
					errCode = "-1";
				} else {
					String[] array = realFile.split("\\.");
					exeName = array[array.length-1];
					exeName = exeName.toLowerCase();
					if(		!exeName.equals("jpg")
						&&	!exeName.equals("jepg")
						&&	!exeName.equals("png")) 
					{
						errCode = "0";
					} else {
						if(file.getSize() > 1024*1024*5) {
							errCode="1";
						}
					}
				}
				long unixTime = System.currentTimeMillis();
				
				if(errCode.equals("")) {
					filename = unixTime + "." + exeName;
					filePath = uploadPath + "\\" + filename;
					filesize = (int) file.getSize();
					try {
						file.transferTo(new File(filePath));
						
						imageResize(uploadPath,unixTime+"",exeName,100);
						imageResize(uploadPath,unixTime+"",exeName,80);
						
						cnt++;
					} catch(Exception e) {
						errCode="2";
					}
				}

				System.out.println(file.getName());
				System.out.println(file.getOriginalFilename());
				System.out.println(file.getSize());

			}
		}
		
		vo.setFilename(filename);
		vo.setFilesize(filesize);
		
		String result = boardService.insertUpload(vo);
		if(result == null) result = "ok";
		map.put("result", result);		// (json 인식이름, 데이터)
		map.put("cnt", Integer.toString(cnt));
		map.put("errCode", errCode);
		// json => result=ok&cnt=1
		
		return map;
	}*/
	
	@RequestMapping(value="/qnaDetail.do")
	public String selectQnaDetail() throws Exception{
		return "board/qnaDetail";
	}
	@RequestMapping(value="/qnaModify.do")
	public String updateQnaModify() throws Exception{
		return "board/qnaModify";
	}
	@RequestMapping(value="/noticeWrite.do")
	public String selectNoticeWrite() throws Exception{
		return "board/noticeWrite";
	}
	@RequestMapping(value="/noticeModify.do")
	public String selectNoticeModify() throws Exception{
		return "board/noticeModify";
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
					ReviewVO vo,
					ModelMap model) throws Exception {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\reviewImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		HashMap imap = (HashMap) multipartProcess(files,uploadPath);

		vo.setFilename((String) imap.get("fileName"));
		vo.setFilesize( Integer.parseInt((String) imap.get("fileSize")));
		
		String result = boardService.insertReview(vo);
		if(result == null) result = "ok";
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
					    && !exeName.equals("bmp") )
					{
						errCode = "0";
					} else {
						if(file.getSize() > 1024*1024*5) {
							errCode = "1";
						}
					}
				}
				long unixTime = System.currentTimeMillis();
				
				if(errCode.equals("")) {
					filename = unixTime+"."+exeName;
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
	public String selectReviewList() throws Exception{
		return "board/reviewList";
	}
	@RequestMapping(value="/reviewDetail.do")
	public String selectReviewDetail() throws Exception{
		return "board/reviewDetail";
	}
	@RequestMapping(value="/reviewModify.do")
	public String selectReviewModify() throws Exception{
		return "board/reviewModify";
	}
	
	
	
	
	
}
