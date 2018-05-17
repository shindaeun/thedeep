package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.DefaultVO;
import thedeep.service.GroupVO;
import thedeep.service.ProductVO;

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

	

}
