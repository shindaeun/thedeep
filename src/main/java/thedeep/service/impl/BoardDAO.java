package thedeep.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	public List<?> selectQnaList(DefaultVO searchVO) {
		return list("boardDAO.selectQnaList", searchVO);
	}

	public int selectQnaListTotCnt(DefaultVO searchVO) {
		return (int) select("boardDAO.selectQnaListTotCnt", searchVO);
	}

	public String insertUpload(BoardVO vo) {
		return (String) insert("boardDAO.insertUpload",vo);
	}

	public BoardVO selectQnaImage(int unq) {
		return (BoardVO) select("boardDAO.selectQnaImage", unq);
	}
	
}
