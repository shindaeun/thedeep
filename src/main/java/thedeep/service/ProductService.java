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

	String insertProduct(ProductVO vo) throws Exception;

	int selectPcode() throws Exception;

	String insertProductStock(ProductVO vo) throws Exception;

	List<?> selectProductListView(DefaultVO searchVO) throws Exception;

	int selectProductListTotCnt(DefaultVO searchVO) throws Exception;

	int updateAmount(ProductVO vo) throws Exception;

	ProductVO selectProductDetail(String pcode) throws Exception;

	int updateProductFile(ProductVO vo) throws Exception;

	int deleteProduct(ProductVO vo) throws Exception;

	int deleteCsProduct(ProductVO vo) throws Exception;

	String insertProductModify(ProductVO vo) throws Exception;

	String insertProductStockModify(ProductVO vo) throws Exception;

	int updateSoldout(ProductVO vo) throws Exception;

	int updateProduct(ProductVO vo) throws Exception;

	int selectAmount(ProductVO vo) throws Exception;

	int updateNotSoldout(ProductVO vo) throws Exception;

	List<?> selectCsList(String pcode) throws Exception;

	List<?> selectBest50Product() throws Exception;

	List<?> selectNew50Product() throws Exception;

	int updateSmartEditor(ProductVO vo) throws Exception;

	String selectVisitor() throws Exception;

	String insertVisitor() throws Exception;

	int updateVisitor() throws Exception;

	List<?> selectVisitorList() throws Exception;

	int selectVisitorTotal() throws Exception;

	int selectVisitorToday() throws Exception;

	List<?> selectColorList(String pcode) throws Exception;







}
