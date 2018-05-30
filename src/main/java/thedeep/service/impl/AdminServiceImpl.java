package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardVO;
import thedeep.service.CouponVO;
import thedeep.service.DefaultVO;
import thedeep.service.DeliveryVO;
import thedeep.service.PwdCkVO;
import thedeep.service.ReviewReplyVO;

@Service("adminService")
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService {
	
	@Resource(name = "adminDAO")
	private AdminDAO adminDAO;

	@Override
	public String insertAdmin(AdminVO vo) throws Exception {
		return adminDAO.insertAdmin(vo);
	}

	@Override
	public int selectIdChk(String adminid) throws Exception {
		return adminDAO.selectIdChk(adminid);
	}

	@Override
	public int selectAdminCertCnt(AdminVO vo) throws Exception {
		return adminDAO.selectAdminCertCnt(vo);
	}

	@Override
	public AdminVO selectAdminDetail(String adminid) throws Exception {
		return adminDAO.selectAdminDetail(adminid);
	}

	@Override
	public int selectAdminPwdChk(PwdCkVO vo) throws Exception {
		return adminDAO.selectAdminPwdChk(vo);
	}

	@Override
	public int updateAdmin(AdminVO vo) throws Exception {
		return adminDAO.updateAdmin(vo);
	}

	@Override
	public List<?> selectAdminList(DefaultVO searchVO) throws Exception {
		return adminDAO.selectAdminList(searchVO);
	}

	@Override
	public int selectAdminListTotCnt(DefaultVO searchVO) throws Exception {
		return adminDAO.selectAdminListTotCnt(searchVO);
	}

	@Override
	public String insertQnareply(BoardVO vo) throws Exception {
		return adminDAO.insertQnareply(vo);
	}

	@Override
	public int selectQnaRePwdChk(AdminVO vo) throws Exception {
		return adminDAO.selectQnaRePwdChk(vo);
	}

	@Override
	public int updateQnaReModify(BoardVO vo) throws Exception {
		return adminDAO.updateQnaReModify(vo);
	}

	@Override
	public int deleteQnaRe(BoardVO bvo) throws Exception {
		return adminDAO.deleteQnaRe(bvo);
	}


	public List<?> selectOrderList(DefaultVO searchVO) throws Exception {
		return adminDAO.selectOrderList(searchVO);
	}

	@Override
	public int selectOrderListTotCnt(DefaultVO searchVO) throws Exception {
		return adminDAO.selectOrderListTotCnt(searchVO);
	}

	@Override
	public List<?> selectOrderDetail(String ocode) throws Exception {
		return adminDAO.selectOrderDetail(ocode);
	}

	@Override
	public int updateTransNum(DeliveryVO vo) throws Exception {
		return adminDAO.updateTransNum(vo);
	}

	@Override
	public int updateDstate(String ocode) throws Exception {
		return adminDAO.updateDstate(ocode);
	}

	@Override
	public String insertReviewReply(ReviewReplyVO vo) throws Exception {
		return adminDAO.insertReviewReply(vo);
	}

	@Override
	public List<?> selectQnaList(DefaultVO searchVO) throws Exception {
		return adminDAO.selectQnaList(searchVO);
	}

	@Override
	public int selectQnaTotCnt(DefaultVO searchVO) throws Exception {
		return adminDAO.selectQnaTotCnt(searchVO);
	}

	@Override
	public List<?> selectReviewList(DefaultVO searchVO) throws Exception {
		return adminDAO.selectReviewList(searchVO);
	}

	@Override
	public int selectReviewTotCnt(DefaultVO searchVO) throws Exception {
		return adminDAO.selectReviewTotCnt(searchVO);
	}

	@Override
	public List<?> selectCouponList() throws Exception {
		return adminDAO.selectCouponList();
	}

	@Override
	public CouponVO selectCouponDetail(String ccode) throws Exception {
		return adminDAO.selectCouponDetail(ccode);
	}



	
}
