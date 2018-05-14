package thedeep.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import thedeep.service.GroupVO;
import thedeep.service.ProductService;
@Controller
public class ProductController {
	@Resource(name="productService")
	ProductService productService;
	
	@RequestMapping(value="/outerDetail.do")
	public String selectEmpList2() throws Exception{
		
		return "product/outerDetail";
	}
	@RequestMapping(value="/productList.do")
	public String selectProductList() throws Exception{
	
		return "product/productList";
	}
	@RequestMapping(value="/productDetail.do")
	public String selectProductDetail() throws Exception{
	
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
