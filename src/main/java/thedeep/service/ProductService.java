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



}
