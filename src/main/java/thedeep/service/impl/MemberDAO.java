package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.CartVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.FindVO;
import thedeep.service.MemberVO;
import thedeep.service.OrderListVO;
import thedeep.service.OrderVO;
import thedeep.service.PointVO;
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

	public List<?> selectPointList(DefaultVO searchVO) {
		return list("memberDAO.selectPointList",searchVO);
	}

	public String selectAllPoint(String userid) {
		return (String) select("memberDAO.selectAllPoint",userid);
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

	public List<?> selectUserOrderList(DefaultVO searchVO) {
		return list("memberDAO.selectUserOrderList", searchVO);
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

	public int selectInMoneyCnt(String userid) {
		return (int) select("memberDAO.selectInMoneyCnt", userid);
	}

	public int selectPreparingCnt(String userid) {
		return (int) select("memberDAO.selectPreparingCnt", userid);
	}

	public int selectDeliverCnt(String userid) {
		return (int) select("memberDAO.selectDeliverCnt", userid);
	}

	public int selectCompleteCnt(String userid) {
		return (int) select("memberDAO.selectCompleteCnt", userid);
	}
	public List<?> selectUserCouponList(String userid) {
		return list("memberDAO.selectUserCouponList",userid);
	}

	public CartVO selectProductInfo(CartVO vo) {
		return (CartVO) select("memberDAO.selectProductInfo",vo);
	}

	public String selectOcodeNext() {
		return (String) select("memberDAO.selectOcodeNext");
	}

	public String insertOrder(OrderVO ovo) {
		return (String) insert("memberDAO.insertOrder",ovo);
	}

	public String insertDelivery(DeliveryVO dvo) {
		return (String) insert("memberDAO.insertDelivery",dvo);
	}

	public String insertOrderList(OrderListVO vo) {
		return (String) insert("memberDAO.insertOrderList",vo);
	}

	public int deleteUseCoupon(OrderVO ovo) {
		return delete("memberDAO.deleteUseCoupon",ovo);
	}

	public OrderVO selectOrderInfo(String ocode) {
		return (OrderVO) select("memberDAO.selectOrderInfo",ocode);
	}

	public String selectOrderList(String ocode) {
		return  (String) select("memberDAO.selectOrderList",ocode);
	}

	public String selectLatestPost(String userid) {
		return (String) select("memberDAO.selectLatestPost",userid);
	}

	public String insertCoupon(CouponVO cvo) {
		return (String) insert("memberDAO.insertCoupon", cvo);
	}

	public List<?> selectMemberBTD(String bmonth) {
		return list("memberDAO.selectMemberBTD", bmonth);
	}

	public String insertBTDCoupon(CouponVO cvo) {
		return (String) insert("memberDAO.insertBTDCoupon", cvo);
	}

	public int selectBTDCoupon(String userid) {
		return (int) select("memberDAO.selectBTDCoupon", userid);
	}

	public String selectBtdCheck(String userid) {
		return (String) select("memberDAO.selectBtdCheck", userid);
	}

	public int updateUseCoupon(OrderVO ovo) {
		return update("memberDAO.updateUseCoupon",ovo);
		
	}

	public int updateUseCoupon2(OrderVO ovo) {
		return update("memberDAO.updateUseCoupon2",ovo);
	}

	public List<?> selectOrderListByOcode(String ocode) {
		return list("memberDAO.selectOrderListByOcode",ocode);
	}

	public String insertPoint(PointVO point) {
		return (String) insert("memberDAO.insertPoint",point);
	}


	public String insertMemPoint(String userid) {
		return (String) insert("memberDAO.insertMemPoint", userid);
	}

	public int selectMemberPoint(String userid) {
		return (int) select("memberDAO.selectMemberPoint", userid);
	}
	public int updateBuyConfirm(OrderListVO vo) {
		return update("memberDAO.updateBuyConfirm",vo);
	}

	public String selectBuyConfirm(String ocode) {
		return (String) select("memberDAO.selectBuyConfirm",ocode);

	}

	public int selectOnMoneyCnt(String userid) {
		return (int) select("memberDAO.selectOnMoneyCnt", userid);
	}

	public int selectPointTotCnt(String userid) {
		return (int) select("memberDAO.selectPointTotCnt", userid);
	}

	public int updateAdminMemo(OrderVO vo) {
		return update("memberDAO.updateAdminMemo",vo);
	}

	public int updateBuyConfirm2(OrderListVO vo) {
		return update("memberDAO.updateBuyConfirm2",vo);
	}

	public OrderListVO selectOrderInfoByOVO(OrderListVO vo) {
		return (OrderListVO) select("memberDAO.selectOrderInfoByOVO",vo);
	}

	public int selectDisRate(String ocode) {
		return (int) select("memberDAO.selectDisRate",ocode);
	}

	public int updateBuyConfirm3(OrderListVO vo) {
		return update("memberDAO.updateBuyConfirm3",vo);
	}

	public int selectCancelConfirm(String ocode) {
		return (int) select("memberDAO.selectCancelConfirm",ocode);
	}
	
	public int selectUserOrderListCnt(DefaultVO searchVO) {
		return (int) select("memberDAO.selectUserOrderListCnt", searchVO);
	}

	public List<?> selectCancelCnt(String userid) {
		return list("memberDAO.selectCancelCnt",userid);
	}
	
	public int selectDstateCnt(String userid) {
		return (int) select("memberDAO.selectDstateCnt", userid);
	}
	
	public int selectDstateInCnt(String userid) {
		return (int) select("memberDAO.selectDstateInCnt", userid);
	}
	
	public int memberInfoDelete(String userid) {
		return delete("memberDAO.memberInfoDelete", userid);
	}

	public int memberPoinDelete(String userid) {
		return delete("memberDAO.memberPoinDelete", userid);
	}

	public int memberCouDelete(String userid) {
		return delete("memberDAO.memberCouDelete", userid);
	}

	public int memberCartDelete(String userid) {
		return delete("memberDAO.memberCartDelete", userid);
	}

	public List<?> selectQnaFid(String userid) {
		return list("memberDAO.selectQnaFid", userid);
	}

	public int deleteOrderInfo(String ocode) {
		return delete("memberDAO.deleteOrderInfo",ocode);
	}

	public int deleteOrderList(String ocode) {
		return delete("memberDAO.deleteOrderList",ocode);
	}

	public int deleteOrderDelivery(String ocode) {
		return delete("memberDAO.deleteOrderDelivery",ocode);
	}

	public int memberQnaDelete(String fid) {
		return delete("memberDAO.memberQnaDelete", fid);
	}

	public int memberReDelete(String userid) {
		return delete("memberDAO.memberReDelete", userid);
	}

	public int memberDeliDelete(String ocode) {
		return delete("memberDAO.memberDeliDelete", ocode);
	}

	public List<?> selectOcode(String userid) {
		return list("memberDAO.selectOcode", userid);
	}

	public int memberOrderDelete(String userid) {
		return delete("memberDAO.memberOrderDelete", userid);
	}

	public List<?> selectOcode2(String userid) {
		return list("memberDAO.selectOcode2", userid);
	}

	public int memberOrListDelete(String ocode2) {
		return delete("memberDAO.memberOrListDelete", ocode2);
	}


	
}
