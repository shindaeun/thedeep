package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.NoticeVO;
import thedeep.service.ReviewVO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	public List<?> selectQnaList(DefaultVO searchVO) {
		return list("boardDAO.selectQnaList", searchVO);
	}

	public int selectQnaListTotCnt(DefaultVO searchVO) {
		return (int) select("boardDAO.selectQnaListTotCnt", searchVO);
	}

	public String insertUpload(BoardVO vo) {
		return (String) insert("boardDAO.insertUpload",vo);
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

	

	

	
}
