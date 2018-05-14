package thedeep.web;

import org.springframework.web.bind.annotation.RequestMapping;

public class ProductController {
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
	public String selectgroup() throws Exception{
		return "product/group";
	}
	@RequestMapping(value="/test.do")
	public String test() throws Exception{
		return "product/test";
	}
}
