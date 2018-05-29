package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.DefaultVO;
import thedeep.service.GroupVO;
import thedeep.service.ProductVO;
import thedeep.service.ReviewVO;

@Repository("productDAO")
public class ProductDAO extends EgovAbstractDAO {

	public GroupVO selectGroup(String gcode) {
		return (GroupVO) select("productDAO.selectGroup",gcode);
	}

	public List<?> selectGroupList() {
		return list("productDAO.selectGroupList");
	}

	public String insertgroup(GroupVO vo) {
		return (String) insert("productDAO.insertgroup",vo);
	}

	public int updateGroup(GroupVO vo) {
		return update("productDAO.updateGroup",vo);
	}

	public int deleteGroup(String gcode) {
		return delete("productDAO.deleteGroup",gcode);
	}

	public List<?> selectProductList(DefaultVO searchVO) {
		return list("productDAO.selectProductList",searchVO);
	}

	public int selectProductTotCnt(String gcode) {
		return (int) select("productDAO.selectProductTotCnt",gcode);
	}

	public List<?> selectBest3Product(String gcode) {
		return list("productDAO.selectBest3Product",gcode);
	}

	public ProductVO selectProductInfo(String pcode) {
		return (ProductVO) select("productDAO.selectProductInfo",pcode);
	}

	public List<?> selectSelOptions(String pcode) {
		return list("productDAO.selectSelOptions",pcode);
	}

	public List<?> selectQna(DefaultVO searchVO) {
		return list("productDAO.selectQna",searchVO);
	}

	public int selectQnaTotCnt(DefaultVO searchVO) {
		return (int) select("productDAO.selectQnaTotCnt",searchVO);
	}

	public List<?> selectReview(DefaultVO searchVO) {
		return list("productDAO.selectReview",searchVO);
	}

	public int selectReviewTotCnt(DefaultVO searchVO) {
		return (int) select("productDAO.selectReviewTotCnt",searchVO);
	}

	public List<?> selectReviewResult(ReviewVO rvo) {
		return list("productDAO.selectReviewResult",rvo);
	}

	public List<?> selectGname() {
		return list("productDAO.selectGname");
	}

	public String insertProduct(ProductVO vo) {
		return (String) insert("productDAO.insertProduct",vo);
	}

	public int selectPcode() {
		return (int) select("productDAO.selectPcode");
	}

	public String insertProductStock(ProductVO vo) {
		return (String) insert("productDAO.insertProductStock",vo);
	}

	public List<?> selectProductListView(DefaultVO searchVO) {
		return list("productDAO.selectProductListView",searchVO);
	}

	public int selectProductListTotCnt(DefaultVO searchVO) {
		return (int) select("productDAO.selectProductListTotCnt",searchVO);
	}

	public int updateAmount(ProductVO vo) {
		return update("productDAO.updateAmount",vo);
	}

	public ProductVO selectProductDetail(String pcode) {
		return (ProductVO) select("productDAO.selectProductDetail",pcode);
	}

	public int updateProductFile(ProductVO vo) {
		return update("productDAO.updateProductFile",vo);
	}

	public int deleteProduct(ProductVO vo) {
		return delete("productDAO.deleteProduct",vo);
	}

	public int deleteCsProduct(ProductVO vo) {
		return delete("productDAO.deleteCsProduct",vo);
	}

	public String insertProductModify(ProductVO vo) {
		return (String) insert("productDAO.insertProductModify",vo);
	}

	public String insertProductStockModify(ProductVO vo) {
		return (String) insert("productDAO.insertProductStockModify",vo);
	}

	public int updateSoldout(ProductVO vo) {
		return update("productDAO.updateSoldout",vo);
	}

	public int updateProduct(ProductVO vo) {
		return update("productDAO.updateProduct",vo);
	}

	public int selectAmount(ProductVO vo) {
		return (int) select("productDAO.selectAmount",vo);
	}

	public int updateNotSoldout(ProductVO vo) {
		return update("productDAO.updateNotSoldout",vo);
	}

	public List<?> selectCsList(String pcode) {
		return list("productDAO.selectCsList",pcode);
	}

	public int updateSmartEditor(ProductVO vo) {
		return update("productDAO.updateSmartEditor",vo);
	}




}
