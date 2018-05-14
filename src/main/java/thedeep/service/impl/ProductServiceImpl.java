package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.GroupVO;
import thedeep.service.ProductService;

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

	

}
