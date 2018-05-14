package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.GroupVO;

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

	

}
