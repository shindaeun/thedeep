package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.NoticeVO;
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
	public int updateReviewHit(int unq) throws Exception {
		return boardDAO.updateReviewHit(unq);
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
	public String selectReviewNowFilename(int unq) throws Exception {
		return boardDAO.selectReviewNowFilename(unq);
	}

	@Override
	public String insertnotice(NoticeVO vo) throws Exception {
		return boardDAO.insertnotice(vo);
	}

	@Override
	public List<?> selectNoticeList(DefaultVO searchVO) throws Exception {
		return boardDAO.selectNoticeList(searchVO);
	}

	@Override
	public int selectNoticeListTotCnt(DefaultVO searchVO) throws Exception {
		return boardDAO.selectNoticeListTotCnt(searchVO);
	}

	@Override
	public NoticeVO selectNoticeDetail(int unq) throws Exception {
		return boardDAO.selectNoticeDetail(unq);
	}

	@Override
	public int selectNoticePwd(NoticeVO vo) throws Exception {
		return boardDAO.selectNoticePwd(vo);
	}

	@Override
	public int updateNoticeHit(int unq) throws Exception {
		return boardDAO.updateNoticeHit(unq);
	}

	@Override
	public int updateNoticeFile(ReviewVO vo) throws Exception {
		return boardDAO.updateNoticeFile(vo);
	}

	@Override
	public String selectNoticeNowFilename(int unq) throws Exception {
		return boardDAO.selectNoticeNowFilename(unq);
	}

	@Override
	public int updateNotice(NoticeVO vo) throws Exception {
		return boardDAO.updateNotice(vo);
	}

	@Override
	public int deleteNotice(NoticeVO vo) throws Exception {
		return boardDAO.deleteNotice(vo);
	}

	@Override
	public String insertQnaWrite(BoardVO vo) throws Exception {
		return boardDAO.insertQnaWrite(vo);
	}

	@Override
	public int updateQnaHit(int unq) throws Exception {
		return boardDAO.updateQnaHit(unq);
	}

	@Override
	public BoardVO selectQnaDetail(int unq) throws Exception {
		return boardDAO.selectQnaDetail(unq);
	}

	@Override
	public int selectQnaPwdChk(BoardVO vo) throws Exception {
		return boardDAO.selectQnaPwdChk(vo);
	}

	@Override
	public int updateQnaFile(BoardVO vo) throws Exception {
		return boardDAO.updateQnaFile(vo);
	}

	@Override
	public int updateQna(BoardVO vo) throws Exception {
		return boardDAO.updateQna(vo);
	}

	@Override
	public int deleteQna(BoardVO vo) throws Exception {
		return boardDAO.deleteQna(vo);
	}

	@Override
	public String selectQnaNowFilename(int unq) throws Exception {
		return boardDAO.selectQnaNowFilename(unq);
	}

	@Override
	public String selectUserName(String userid) throws Exception {
		return boardDAO.selectUserName(userid);
	}

	@Override
	public String selectQnaTitle(int unq) throws Exception {
		return boardDAO.selectQnaTitle(unq);
	}

	@Override
	public List<?> selectReviewReplyList(int unq) throws Exception {
		return boardDAO.selectReviewReplyList(unq);
	}

	
	
	
}
