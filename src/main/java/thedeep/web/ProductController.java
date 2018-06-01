package thedeep.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.Map.Entry;

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

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.DefaultVO;
import thedeep.service.GroupVO;
import thedeep.service.NoticeVO;
import thedeep.service.ProductService;
import thedeep.service.ProductVO;
import thedeep.service.ReviewVO;
@Controller
public class ProductController {
	@Resource(name="productService")
	ProductService productService;
	
	@RequestMapping(value="/productList.do")
	public String selectProductList(ModelMap model ,HttpServletRequest request,GroupVO gvo,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		String gcode = request.getParameter("gcode");
		gvo=productService.selectGroup(gcode);
		searchVO.setSearchCondition("gcode");
		searchVO.setSearchKeyword(gcode);
		List<?> blist = productService.selectBest3Product(gcode);
		System.out.println("best "+blist);
		searchVO.setPageUnit(14);// 한 화면에 출력 개수
		searchVO.setPageSize(14);// 페이지 개수
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		List<?> plist = productService.selectProductList(searchVO);
		model.addAttribute("plist", plist);
		int totCnt = productService.selectProductTotCnt(gcode);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("gvo",gvo);
		model.addAttribute("blist",blist);
		model.addAttribute("plist",plist);

		return "product/productList";
	}
	@RequestMapping(value="/best50List.do")
	public String best50List(ModelMap model ,HttpServletRequest request) throws Exception{
		
		List<?> blist = productService.selectBest50Product();
		
		model.addAttribute("blist",blist);
		System.out.println(blist);
		return "product/best50List";
	}
	@RequestMapping(value="/productDetail.do")
	public String selectProductDetail(ReviewVO rvo,ModelMap model ,HttpServletRequest request,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		String pcode = searchVO.getPcode();
		System.out.println(pcode);
		if(request.getParameter("pcode")!=null){
			pcode = request.getParameter("pcode");
		}
		//상품 디테일 and 품목 옵션
		ProductVO pvo = productService.selectProductInfo(pcode);
		List<?> oplist = productService.selectSelOptions(pcode);
		
		
		String test =stringReplace(pvo.getEditor());
		pvo.setEditor(test);
		
		model.addAttribute("pvo",pvo);
		System.out.println(pvo+"pvo");
		System.out.println(oplist+"oplist");
		model.addAttribute("oplist",oplist);
		
		//설문조사 결과
		rvo.setPcode(pcode);
		/*rvo.setHeight("140-145");
		rvo.setWeight("40-45");
		rvo.setPsize("S");*/
		if(rvo.getWeight()==null){
			rvo.setHeight("140-145");
			rvo.setWeight("40-45");
			rvo.setPsize("S");
		}
		System.out.println("h"+rvo.getHeight()+"w"+rvo.getWeight()+rvo.getPsize());
		
		List<?> surveylist = productService.selectReviewResult(rvo);
		System.out.println(surveylist);
		model.addAttribute("rvo",rvo);
		System.out.println("h"+rvo.getHeight()+"w"+rvo.getWeight()+rvo.getPsize());
		model.addAttribute("surveylist",surveylist);
		//리뷰 and qna 리스트
		searchVO.setSearchCondition("pcode");
		searchVO.setSearchKeyword(pcode);
		
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

		List<?> qlist = productService.selectQna(searchVO);
		model.addAttribute("qlist", qlist);
		System.out.println(qlist);
		int totCnt = productService.selectQnaTotCnt(searchVO);
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
		List<?> rlist = productService.selectReview(searchVO);
		model.addAttribute("rlist", rlist);
		System.out.println(rlist);
		int totCnt2 = productService.selectReviewTotCnt(searchVO);
		paginationInfo2.setTotalRecordCount(totCnt2);
		model.addAttribute("paginationInfo2", paginationInfo2);
		return "product/productDetail";
	}
	@RequestMapping(value="/productAdd.do")
	public String selectProductAdd(ModelMap model) throws Exception{
		List<?> groupName = productService.selectGname();
		model.addAttribute("group", groupName);
		
		return "product/productAdd";
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
		
		return "product/productModify";
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
		String result="",result1="",result2="";
		int pcode,cnt;

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
			String psize = vo.getPsize();
			String color = vo.getColor();
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

		return "product/productListView";
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
		return "product/group";
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
	
	@RequestMapping(value="/test.do")
	public String test() throws Exception{
		return "product/test";
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

	
	public static String stringReplace(String str) {
		
		 str = str.replaceAll("&lt;", "<");
		 str = str.replaceAll("&gt;", ">");
		 str = str.replaceAll("&quot;","\"");
		 str = str.replaceAll("&amp;","&");
		 str = str.replaceAll("&#39;","\'");

		return str;
	}
 
}
