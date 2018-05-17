package thedeep.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import thedeep.service.BoardService;
import thedeep.service.ReviewVO;

@Controller
public class PopupController {
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@RequestMapping(value="/post1.do")
	public String selectPost1() throws Exception{
		return "popup/post1";
	}
	
	@RequestMapping(value="/pwdChk.do")
	public String selectPwdChk() throws Exception{
		return "popup/pwdChk";
	}
	
	
	
	
	
	
	
	@RequestMapping(value="/pwdCheck.do")
	public String selectPwdCheck() throws Exception{
		return "popup/pwdCheck";
	}

	@RequestMapping(value="/pwdCheck2.do")
	@ResponseBody 
	public Map<String,Object> selectReviewPwd(ReviewVO vo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String result = "";
		int number = boardService.selectReviewPwd(vo);
		if(number == 0) {
			result = "0";
		} else {
			result = "1";
		}
		map.put("result", result);
		return map;
	}
	

	
	@RequestMapping(value="/couponPopup.do")
	public String couponPopup() throws Exception{
		return "popup/couponPopup";
	}

}
