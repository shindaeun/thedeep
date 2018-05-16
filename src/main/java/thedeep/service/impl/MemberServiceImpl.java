package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import thedeep.service.CartVO;
import thedeep.service.MemberService;
@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Override
	public List<?> selectCartList(String userid) throws Exception {
		return memberDAO.selectCartList(userid);
	}

	@Override
	public int updateCart(CartVO vo) throws Exception {
		return memberDAO.updateCart(vo);
	}

	@Override
	public int cartDelete(CartVO vo) throws Exception {
		return memberDAO.cartDelete(vo);
	}

	@Override
	public List<?> selectCouponList(String userid) throws Exception {
		return memberDAO.selectCouponList(userid);
	}

	@Override
	public List<?> selectPointList(String userid) throws Exception {
		return memberDAO.selectPointList(userid);
	}

	@Override
	public String selectAllPoint(String userid) throws Exception {
		return memberDAO.selectAllPoint(userid);
	}

	@Override
	public String selectAblePoint(String userid) throws Exception {
		return memberDAO.selectAblePoint(userid);
	}

}
