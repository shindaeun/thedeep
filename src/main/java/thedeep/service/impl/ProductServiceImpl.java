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

	

}
