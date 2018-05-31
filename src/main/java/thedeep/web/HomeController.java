package thedeep.web;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import thedeep.service.CouponVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.ProductService;




@Controller
public class HomeController {
	
	@Resource(name="productService")
	ProductService productService;

	@Resource(name="memberService")
	MemberService memberService;
	
	@RequestMapping(value="/theDeep.do")
	public String selectEmpList1(MemberVO vo, CouponVO cvo, HttpServletRequest request, ModelMap model) throws Exception{
		
		List<?> nlist = productService.selectNew50Product();
		model.addAttribute("nlist",nlist);
		
		String result= productService.selectVisitor();
		if(result==null || result.equals("")){
			String result2= productService.insertVisitor();
		} else {
			int cnt = productService.updateVisitor();
		}
		List<?> visitorlist = productService.selectVisitorList();
		model.addAttribute("visitorlist",visitorlist);
		
		int total = productService.selectVisitorTotal();
		model.addAttribute("total",total);
		
		int today2 = productService.selectVisitorToday();
		model.addAttribute("today",today2);
		
		Calendar cal = Calendar.getInstance();
		
		int tmonth = cal.get(Calendar.MONTH)+1;
		int tday = cal.get(Calendar.DATE);
		String today = "";
		if(tmonth<10) today += "0" + tmonth;
		else today += tmonth + "";
		today += tday + "";
		
		String userid = null;
		String happyBTD = "0";

		try {
			HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
			userid = (String) a.get("ThedeepUserId");
		} catch(Exception e) { }
		
		if(userid!=null) {
			int coupon = memberService.selectBTDCoupon(userid);
			if(coupon==1) {
				String birthday = memberService.selectBtdCheck(userid);
				if(birthday.equals(today)) {
					happyBTD = userid;
				}
			}
		}
		
		model.addAttribute("happyBTD", happyBTD);
		
		return "home/theDeep";
	}
	
}


