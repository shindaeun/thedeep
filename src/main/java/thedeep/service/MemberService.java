package thedeep.service;

import java.util.List;

public interface MemberService {

	List<?> selectCartList(String userid) throws Exception;

	int updateCart(CartVO vo) throws Exception;

	int cartDelete(CartVO vo) throws Exception;

	List<?> selectCouponList(String userid) throws Exception;

	List<?> selectPointList(String userid) throws Exception;

	String selectAllPoint(String userid) throws Exception;

	String selectAblePoint(String userid) throws Exception;

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

	List<?> selectUserOrderList(String userid) throws Exception;

	int selectFindid(FindVO vo) throws Exception;

	List<?> selectFindIdList(FindVO fvo) throws Exception;

	int selectFindidCnt(FindVO fvo) throws Exception;
	
	int selectPwdChk(PwdCkVO vo) throws Exception;



}
