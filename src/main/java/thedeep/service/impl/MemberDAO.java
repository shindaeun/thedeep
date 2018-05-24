package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.CartVO;
import thedeep.service.DefaultVO;
import thedeep.service.FindVO;
import thedeep.service.MemberVO;
import thedeep.service.PwdCkVO;

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
	
	public int selectIdChk(String userid) {
		return (int) select("memberDAO.selectIdChk",userid);
	}

	public String insertMember(MemberVO vo) {
		return (String) insert("memberDAO.insertMember", vo);
	}

	public int selectMemberCertCnt(MemberVO vo) {
		return (int) select("memberDAO.selectMemberCertCnt", vo);
	}

	public MemberVO selectMemeberDetail(String userid) {
		return (MemberVO) select("memberDAO.selectMemeberDetail", userid);
	}

	public int updateMember(MemberVO vo) {
		return (int) update("memberDAO.updateMember",vo);
	}

	public int selectMemberCoupon(String userid) {
		return (int) select("memberDAO.selectMemberCoupon", userid);
	}

	public int selectMemberMoney(String userid) {
		return (int) select("memberDAO.selectMemberMoney", userid);
	}

	public List<?> selectUserOrderList(String userid) {
		return list("memberDAO.selectUserOrderList", userid);
	}

	public int selectFindid(FindVO vo) {
		return (int) select("memberDAO.selectFindid",vo);
	}

	public List<?> selectFindIdList(FindVO fvo) {
		return list("memberDAO.selectFindIdList", fvo);
	}

	public int selectFindidCnt(FindVO fvo) {
		return (int) select("memberDAO.selectFindidCnt", fvo);
	}
	
	public int selectPwdChk(PwdCkVO vo) {
		return (int) select("memberDAO.selectPwdChk", vo);
	}
	

	public CartVO selectCartProductInfo(CartVO vo) {
		return (CartVO) select("memberDAO.selectCartProductInfo",vo);
	}

	public int selectFindPwd(FindVO vo) {
		return (int) select("memberDAO.selectFindPwd", vo);
	}

	public int updatePwd(FindVO vo) {
		return update("memberDAO.updatePwd", vo);
	}

	
}
