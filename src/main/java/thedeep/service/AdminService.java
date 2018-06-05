package thedeep.service;

import java.util.List;

public interface AdminService {

	String insertAdmin(AdminVO vo) throws Exception;

	int selectIdChk(String adminid) throws Exception;

	int selectAdminCertCnt(AdminVO vo) throws Exception;

	AdminVO selectAdminDetail(String adminid) throws Exception;

	int selectAdminPwdChk(PwdCkVO vo) throws Exception;

	int updateAdmin(AdminVO vo) throws Exception;

	List<?> selectAdminList(DefaultVO searchVO) throws Exception;

	int selectAdminListTotCnt(DefaultVO searchVO) throws Exception;

	String insertQnareply(BoardVO vo) throws Exception;


	int selectQnaRePwdChk(AdminVO vo) throws Exception;

	int updateQnaReModify(BoardVO vo) throws Exception;

	int deleteQnaRe(BoardVO bvo) throws Exception;

	List<?> selectOrderList(DefaultVO searchVO) throws Exception;

	int selectOrderListTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectOrderDetail(String ocode) throws Exception;

	int updateTransNum(DeliveryVO vo) throws Exception;

	int updateDstate(DeliveryVO vo) throws Exception;

	String insertReviewReply(ReviewReplyVO vo) throws Exception;

	List<?> selectQnaList(DefaultVO searchVO) throws Exception;

	int selectQnaTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectReviewList(DefaultVO searchVO) throws Exception;

	int selectReviewTotCnt(DefaultVO searchVO) throws Exception;

	List<?> selectCouponList() throws Exception;

	CouponVO selectCouponDetail(String ccode) throws Exception;

	String insertAdminCoupon(CouponVO vo) throws Exception;

	int updateAdminCoupon(CouponVO vo) throws Exception;

	List<?> selectPointList() throws Exception;

	String insertPoint(PointVO vo) throws Exception;

	String selectAblePoint(String userid) throws Exception;

	int selectMemberIdChk(String userid) throws Exception;

	int deleteAdminCoupon(String ccode) throws Exception;


	int deleteReviewReply(String unq) throws Exception;

	String insertAdminCouponOut(CheckVO cvo) throws Exception;

	String selectCouponName(String ccode) throws Exception;



}
