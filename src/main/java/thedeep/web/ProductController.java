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
	public String selectProductDetail(ModelMap model ,HttpServletRequest request) throws Exception{
		String pcode = request.getParameter("pcode");
		//pcode="P00008";
		ProductVO pvo = productService.selectProductInfo(pcode);
		List<?> oplist = productService.selectSelOptions(pcode);
		model.addAttribute("pvo",pvo);
		System.out.println(pvo);
		System.out.println(oplist);
		model.addAttribute("oplist",oplist);
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
