package thedeep.web;

import java.io.PrintWriter;
import java.util.Calendar;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import thedeep.service.CouponVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;



@Controller
public class HomeController {
	
	@Resource(name="memberService")
	MemberService memberService;
	
	@RequestMapping(value="/home.do")
	public String selectEmpList1(MemberVO vo, CouponVO cvo, HttpServletRequest request, ModelMap model) throws Exception{
		
		Calendar cal = Calendar.getInstance();
		
		int tmonth = cal.get(Calendar.MONTH)+1;
		int tday = cal.get(Calendar.DATE);
		String today = "";
		if(tmonth<10) today += "0" + tmonth;
		else today += tmonth + "";
		today += tday + "";
		
		String userid = null;
		String edate = "";
		int year = 0;
		int month = 0;
		int day = 0;
		String result = "";
		String happyBTD = "0";

		try {
			HashMap a = (HashMap) request.getSession().getAttribute("ThedeepLoginCert");
			userid = (String) a.get("ThedeepUserId");
		} catch(Exception e) { }
		
		if(userid!=null) {
			int coupon = memberService.selectBTDCoupon(userid);
			if(coupon==0) {
				String birthday = memberService.selectMemberBTD(userid);
				if(birthday.equals(today)) {
					cal.add(Calendar.MONTH, 1);
					year = cal.get(Calendar.YEAR);
					month = cal.get(Calendar.MONTH)+1;
					day = cal.get(Calendar.DATE);
					edate = year + "-";
					if(month<10) edate += "0" + month + "-";
					else edate += month + "-";
					edate += day + "";
					
					cvo.setUserid(userid);
					cvo.setEdate(edate);
					
					result = memberService.insertBTDCoupon(cvo);
					if(result==null) {
						happyBTD = userid;
					} else happyBTD = "0";
				}
			}
		}
		
		model.addAttribute("happyBTD", happyBTD);
		
		return "home/home";
	}

}


