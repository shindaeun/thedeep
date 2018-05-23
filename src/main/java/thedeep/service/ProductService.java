package thedeep.service;

import java.util.List;

public interface ProductService {

	GroupVO selectGroup(String gcode) throws Exception;

	List<?> selectGroupList() throws Exception;

	String insertgroup(GroupVO vo) throws Exception;

	int updateGroup(GroupVO vo) throws Exception;

	int deleteGroup(String gcode) throws Exception;

	List<?> selectProductList(DefaultVO searchVO) throws Exception;

	int selectProductTotCnt(String gcode) throws Exception;

	List<?> selectBest3Product(String gcode) throws Exception;

	ProductVO selectProductInfo(String pcode) throws Exception;

	List<?> selectSelOptions(String pcode) throws Exception;

	List<?> selectQna(DefaultVO searchVO) throws Exception;

	int selectQnaTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectReview(DefaultVO searchVO) throws Exception;

	int selectReviewTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectReviewResult(ReviewVO rvo) throws Exception;

	List<?> selectGname() throws Exception;



}
