package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.AdminVO;
import thedeep.service.BoardVO;
import thedeep.service.CheckVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.OrderVO;
import thedeep.service.PointVO;
import thedeep.service.ProductVO;
import thedeep.service.PwdCkVO;
import thedeep.service.ReviewReplyVO;

@Repository("adminDAO")
public class AdminDAO extends EgovAbstractDAO {

	public String insertAdmin(AdminVO vo) {
		return (String) insert("adminDAO.insertAdmin",vo);
	}

	public int selectIdChk(String adminid) {
		return (int) select("adminDAO.selectIdChk", adminid);
	}

	public int selectAdminCertCnt(AdminVO vo) {
		return (int) select("adminDAO.selectAdminCertCnt",vo);
	}

	public AdminVO selectAdminDetail(String adminid) {
		return (AdminVO) select("adminDAO.selectAdminDetail", adminid);
	}

	public int selectAdminPwdChk(PwdCkVO vo) {
		return (int) select("adminDAO.selectAdminPwdChk", vo);
	}

	public int updateAdmin(AdminVO vo) {
		return update("adminDAO.updateAdmin", vo);
	}

	public List<?> selectAdminList(DefaultVO searchVO) {
		return list("adminDAO.selectAdminList", searchVO);
	}

	public int selectAdminListTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectAdminListTotCnt", searchVO);
	}

	public String insertQnareply(BoardVO vo) {
		return (String) insert("adminDAO.insertQnareply", vo);
	}


	public int selectQnaRePwdChk(AdminVO vo) {
		return (int) select("adminDAO.selectQnaRePwdChk", vo);
	}

	public int updateQnaReModify(BoardVO vo) {
		return update("adminDAO.updateQnaReModify", vo);
	}

	public int deleteQnaRe(BoardVO bvo) {
		return delete("adminDAO.deleteQnaRe", bvo);
	}
	public List<?> selectOrderList() {
		return list("adminDAO.selectOrderList");
	}

	public List<?> selectOrderList(DefaultVO searchVO) {
		return list("adminDAO.selectOrderList",searchVO);
	}

	public int selectOrderListTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectOrderListTotCnt",searchVO);
	}

	public List<?> selectOrderDetail(String ocode) {
		return list("adminDAO.selectOrderDetail",ocode);
	}

	public int updateTransNum(DeliveryVO vo) {
		return update("adminDAO.updateTransNum",vo);
	}

	public int updateDstate(DeliveryVO vo) {
		return update("adminDAO.updateDstate",vo);

	}

	public String insertReviewReply(ReviewReplyVO vo) {
		return (String) insert("adminDAO.insertReviewReply",vo);
	}

	public List<?> selectQnaList(DefaultVO searchVO) {
		return list("adminDAO.selectQnaList",searchVO);
	}

	public int selectQnaTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectQnaTotCnt",searchVO);
	}

	public List<?> selectReviewList(DefaultVO searchVO) {
		return list("adminDAO.selectReviewList",searchVO);
	}

	public int selectReviewTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectReviewTotCnt",searchVO);
	}

	public List<?> selectCouponList(DefaultVO searchVO) {
		return list("adminDAO.selectCouponList", searchVO);
	}

	public CouponVO selectCouponDetail(String ccode) {
		return (CouponVO) select("adminDAO.selectCouponDetail", ccode);
	}

	public String insertAdminCoupon(CouponVO vo) {
		return (String) insert("adminDAO.insertAdminCoupon", vo);
	}

	public int updateAdminCoupon(CouponVO vo) {
		return update("adminDAO.updateAdminCoupon", vo);
	}

	public String insertPoint(PointVO vo) {
		return (String) insert("adminDAO.insertPoint", vo);
	}

	public String selectAblePoint(String userid) {
		return (String) select("adminDAO.selectAblePoint", userid);
	}

	public int selectMemberIdChk(String userid) {
		return (int) select("adminDAO.selectMemberIdChk", userid);
	}

	public int deleteAdminCoupon(String ccode) {
		return delete("adminDAO.deleteAdminCoupon", ccode);
	}

	public int deleteReviewReply(String unq) {
		return delete("adminDAO.deleteReviewReply", unq);
	}
	public String insertAdminCouponOut(CheckVO cvo) {
		return (String) insert("adminDAO.insertAdminCouponOut", cvo);
	}

	public String selectCouponName(String ccode) {
		return (String) select("adminDAO.selectCouponName", ccode);
	}

	public List<?> selectPointList(DefaultVO searchVO) {
		return list("adminDAO.selectPointList",searchVO);
	}

	public int selectPointListTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectPointListTotCnt",searchVO);
	}

	public int selectColorSize(ProductVO vo) {
		return (int) select("adminDAO.selectColorSize",vo);
	}

	public int selectCouponListCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectCouponListCnt", searchVO);
	}

	public String selectMaxCode() {
		return (String) select("adminDAO.selectMaxCode");
	}

	public int upadateUserCoupon(CouponVO vo) {
		return update("adminDAO.upadateUserCoupon", vo);
	}


}
