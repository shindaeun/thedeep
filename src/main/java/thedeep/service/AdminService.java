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

}