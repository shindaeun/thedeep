package thedeep.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

public interface MemberService {

	List<?> selectCartList(String userid) throws Exception;

	int updateCart(CartVO vo) throws Exception;

	int cartDelete(CartVO vo) throws Exception;

	List<?> selectCouponList(String userid) throws Exception;

	List<?> selectPointList(DefaultVO searchVO) throws Exception;

	String selectAllPoint(String userid) throws Exception;

	List<?> selectUserReview(DefaultVO searchVO) throws Exception;

	int selectUserReviewTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectUserQna(DefaultVO searchVO) throws Exception;

	int selectUserQnaTotCnt(DefaultVO searchVO) throws Exception;

	String insertCartList(CartVO vo) throws Exception;

	int selectCartCscodeCount(CartVO vo) throws Exception;
	
	int selectIdChk(String userid) throws Exception;

	String insertMember(MemberVO vo) throws Exception;

	int selectMemberCertCnt(MemberVO vo) throws Exception;

	MemberVO selectMemeberDetail(String userid) throws Exception;

	int updateMember(MemberVO vo) throws Exception;

	int selectMemberCoupon(String userid) throws Exception;

	int selectMemberMoney(String userid) throws Exception;

	List<?> selectUserOrderList(DefaultVO searchVO) throws Exception;

	int selectFindid(FindVO vo) throws Exception;

	List<?> selectFindIdList(FindVO fvo) throws Exception;

	int selectFindidCnt(FindVO fvo) throws Exception;
	
	int selectPwdChk(PwdCkVO vo) throws Exception;

	CartVO selectCartProductInfo(CartVO vo) throws Exception;

	int selectFindPwd(FindVO vo) throws Exception;

	int updatePwd(FindVO vo) throws Exception;

	int selectInMoneyCnt(String userid) throws Exception;

	int selectPreparingCnt(String userid) throws Exception;

	int selectDeliverCnt(String userid) throws Exception;

	int selectCompleteCnt(String userid) throws Exception;

	List<?> selectUserCouponList(String userid) throws Exception;

	CartVO selectProductInfo(CartVO vo) throws Exception;

	String selectOcodeNext() throws Exception;

	String insertOrder(OrderVO ovo)  throws Exception;

	String insertDelivery(DeliveryVO dvo)  throws Exception;

	String insertOrderList(OrderListVO vo)  throws Exception;

	int deleteUseCoupon(OrderVO ovo) throws Exception;

	OrderVO selectOrderInfo(String ocode)  throws Exception;

	String selectOrderList(String ocode)  throws Exception;

	String selectLatestPost(String userid) throws Exception;

	String insertCoupon(CouponVO cvo) throws Exception;

	List<?> selectMemberBTD(String bmonth) throws Exception;

	String insertBTDCoupon(CouponVO cvo) throws Exception;

	int selectBTDCoupon(String userid) throws Exception;

	String selectBtdCheck(String userid) throws Exception;

	int updateUseCoupon(OrderVO ovo) throws Exception;
	
	int updateUseCoupon2(OrderVO ovo) throws Exception;

	List<?> selectOrderListByOcode(String ocode) throws Exception;

	String insertPoint(PointVO point) throws Exception;

	String insertMemPoint(String userid) throws Exception;

	int selectMemberPoint(String userid) throws Exception;

	int updateBuyConfirm(OrderListVO vo)  throws Exception;

	String selectBuyConfirm(String ocode) throws Exception;

	int selectOnMoneyCnt(String userid) throws Exception;

	int selectPointTotCnt(String userid) throws Exception;

	int updateAdminMemo(OrderVO vo) throws Exception;

	int updateBuyConfirm2(OrderListVO vo) throws Exception;

	OrderListVO selectOrderInfoByOVO(OrderListVO vo) throws Exception;

	int selectDisRate(String ocode) throws Exception;

	int updateBuyConfirm3(OrderListVO vo) throws Exception;

	int selectCancelConfirm(String ocode) throws Exception;
	
	int selectUserOrderListCnt(DefaultVO searchVO) throws Exception;

	List<?> selectCancelCnt(String userid) throws Exception;
	
	int selectDstateCnt(String userid) throws Exception;

	int selectDstateInCnt(String userid) throws Exception;
	
	int memberInfoDelete(String userid) throws Exception;

	int memberPoinDelete(String userid) throws Exception;

	int memberCouDelete(String userid) throws Exception;

	int memberCartDelete(String userid) throws Exception;

	List<?> selectQnaFid(String userid) throws Exception;

	int memberQnaDelete(String fid) throws Exception;

	int memberReDelete(String userid) throws Exception;

	int memberDeliDelete(String ocode) throws Exception;

	List<?> selectOcode(String userid) throws Exception;

	int memberOrderDelete(String userid) throws Exception;

	List<?> selectOcode2(String userid) throws Exception;

	int memberOrListDelete(String ocode2) throws Exception;


	int deleteOrderInfo(String ocode) throws Exception;

	int deleteOrderList(String ocode) throws Exception;

	int deleteOrderDelivery(String ocode) throws Exception;






}
