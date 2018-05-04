package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class TestController {
	
	
	@RequestMapping(value="/test.do")
	public String selectEmpList() throws Exception{
		
		return "test/test";
	}
	

}
