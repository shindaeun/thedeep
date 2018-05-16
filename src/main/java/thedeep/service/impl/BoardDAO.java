package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
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

	public int updateHit(int unq) {
		return (int) update("boardDAO.updateHit",unq);
	}

	public int selectReviewPwd(ReviewVO vo) {
		return (int) select("boardDAO.selectReviewPwd",vo);
	}

	

	
}
