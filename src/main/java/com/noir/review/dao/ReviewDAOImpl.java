package com.noir.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.noir.member.vo.MemberVO;
import com.noir.review.vo.ReviewAdminVO;
import com.noir.review.vo.ReviewCustomerVO;
import com.noir.review.vo.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ReviewVO> selectReviewsByPaging(int offset, int limit) throws Exception {
	    Map<String, Object> param = new HashMap<>();
	    param.put("offset", offset);
	    param.put("limit", limit);
	    
	    List<ReviewVO> list = sqlSession.selectList("mapper.review.selectReviewsByPaging", param);
	    	
	    for(ReviewVO review : list) {
	    	
	    	int customer_id = review.getCustomer_id();
	    	
	    	int member_id = sqlSession.selectOne("mapper.member.findMeberIdByCustomerId",customer_id);
	    	
	    	String userName = sqlSession.selectOne("mapper.member.findNameByMemberId",member_id);
	    	
	    	review.setUserName(userName);
	    }
	    
	    return list;
	}

	@Override
	public int selectReviewCount() throws Exception {
	    return sqlSession.selectOne("mapper.review.selectReviewCount");
	}

	@Override
	public ReviewVO selectReviewById(int reviewId) throws Exception {
		return sqlSession.selectOne("mapper.review.selectReviewById", reviewId);
	}

	@Override
	public void insertReview(ReviewVO review) throws Exception {
		sqlSession.insert("mapper.review.insertReview", review);
	}

	@Override
	public void updateReview(ReviewVO review) throws Exception {
		sqlSession.update("mapper.review.updateReview", review);
	}

	@Override
	public void deleteReview(int reviewId) throws Exception {
		sqlSession.delete("mapper.review.deleteReview", reviewId);
	}

	@Override
	public List<String> selectReviewPhotos(Long reviewId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewPhotos", reviewId);
	}

	@Override
	public void insertReviewPhoto(int reviewId, String photoUrl) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("reviewId", reviewId);
		param.put("photoUrl", photoUrl);
		sqlSession.insert("mapper.review.insertReviewPhoto", param);
	}

	@Override
	public void deleteReviewPhotos(int reviewId) throws Exception {
		sqlSession.delete("mapper.review.deleteReviewPhotos", reviewId);
	}
	
	public List<ReviewCustomerVO> findReserveByMemberId(int member_id) {
		
		List<ReviewCustomerVO> list = sqlSession.selectList("mapper.review.findReserveByMemberId",member_id);
		
		for(ReviewCustomerVO reserve : list) {
			
			int reserve_id = reserve.getReserve_id();
			
			ReviewAdminVO adminVO =  sqlSession.selectOne("mapper.review.findAdminByReserveId",reserve_id);
			
			reserve.setReviewAdminVO(adminVO);	
			
		}
		
		return list;
	}

	public List<ReviewCustomerVO> findReserve() {
		
		List<ReviewCustomerVO> list = sqlSession.selectList("mapper.review.findReserve");
		
		for(ReviewCustomerVO reserve : list) {
			
			int reserve_id = reserve.getReserve_id();
			
			ReviewAdminVO adminVO =  sqlSession.selectOne("mapper.review.findAdminByReserveId",reserve_id);
			
			reserve.setReviewAdminVO(adminVO);	
			
		}
		
		return list;
	}

	public ReviewCustomerVO getReserveByCustomId(int customer_id) {
		
		ReviewCustomerVO reserve = sqlSession.selectOne("mapper.review.getReserveByCustomId",customer_id);
		
		int reserve_id = reserve.getReserve_id();
		
		ReviewAdminVO adminVO = sqlSession.selectOne("mapper.review.findAdminReserveByreserveId",reserve_id);
		
		reserve.setReviewAdminVO(adminVO);
				
		return reserve;
	}

	public List<Integer> myCustomerList(int member_id) {
		
		return sqlSession.selectList("mapper.review.myCustomerList",member_id);
	}


	public List<ReviewVO> myReviewList(int member_id, int offset, int pageSize) {
		
		Map<String, Integer> paramMap = new HashMap<>();
		
		paramMap.put("memberId", member_id);
		paramMap.put("offset", offset);
		paramMap.put("pageSize", pageSize);
		
		List<ReviewVO> list = sqlSession.selectList("mapper.review.getPagedReviewListByMember",paramMap);
		
	    for(ReviewVO review : list) {
	    	
	    	int customer_id = review.getCustomer_id();
	    	
	    	int memberid = sqlSession.selectOne("mapper.member.findMeberIdByCustomerId",customer_id);
	    	
	    	String userName = sqlSession.selectOne("mapper.member.findNameByMemberId",memberid);
	    	
	    	review.setUserName(userName);
	    }
		
		return list;
	}

	public int getMyReviewCount(HttpServletRequest req) {
		
		MemberVO member = (MemberVO)req.getSession().getAttribute("member");
		
		int memberId = member.getId();
		
		return sqlSession.selectOne("mapper.review.getMyReviewCount",memberId);
	}

}	