package thedeep.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class BoardController {
	@RequestMapping(value="/noticeList.do")
	public String selectNoticeList() throws Exception{
		return "board/noticeList";
	}
	@RequestMapping(value="/noticeDetail.do")
	public String noticeDetail() throws Exception{
		return "board/noticeDetail";
	}
	
	@RequestMapping(value="/qnaList.do")
	public String selectQnaListe() throws Exception{
		return "board/qnaList";
	}
	@RequestMapping(value="/qnaWrite.do")
	public String insertQnaWrite() throws Exception{
		return "board/qnaWrite";
	}
	@RequestMapping(value="/qnaDetail.do")
	public String selectQnaDetail() throws Exception{
		return "board/qnaDetail";
	}
	@RequestMapping(value="/qnaModify.do")
	public String updateQnaModify() throws Exception{
		return "board/qnaModify";
	}
	@RequestMapping(value="/noticeWrite.do")
	public String selectNoticeWrite() throws Exception{
		return "board/noticeWrite";
	}
	@RequestMapping(value="/noticeModify.do")
	public String selectNoticeModify() throws Exception{
		return "board/noticeModify";
	}
	
	
	
	@RequestMapping(value="/reviewWrite.do")
	public String selectReviewWrite() throws Exception{
		return "board/reviewWrite";
	}
	@RequestMapping(value="/reviewList.do")
	public String selectReviewList() throws Exception{
		return "board/reviewList";
	}
	@RequestMapping(value="/reviewDetail.do")
	public String selectReviewDetail() throws Exception{
		return "board/reviewDetail";
	}
	@RequestMapping(value="/reviewModify.do")
	public String selectReviewModify() throws Exception{
		return "board/reviewModify";
	}
}
