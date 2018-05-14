package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	
	@RequestMapping(value="/home.do")
	public String selectEmpList1() throws Exception{
		return "home/home";
	}

}


