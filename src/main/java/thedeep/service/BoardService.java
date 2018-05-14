package thedeep.service;

import java.util.List;

public interface BoardService {

	List<?> selectQnaList(DefaultVO searchVO) throws Exception;

	int selectQnaListTotCnt(DefaultVO searchVO) throws Exception;

	String insertUpload(BoardVO vo) throws Exception;

	BoardVO selectQnaImage(int unq) throws Exception;

}
