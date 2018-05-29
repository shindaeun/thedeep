package thedeep.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import thedeep.service.ProductService;



@Controller
public class HomeController {
	
	@Resource(name="productService")
	ProductService productService;
	
	@RequestMapping(value="/home.do")
	public String Home(ModelMap model) throws Exception{
		List<?> nlist = productService.selectNew50Product();
		model.addAttribute("nlist",nlist);
		return "home/home";
	}

}


