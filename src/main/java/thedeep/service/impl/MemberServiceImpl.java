package thedeep.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import thedeep.service.MemberService;
@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Override
	public List<?> selectCartList(String userid) throws Exception {
		return memberDAO.selectCartList(userid);
	}

}
