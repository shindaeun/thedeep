package thedeep.web;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
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
	
	@RequestMapping(value="/outerDetail.do")
	public String selectEmpList2() throws Exception{
		
		return "product/outerDetail";
	}
	@RequestMapping(value="/productList.do")
	public String selectProductList(ModelMap model ,HttpServletRequest request,GroupVO gvo,@ModelAttribute("searchVO") DefaultVO searchVO) throws Exception{
		String gcode = request.getParameter("gcode");
		gcode="g003";
		gvo=productService.selectGroup(gcode);
		searchVO.setSearchCondition("gcode");
		searchVO.setSearchKeyword(gcode);
		List<?> blist = productService.selectBest3Product(gcode);
		
		searchVO.setPageUnit(15);// 한 화면에 출력 개수
		searchVO.setPageSize(15);// 페이지 개수
		
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
		
		String uploadPath = "C:\\eGovFrameDev-3.7.0-64bit\\workspace\\thedeep\\src\\main\\webapp\\productImages";
		
		//String uploadPath = "c:\\upload";
		File saveFolder = new File(uploadPath);
		if (!saveFolder.exists()) {
			saveFolder.mkdirs();
		}

		HashMap imap = (HashMap) multipartProcess(files,uploadPath);

		vo.setFilename((String) imap.get("fileName"));

		String result = productService.insertproduct(vo);
		if(result == null) result = "ok";
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
				Random rn = new Random();
				int num = rn.nextInt(90);

				if(errCode.equals("")) {
					System.out.println(errCode);
					filename = unixTime + num + "." + exeName;
					filePath = uploadPath + "\\" + filename;
					filesize = (int)file.getSize();
					String targetPath = uploadPath + "\\" + unixTime+"_1."+exeName;
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
	public String selectProductModify() throws Exception{
		return "product/productModify";
	}
	@RequestMapping(value="/productListView.do")
	public String selectProductListView() throws Exception{
		return "product/productListView";
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
	
	
 
}
