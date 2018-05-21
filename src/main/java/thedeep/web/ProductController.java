package thedeep.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import thedeep.service.DefaultVO;
import thedeep.service.GroupVO;
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
		gcode="g002";
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
	public String selectProductAdd() throws Exception{
		return "product/productAdd";
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
