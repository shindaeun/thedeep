package thedeep.service;

import java.util.List;

public interface BoardService {

	List<?> selectQnaList(DefaultVO searchVO) throws Exception;

	int selectQnaListTotCnt(DefaultVO searchVO) throws Exception;

	BoardVO selectQnaImage(int unq) throws Exception;

	String insertReview(ReviewVO vo) throws Exception;

	List<?> selectReviewList(DefaultVO searchVO) throws Exception;

	int selectReviewListTotCnt(DefaultVO searchVO) throws Exception;

	ReviewVO selectReviewDetail(int unq) throws Exception;

	int updateReviewHit(int unq) throws Exception;

	int selectReviewPwd(ReviewVO vo) throws Exception;
	
	int deleteReview(ReviewVO vo) throws Exception;

	int updateReviewFile(ReviewVO vo) throws Exception;

	int updateReview(ReviewVO vo) throws Exception;

	String selectReviewNowFilename(int unq) throws Exception;

	String insertnotice(NoticeVO vo) throws Exception;

	List<?> selectNoticeList(DefaultVO searchVO) throws Exception;

	int selectNoticeListTotCnt(DefaultVO searchVO) throws Exception;

	NoticeVO selectNoticeDetail(int unq) throws Exception;

	int selectNoticePwd(NoticeVO vo) throws Exception;

	int updateNoticeHit(int unq) throws Exception;

	int updateNoticeFile(ReviewVO vo) throws Exception;

	String selectNoticeNowFilename(int unq) throws Exception;

	int updateNotice(NoticeVO vo) throws Exception;

	int deleteNotice(NoticeVO vo) throws Exception;

	String insertQnaWrite(BoardVO vo) throws Exception;


	



}
