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
	
	@RequestMapping(value="/theDeep.do")
	public String Home(ModelMap model) throws Exception{
		//List<?> groupName = productService.selectGname();
		//model.addAttribute("group", groupName);
		List<?> nlist = productService.selectNew50Product();
		//visitor--S
		String result = productService.selectVisitor();
		if(result==null) {
			String result2 = productService.insertVisitor();
		} else {
			int cnt3 = productService.updateVisitor();
		}
		List<?> visitorlist = productService.selectVisitorList();
		model.addAttribute("visitorlist",visitorlist);
		
		int total = productService.selectVisitorTotal();
		model.addAttribute("total",total);
		
		int today = productService.selectVisitorToday();
		model.addAttribute("today",today);
		//visitor--E
		model.addAttribute("nlist",nlist);
		
		return "home/theDeep";
	}
	
	

}


