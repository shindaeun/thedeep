package thedeep.service;

import java.util.List;

public interface ProductService {

	GroupVO selectGroup(String gcode) throws Exception;

	List<?> selectGroupList() throws Exception;

	String insertgroup(GroupVO vo) throws Exception;

	int updateGroup(GroupVO vo) throws Exception;

	int deleteGroup(String gcode) throws Exception;



}
