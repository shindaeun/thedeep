package thedeep.service;

import java.util.List;

public interface BoardService {

	List<?> selectQnaList(DefaultVO searchVO) throws Exception;

	int selectQnaListTotCnt(DefaultVO searchVO) throws Exception;

	String insertUpload(BoardVO vo) throws Exception;

	BoardVO selectQnaImage(int unq) throws Exception;

	String insertReview(ReviewVO vo) throws Exception;

	List<?> selectReviewList(DefaultVO searchVO) throws Exception;

	int selectReviewListTotCnt(DefaultVO searchVO) throws Exception;

	ReviewVO selectReviewDetail(int unq) throws Exception;

	int updateHit(int unq) throws Exception;

	int selectReviewPwd(ReviewVO vo) throws Exception;

	int deleteReview(ReviewVO vo) throws Exception;

	int updateReviewFile(ReviewVO vo) throws Exception;

	int updateReview(ReviewVO vo) throws Exception;

	String selectNowFilename(int unq) throws Exception;



}
