package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.DefaultVO;
import thedeep.service.GroupVO;
import thedeep.service.ProductService;
import thedeep.service.ProductVO;
import thedeep.service.ReviewVO;

@Service("productService")
public class ProductServiceImpl extends EgovAbstractServiceImpl implements ProductService {

	@Resource(name="productDAO")
	private ProductDAO productDAO;
	
	@Override
	public GroupVO selectGroup(String gcode) {
		return productDAO.selectGroup(gcode);
	}

	@Override
	public List<?> selectGroupList() {
		return productDAO.selectGroupList();
	}

	@Override
	public String insertgroup(GroupVO vo) throws Exception {
		return productDAO.insertgroup(vo);
	}

	@Override
	public int updateGroup(GroupVO vo) throws Exception {
		return productDAO.updateGroup(vo);
	}

	@Override
	public int deleteGroup(String gcode) throws Exception {
		return productDAO.deleteGroup(gcode);
	}

	@Override
	public List<?> selectProductList(DefaultVO searchVO) throws Exception {
		return productDAO.selectProductList(searchVO);
	}

	@Override
	public int selectProductTotCnt(String gcode) throws Exception {
		return productDAO.selectProductTotCnt(gcode);
	}

	@Override
	public List<?> selectBest3Product(String gcode) throws Exception {
		return productDAO.selectBest3Product(gcode);
	}

	@Override
	public ProductVO selectProductInfo(String pcode) throws Exception {
		return productDAO.selectProductInfo(pcode);
	}

	@Override
	public List<?> selectSelOptions(String pcode) throws Exception {
		return productDAO.selectSelOptions(pcode);
	}

	@Override
	public List<?> selectQna(DefaultVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.selectQna(searchVO);
	}

	@Override
	public int selectQnaTotCnt(DefaultVO searchVO) throws Exception {
		return productDAO.selectQnaTotCnt(searchVO);
	}

	@Override
	public List<?> selectReview(DefaultVO searchVO) throws Exception {
		return productDAO.selectReview(searchVO);
	}

	@Override
	public int selectReviewTotCnt(DefaultVO searchVO) throws Exception {
		return productDAO.selectReviewTotCnt(searchVO);
	}

	@Override
	public List<?> selectReviewResult(ReviewVO rvo) throws Exception {
		return productDAO.selectReviewResult(rvo);
	}
	
	@Override
	public List<?> selectGname() throws Exception {
		return productDAO.selectGname();
	}

	@Override
	public String insertProduct(ProductVO vo) throws Exception {
		return productDAO.insertProduct(vo);
	}

	@Override
	public int selectPcode() throws Exception {
		return productDAO.selectPcode();
	}

	@Override
	public String insertProductStock(ProductVO vo) throws Exception {
		return productDAO.insertProductStock(vo);
	}

	@Override
	public List<?> selectProductListView(DefaultVO searchVO) throws Exception {
		return productDAO.selectProductListView(searchVO);
	}

	@Override
	public int selectProductListTotCnt(DefaultVO searchVO) throws Exception {
		return productDAO.selectProductListTotCnt(searchVO);
	}

	@Override
	public int updateAmount(ProductVO vo) throws Exception {
		return productDAO.updateAmount(vo);
	}

	@Override
	public ProductVO selectProductDetail(String pcode) throws Exception {
		return productDAO.selectProductDetail(pcode);
	}

	@Override
	public int updateProductFile(ProductVO vo) throws Exception {
		return productDAO.updateProductFile(vo);
	}

	@Override
	public int deleteProduct(ProductVO vo) throws Exception {
		return productDAO.deleteProduct(vo);
	}

	@Override
	public int deleteCsProduct(ProductVO vo) throws Exception {
		return productDAO.deleteCsProduct(vo);
	}

	@Override
	public String insertProductModify(ProductVO vo) throws Exception {
		return productDAO.insertProductModify(vo);
	}

	@Override
	public String insertProductStockModify(ProductVO vo) throws Exception {
		return productDAO.insertProductStockModify(vo);
	}

	@Override
	public int updateSoldout(ProductVO vo) throws Exception {
		return productDAO.updateSoldout(vo);
	}

	@Override
	public int updateProduct(ProductVO vo) throws Exception {
		return productDAO.updateProduct(vo);
	}

	@Override
	public int selectAmount(ProductVO vo) throws Exception {
		return productDAO.selectAmount(vo);
	}

	@Override
	public int updateNotSoldout(ProductVO vo) throws Exception {
		return productDAO.updateNotSoldout(vo);
	}

	@Override
	public List<?> selectCsList(String pcode) throws Exception {
		return productDAO.selectCsList(pcode);
	}

	@Override

	public List<?> selectBest50Product() throws Exception {
		return productDAO.selectBest50Product();
	}

	@Override
	public List<?> selectNew50Product() throws Exception {
		return productDAO.selectNew50Product();
	}
	
	public int updateSmartEditor(ProductVO vo) throws Exception {
		return productDAO.updateSmartEditor(vo);

	}

	@Override
	public String selectVisitor() throws Exception {
		return productDAO.selectVisitor();
	}

	@Override
	public String insertVisitor() throws Exception {
		return productDAO.insertVisitor();
	}

	@Override
	public int updateVisitor() throws Exception {
		return productDAO.updateVisitor();
	}

	@Override
	public List<?> selectVisitorList() throws Exception {
		return productDAO.selectVisitorList();
	}

	@Override
	public int selectVisitorTotal() throws Exception {
		return productDAO.selectVisitorTotal();
	}

	@Override
	public int selectVisitorToday() throws Exception {
		return productDAO.selectVisitorToday();
	}

	@Override
	public List<?> selectColorList(String pcode) throws Exception {
		return productDAO.selectColorList(pcode);
	}

	@Override
	public int selectProduct(String gcode) throws Exception {
		return productDAO.selectProduct(gcode);
	}


	

}
