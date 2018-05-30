package thedeep.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestHttpClientJava.IamportClient;
import com.siot.IamportRestHttpClientJava.request.CancelData;
import com.siot.IamportRestHttpClientJava.response.IamportResponse;
import com.siot.IamportRestHttpClientJava.response.Payment;
import com.siot.IamportRestHttpClientJava.response.Payments;

import thedeep.service.PaymentVO;
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


