package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import thedeep.service.CartVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.FindVO;
import thedeep.service.MemberService;
import thedeep.service.MemberVO;
import thedeep.service.OrderListVO;
import thedeep.service.OrderVO;
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
	public List<?> selectPointList(String userid) throws Exception {
		return memberDAO.selectPointList(userid);
	}

	@Override
	public String selectAllPoint(String userid) throws Exception {
		return memberDAO.selectAllPoint(userid);
	}

	@Override
	public String selectAblePoint(String userid) throws Exception {
		return memberDAO.selectAblePoint(userid);
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
	public int updateAblePoint(MemberVO mvo) throws Exception {
		return memberDAO.updateAblePoint(mvo);
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

}
