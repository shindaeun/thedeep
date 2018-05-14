package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("memberDAO")
public class MemberDAO extends EgovAbstractDAO{

	public List<?> selectCartList(String userid) {
		return list("memberDAO.selectCartList",userid);
	}

	
}
