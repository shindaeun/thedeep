package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import thedeep.service.BoardService;
import thedeep.service.BoardVO;
import thedeep.service.DefaultVO;

@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	
	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;

	@Override
	public List<?> selectQnaList(DefaultVO searchVO) throws Exception {
		return boardDAO.selectQnaList(searchVO);
	}

	@Override
	public int selectQnaListTotCnt(DefaultVO searchVO) throws Exception {
		return boardDAO.selectQnaListTotCnt(searchVO);
	}

	@Override
	public String insertUpload(BoardVO vo) throws Exception {
		return boardDAO.insertUpload(vo);
	}

	@Override
	public BoardVO selectQnaImage(int unq) throws Exception {
		return boardDAO.selectQnaImage(unq);
	}
	
}
