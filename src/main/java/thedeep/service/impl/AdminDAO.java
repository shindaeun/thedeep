package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.AdminVO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.PwdCkVO;

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

	public List<?> selectOrderList() {
		return list("adminDAO.selectOrderList");
	}

	public List<?> selectOrderList(DefaultVO searchVO) {
		return list("adminDAO.selectOrderList",searchVO);
	}

	public int selectOrderListTotCnt(DefaultVO searchVO) {
		return (int) select("adminDAO.selectOrderListTotCnt",searchVO);
	}

}
