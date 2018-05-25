package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.AdminService;
import thedeep.service.AdminVO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;
import thedeep.service.PwdCkVO;

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


	
}
