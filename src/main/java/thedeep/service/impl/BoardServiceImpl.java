package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.ReviewVO;

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	
	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Override
	public List<?> selectQnaList(DefaultVO searchVO) throws Exception {
		return boardDAO.selectQnaList(searchVO);
	}

	@Override
	public int selectQnaListTotCnt(DefaultVO searchVO) throws Exception {
		return boardDAO.selectQnaListTotCnt(searchVO);
	}

	@Override
	public String insertUpload(BoardVO vo) throws Exception {
		return boardDAO.insertUpload(vo);
	}

	@Override
	public BoardVO selectQnaImage(int unq) throws Exception {
		return boardDAO.selectQnaImage(unq);
	}

	@Override
	public String insertReview(ReviewVO vo) throws Exception {
		return boardDAO.insertReview(vo);
	}

	@Override
	public List<?> selectReviewList(DefaultVO searchVO) throws Exception {
		return boardDAO.selectReviewList(searchVO);
	}

	@Override
	public int selectReviewListTotCnt(DefaultVO searchVO) throws Exception {
		return boardDAO.selectReviewListTotCnt(searchVO);
	}

	@Override
	public ReviewVO selectReviewDetail(int unq) throws Exception {
		return boardDAO.selectReviewDetail(unq);
	}

	@Override
	public int updateHit(int unq) throws Exception {
		return boardDAO.updateHit(unq);
	}

	@Override
	public int selectReviewPwd(ReviewVO vo) throws Exception {
		return boardDAO.selectReviewPwd(vo);
	}

	@Override
	public int deleteReview(ReviewVO vo) throws Exception {
		return boardDAO.deleteReview(vo);
	}

	@Override
	public int updateReviewFile(ReviewVO vo) throws Exception {
		return boardDAO.updateReviewFile(vo);
	}

	@Override
	public int updateReview(ReviewVO vo) throws Exception {
		return boardDAO.updateReview(vo);
	}

	@Override
	public String selectNowFilename(int unq) throws Exception {
		return boardDAO.selectNowFilename(unq);
	}

	
	
	
}
