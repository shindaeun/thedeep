package thedeep.service;

import java.util.List;

public interface MemberService {

	List<?> selectCartList(String userid) throws Exception;

	int updateCart(CartVO vo) throws Exception;

	int cartDelete(CartVO vo) throws Exception;

}
