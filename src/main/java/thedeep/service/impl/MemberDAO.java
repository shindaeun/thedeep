package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.CartVO;

@Repository("memberDAO")
public class MemberDAO extends EgovAbstractDAO{

	public List<?> selectCartList(String userid) {
		return list("memberDAO.selectCartList",userid);
	}

	public int updateCart(CartVO vo) {
		return update("memberDAO.updateCart",vo);
	}

	public int cartDelete(CartVO vo) {
		return delete("memberDAO.cartDelete",vo);
	}

	public List<?> selectCouponList(String userid) {
		return list("memberDAO.selectCouponList",userid);
	}

	public List<?> selectPointList(String userid) {
		return list("memberDAO.selectPointList",userid);
	}

	
}
