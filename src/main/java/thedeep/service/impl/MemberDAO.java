package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.CartVO;
import thedeep.service.DefaultVO;

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

	public String selectAllPoint(String userid) {
		return (String) select("memberDAO.selectAllPoint",userid);
	}

	public String selectAblePoint(String userid) {
		return (String) select("memberDAO.selectAblePoint",userid);
	}

	public List<?> selectUserReview(DefaultVO searchVO) {
		return list("memberDAO.selectUserReview",searchVO);
	}

	public int selectUserReviewTotCnt(DefaultVO searchVO) {
		return (int) select("memberDAO.selectUserReviewTotCnt",searchVO);
	}

	public List<?> selectUserQna(DefaultVO searchVO) {
		return list("memberDAO.selectUserQna",searchVO);
	}

	public int selectUserQnaTotCnt(DefaultVO searchVO) {
		return (int) select("memberDAO.selectUserQnaTotCnt",searchVO);
	}

	public String insertCartList(CartVO vo) {
		return (String) insert("memberDAO.insertCartList",vo);
	}

	public int selectCartCscodeCount(CartVO vo) {
		return (int) select("memberDAO.selectCartCscodeCount",vo);
	}

	
}
