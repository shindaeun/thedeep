package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import thedeep.service.CartVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.FindVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.OrderListVO;
import thedeep.service.OrderVO;
import thedeep.service.PointVO;
import thedeep.service.PwdCkVO;
@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Override
	public List<?> selectCartList(String userid) throws Exception {
		return memberDAO.selectCartList(userid);
	}

	@Override
	public int updateCart(CartVO vo) throws Exception {
		return memberDAO.updateCart(vo);
	}

	@Override
	public int cartDelete(CartVO vo) throws Exception {
		return memberDAO.cartDelete(vo);
	}

	@Override
	public List<?> selectCouponList(String userid) throws Exception {
		return memberDAO.selectCouponList(userid);
	}

	@Override
	public List<?> selectPointList(DefaultVO searchVO) throws Exception {
		return memberDAO.selectPointList(searchVO);
	}

	@Override
	public String selectAllPoint(String userid) throws Exception {
		return memberDAO.selectAllPoint(userid);
	}

	@Override
	public List<?> selectUserReview(DefaultVO searchVO) throws Exception {
		return memberDAO.selectUserReview(searchVO);
	}

	@Override
	public int selectUserReviewTotCnt(DefaultVO searchVO) throws Exception {
		return memberDAO.selectUserReviewTotCnt(searchVO);
	}

	@Override
	public List<?> selectUserQna(DefaultVO searchVO) throws Exception {
		return memberDAO.selectUserQna(searchVO);
	}

	@Override
	public int selectUserQnaTotCnt(DefaultVO searchVO) throws Exception {
		return memberDAO.selectUserQnaTotCnt(searchVO);
	}

	@Override
	public String insertCartList(CartVO vo) throws Exception {
		return memberDAO.insertCartList(vo);
	}

	@Override
	public int selectCartCscodeCount(CartVO vo) throws Exception {
		return memberDAO.selectCartCscodeCount(vo);
	}
	
	@Override
	public int selectIdChk(String userid) throws Exception {
		return memberDAO.selectIdChk(userid);
	}

	@Override
	public String insertMember(MemberVO vo) throws Exception {
		return memberDAO.insertMember(vo);
	}

	@Override
	public int selectMemberCertCnt(MemberVO vo) throws Exception {
		return memberDAO.selectMemberCertCnt(vo);
	}

	@Override
	public MemberVO selectMemeberDetail(String userid) throws Exception {
		return memberDAO.selectMemeberDetail(userid);
	}

	@Override
	public int updateMember(MemberVO vo) throws Exception {
		return memberDAO.updateMember(vo);
	}

	@Override
	public int selectMemberCoupon(String userid) throws Exception {
		return memberDAO.selectMemberCoupon(userid);
	}

	@Override
	public int selectMemberMoney(String userid) throws Exception {
		return memberDAO.selectMemberMoney(userid);
	}

	@Override
	public List<?> selectUserOrderList(String userid) throws Exception {
		return memberDAO.selectUserOrderList(userid);
	}

	@Override
	public int selectFindid(FindVO vo) throws Exception {
		return memberDAO.selectFindid(vo);
	}

	@Override
	public List<?> selectFindIdList(FindVO fvo) throws Exception {
		return memberDAO.selectFindIdList(fvo);
	}

	@Override
	public int selectFindidCnt(FindVO fvo) throws Exception {
		return memberDAO.selectFindidCnt(fvo);
	}
	
	@Override
	public int selectPwdChk(PwdCkVO vo) throws Exception {
		return memberDAO.selectPwdChk(vo);
	}

	@Override
	public CartVO selectCartProductInfo(CartVO vo) throws Exception {
		return memberDAO.selectCartProductInfo(vo);
	}

	@Override

	public int selectFindPwd(FindVO vo) throws Exception {
		return memberDAO.selectFindPwd(vo);
	}

	@Override
	public int updatePwd(FindVO vo) throws Exception {
		return memberDAO.updatePwd(vo);
	}

	@Override
	public int selectInMoneyCnt(String userid) throws Exception {
		return memberDAO.selectInMoneyCnt(userid);
	}

	@Override
	public int selectPreparingCnt(String userid) throws Exception {
		return memberDAO.selectPreparingCnt(userid);
	}

	@Override
	public int selectDeliverCnt(String userid) throws Exception {
		return memberDAO.selectDeliverCnt(userid);
	}

	@Override
	public int selectCompleteCnt(String userid) throws Exception {
		return memberDAO.selectCompleteCnt(userid);
	}
	public List<?> selectUserCouponList(String userid) throws Exception {
		return memberDAO.selectUserCouponList(userid);
	}

	@Override
	public CartVO selectProductInfo(CartVO vo) throws Exception {
		return memberDAO.selectProductInfo(vo);
	}

	@Override
	public String selectOcodeNext() throws Exception {
		return memberDAO.selectOcodeNext();
	}

	@Override
	public String insertOrder(OrderVO ovo) throws Exception {
		return memberDAO.insertOrder(ovo);
	}

	@Override
	public String insertDelivery(DeliveryVO dvo) throws Exception {
		return memberDAO.insertDelivery(dvo);
	}

	@Override
	public String insertOrderList(OrderListVO vo) throws Exception {
		return memberDAO.insertOrderList(vo);
	}


	@Override
	public int deleteUseCoupon(OrderVO ovo) throws Exception {
		return memberDAO.deleteUseCoupon(ovo);
	}

	@Override
	public OrderVO selectOrderInfo(String ocode) throws Exception {
		return memberDAO.selectOrderInfo(ocode);
	}

	@Override
	public String selectOrderList(String ocode) throws Exception {
		return memberDAO.selectOrderList(ocode);

	}

	@Override
	public String selectLatestPost(String userid) throws Exception {
		return memberDAO.selectLatestPost(userid);
	}

	@Override
	public String insertCoupon(CouponVO cvo) throws Exception {
		return memberDAO.insertCoupon(cvo);
	}

	@Override
	public List<?> selectMemberBTD(String today) throws Exception {
		return memberDAO.selectMemberBTD(today);
	}

	@Override
	public String insertBTDCoupon(CouponVO cvo) throws Exception {
		return memberDAO.insertBTDCoupon(cvo);
	}

	@Override
	public int selectBTDCoupon(String userid) throws Exception {
		return memberDAO.selectBTDCoupon(userid);
	}

	@Override
	public String selectBtdCheck(String userid) throws Exception {
		return memberDAO.selectBtdCheck(userid);
	}

	@Override
	public int updateUseCoupon(OrderVO ovo) throws Exception {
		return memberDAO.updateUseCoupon(ovo);
	}
	@Override
	public int updateUseCoupon2(OrderVO ovo) throws Exception {
		return memberDAO.updateUseCoupon2(ovo);
	}

	@Override
	public List<?> selectOrderListByOcode(String ocode) throws Exception {
		return memberDAO.selectOrderListByOcode(ocode);
	}

	@Override
	public String insertPoint(PointVO point) throws Exception {
		return memberDAO.insertPoint(point);
	}

	@Override

	public String insertMemPoint(String userid) throws Exception {
		return memberDAO.insertMemPoint(userid);
	}

	@Override
	public int selectMemberPoint(String userid) throws Exception {
		return memberDAO.selectMemberPoint(userid);
	}
	public int updateBuyConfirm(OrderListVO vo) throws Exception {
		return memberDAO.updateBuyConfirm(vo);
	}

	@Override
	public String selectBuyConfirm(String ocode) throws Exception {
		return memberDAO.selectBuyConfirm(ocode);

	}

	@Override
	public int selectOnMoneyCnt(String userid) throws Exception {
		return memberDAO.selectOnMoneyCnt(userid);
	}

	@Override
	public int selectPointTotCnt(String userid) throws Exception {
		return memberDAO.selectPointTotCnt(userid);
	}

	@Override
	public int updateAdminMemo(OrderVO vo) throws Exception {
		return memberDAO.updateAdminMemo(vo);
	}

	@Override
	public int updateBuyConfirm2(OrderListVO vo) throws Exception {
		return memberDAO.updateBuyConfirm2(vo);
	}

	@Override
	public OrderListVO selectOrderInfoByOVO(OrderListVO vo) throws Exception {
		return memberDAO.selectOrderInfoByOVO(vo);
	}

	@Override
	public int selectDisRate(String ocode) throws Exception {
		return memberDAO.selectDisRate(ocode);
	}

	@Override
	public int updateBuyConfirm3(OrderListVO vo) throws Exception {
		return memberDAO.updateBuyConfirm3(vo);
	}

	@Override
	public int selectCancelConfirm(String ocode) throws Exception {
		return memberDAO.selectCancelConfirm(ocode);
	}

	@Override
	public int selectUserOrderListCnt(DefaultVO searchVO) throws Exception {
		return memberDAO.selectUserOrderListCnt(searchVO);
	}


}
