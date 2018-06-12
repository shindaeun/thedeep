package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.NoticeVO;
import thedeep.service.OrderListVO;
import thedeep.service.ReviewVO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	public List<?> selectQnaList(DefaultVO searchVO) {
		return list("boardDAO.selectQnaList", searchVO);
	}

	public int selectQnaListTotCnt(DefaultVO searchVO) {
		return (int) select("boardDAO.selectQnaListTotCnt", searchVO);
	}

	public BoardVO selectQnaImage(int unq) {
		return (BoardVO) select("boardDAO.selectQnaImage", unq);
	}

	public String insertReview(ReviewVO vo) {
		return (String) insert("boardDAO.insertReview",vo);
	}

	public List<?> selectReviewList(DefaultVO searchVO) {
		return list("boardDAO.selectReviewList",searchVO);
	}

	public int selectReviewListTotCnt(DefaultVO searchVO) {
		return (int) select("boardDAO.selectReviewListTotCnt",searchVO);
	}

	public ReviewVO selectReviewDetail(int unq) {
		return (ReviewVO) select("boardDAO.selectReviewDetail",unq);
	}

	public int updateReviewHit(int unq) {
		return (int) update("boardDAO.updateReviewHit",unq);
	}

	public int selectReviewPwd(ReviewVO vo) {
		return (int) select("boardDAO.selectReviewPwd",vo);
	}

	public int deleteReview(ReviewVO vo) {
		return (int) delete("boardDAO.deleteReview",vo);
	}

	public int updateReviewFile(ReviewVO vo) {
		return (int) update("boardDAO.updateReviewFile",vo);
	}
	
	public String selectReviewNowFilename(int unq) {
		return (String) select("boardDAO.selectReviewNowFilename",unq);
	}
	
	public int updateReview(ReviewVO vo) {
		return (int) update("boardDAO.updateReview",vo);
	}

	public String insertnotice(NoticeVO vo) {
		return (String) insert("boardDAO.insertnotice",vo);
	}

	public List<?> selectNoticeList(DefaultVO searchVO) {
		return list("boardDAO.selectNoticeList",searchVO);
	}

	public int selectNoticeListTotCnt(DefaultVO searchVO) {
		return (int) select("boardDAO.selectNoticeListTotCnt",searchVO);
	}

	public NoticeVO selectNoticeDetail(int unq) {
		return (NoticeVO) select("boardDAO.selectNoticeDetail",unq);
	}

	public int selectNoticePwd(NoticeVO vo) {
		return (int) select("boardDAO.selectNoticePwd",vo);
	}

	public int updateNoticeHit(int unq) {
		return (int) update("boardDAO.updateNoticeHit",unq);
	}

	public int updateNoticeFile(ReviewVO vo) {
		return (int) update("boardDAO.updateNoticeFile",vo);
	}

	public String selectNoticeNowFilename(int unq) {
		return (String) select("boardDAO.selectNoticeNowFilename",unq);
	}

	public int updateNotice(NoticeVO vo) {
		return (int) update("boardDAO.updateNotice",vo);
	}

	public int deleteNotice(NoticeVO vo) {
		return (int) delete("boardDAO.deleteNotice",vo);
	}

	public String insertQnaWrite(BoardVO vo) {
		return (String) insert("boardDAO.insertQnaWrite",vo);
	}

	public int updateQnaHit(int unq) {
		return update("boardDAO.updateQnaHit", unq);
	}

	public BoardVO selectQnaDetail(int unq) {
		return (BoardVO) select("boardDAO.selectQnaDetail", unq);
	}

	public int selectQnaPwdChk(BoardVO vo) {
		return (int) select("boardDAO.selectQnaPwdChk", vo);
	}

	public int updateQnaFile(BoardVO vo) {
		return update("boardDAO.updateQnaFile", vo);
	}

	public int updateQna(BoardVO vo) {
		return update("boardDAO.updateQna",vo);
	}

	public int deleteQna(BoardVO vo) {
		return delete("boardDAO.deleteQna", vo);
	}

	public String selectQnaNowFilename(int unq) {
		return (String) select("boardDAO.selectQnaNowFilename", unq);
	}

	public String selectUserName(String userid) {
		return (String) select("boardDAO.selectUserName", userid);
	}

	public String selectQnaTitle(int unq) {
		return (String) select("boardDAO.selectQnaTitle", unq);
	}

	public List<?> selectReviewReplyList(int unq) {
		return list("boardDAO.selectReviewReplyList",unq);
	}

	public int updateOrderList(OrderListVO ovo) {
		return update("boardDAO.updateOrderList",ovo);
	}

	public String selectPsize(OrderListVO ovo) {
		return (String) select("boardDAO.selectPsize", ovo);
	}


	

	

	
}
